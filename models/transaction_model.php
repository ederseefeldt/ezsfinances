<?php
    include_once('../settings/connect_database.php');

    class TransactionModel extends ConnectDatabase{
        private $table;

        function __construct() {
            parent::__construct();
            $this -> table = "transaction";
        }

        function addTransaction() {
            try {
                if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    $transactionMethod = htmlspecialchars($_POST['transactionMethod']);
                    $transactionCategory = htmlspecialchars($_POST['transactionCategory']);
                    $transactionAccount = htmlspecialchars($_POST['transactionAccount']);
                    $transactionDate = htmlspecialchars($_POST['transactionDate']);
                    $transactionValue = htmlspecialchars($_POST['transactionValue']);
                    $transactionDescription = htmlspecialchars($_POST['transactionDescription']);
                    $transactionType = htmlspecialchars($_POST['transactionType']);
        
                    // SQL Query
                    $sql = "INSERT INTO $this->table 
                        (transaction_value, transaction_description, transaction_method, transaction_type, transaction_date, 
                        transaction_category, transaction_account) 
                        VALUES (:transactionValue, :transactionDescription, :transactionMethod, :transactionType, :transactionDate, 
                        :transactionCategory, :transactionAccount)";
                    $stmt = $this->connection->prepare($sql);
                    $stmt->bindParam(':transactionValue', $transactionValue);
                    $stmt->bindParam(':transactionDescription', $transactionDescription);
                    $stmt->bindParam(':transactionMethod', $transactionMethod);
                    $stmt->bindParam(':transactionType', $transactionType);
                    $stmt->bindParam(':transactionDate', $transactionDate);
                    $stmt->bindParam(':transactionCategory', $transactionCategory);
                    $stmt->bindParam(':transactionAccount', $transactionAccount);
        
                    if ($stmt->execute()) {
                        // Sucesso, retorno JSON
                        header('Content-Type: application/json');
                        echo json_encode(array('message' => "Sucesso"));
                    } else {
                        // Erro na execução da query
                        $errorInfo = $stmt->errorInfo();
                        header('Content-Type: application/json');
                        echo json_encode(array('error' => "Erro na inserção: " . $errorInfo[2]));
                    }
                } else {
                    // Se o método não for POST, retorne erro
                    header('Content-Type: application/json');
                    echo json_encode(array('error' => 'Método de requisição inválido'));
                }
            } catch (Exception $e) {
                // Em caso de erro inesperado
                header('Content-Type: application/json');
                echo json_encode(array('error' => 'Erro inesperado: ' . $e->getMessage()));
            }
        }        
        
        function getTransactions() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET') {
                $initialDateTransaction = $_GET['initialDateTransaction'] ?? null;
                $finalDateTransaction = $_GET['finalDateTransaction'] ?? null;
                $categoryTransaction = $_GET['categoryTransaction'] ?? "all";
                $accountTransaction = $_GET['accountTransaction'] ?? "all";
                $methodTransaction = $_GET['methodTransaction'] ?? "all";
        
                // Base da query
                $sql = "
                    SELECT
                        T.transaction_id, 
                        T.transaction_date, 
                        T.transaction_description, 
                        T.transaction_value,
                        C.category_name, 
                        SUM(CASE WHEN T.transaction_type = 0 THEN T.transaction_value ELSE 0 END) AS exits,
                        SUM(CASE WHEN T.transaction_type = 1 THEN T.transaction_value ELSE 0 END) AS entries,
                        SUM(CASE WHEN T.transaction_type = 1 THEN T.transaction_value ELSE 0 END) -
                        SUM(CASE WHEN T.transaction_type = 0 THEN T.transaction_value ELSE 0 END) AS balance
                    FROM transaction T 
                    INNER JOIN category C ON T.transaction_category = C.category_id
                    WHERE T.transaction_date BETWEEN :initialDate AND :finalDate
                ";
        
                // Condicionais dinâmicas
                if ($methodTransaction != "all") {
                    $sql .= " AND T.transaction_method = :methodTransaction";
                }
                if ($categoryTransaction != "all") {
                    $sql .= " AND T.transaction_category = :categoryTransaction";
                }
                if ($accountTransaction != "all") {
                    $sql .= " AND T.transaction_account = :accountTransaction";
                }
        
                // Adiciona GROUP BY
                $sql .= " GROUP BY T.transaction_id";
        
                // Prepara a query
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':initialDate', $initialDateTransaction);
                $stmt->bindParam(':finalDate', $finalDateTransaction);
        
                // Verifica se os valores não são "all" antes de vincular à query
                if ($methodTransaction != "all") {
                    $stmt->bindParam(':methodTransaction', $methodTransaction);
                }
                if ($categoryTransaction != "all") {
                    $stmt->bindParam(':categoryTransaction', $categoryTransaction);
                }
                if ($accountTransaction != "all") {
                    $stmt->bindParam(':accountTransaction', $accountTransaction);
                }
        
                // Executa a query e busca os resultados
                $stmt->execute();
                $resultQuery = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
                // Retorna os dados como JSON
                header('Content-Type: application/json');
                echo json_encode($resultQuery);
            } else {
                // Retorna um erro se o método não for GET
                header('Content-Type: application/json');
                echo json_encode(array('error' => 'Método de requisição inválido'));
            }
        }

        function getTransactionsByCategory() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET') {
                $firstDay = $_GET['firstDay'];
                $lastDay = $_GET['lastDay'];
        
                // Base da query
                $sql = "
                    SELECT 
                        C.category_name, 
                        C.category_target, 
                        SUM(T.transaction_value) AS exits, 
                        (C.category_target - SUM(T.transaction_value)) AS diference 
                    FROM transaction T INNER JOIN category C 
                    ON T.transaction_category = C.category_id 
                    WHERE T.transaction_date BETWEEN :firstDay AND :lastDay
                    GROUP BY C.category_name, C.category_target;
                ";
        
                // Prepara a query
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':firstDay', $firstDay);
                $stmt->bindParam(':lastDay', $lastDay);
        
                // Executa a query e busca os resultados
                $stmt->execute();
                $resultQuery = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
                // Retorna os dados como JSON
                header('Content-Type: application/json');
                echo json_encode($resultQuery);
            } else {
                // Retorna um erro se o método não for GET
                header('Content-Type: application/json');
                echo json_encode(array('error' => 'Método de requisição inválido'));
            }
        }
        
        function deleteTransaction() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['transactionId'])) {
                $transactionId = $_GET['transactionId'];
    
                $sql = "DELETE FROM $this->table WHERE transaction_id = :transactionId;";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':transactionId', $transactionId);
    
                if ($stmt->execute()) {
                    header('Content-Type: application/json');
                    echo json_encode(
                        array(
                            'transactionId' => $transactionId,
                        )
                    );
                } else {
                    // Erro na inserção, retorna null e imprime o erro
                    $errorInfo = $stmt->errorInfo();
                    echo "Erro na exclusão: " . $errorInfo[2];
                }
            } else {
                echo json_encode(array('error' => 'Método de requisição inválido ou ID de categoria não fornecido'));
            }
        }
    }
?>

<?php

$model = new TransactionModel();

if (isset($_GET['action'])) {
    $action = $_GET['action'];
    switch ($action) {
        case 'addTransaction':
            $model->addTransaction();
            break;
        case 'getTransactions':
            $model->getTransactions();
            break;
        case 'deleteTransaction':
            $model->deleteTransaction();
            break;
        case 'getTransactionsByCategory':
            $model->getTransactionsByCategory();
            break;

        default:
            echo json_encode(array('error' => 'Ação inválida'));
    }
} else {
    echo json_encode(array('error' => 'Nenhuma ação especificada'));
}
?>