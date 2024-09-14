<?php
    include_once('../settings/connect_database.php');

    class AccountModel extends ConnectDatabase{
        private $table;

        public function __construct() {
            parent::__construct();
            $this -> table = "account";
        }

        function getAccount() {
            $sql = $this->connection->query("SELECT * FROM $this->table");
            $resultQuery = $sql->fetchAll(PDO::FETCH_ASSOC);
    
            // Retorne os dados como JSON
            header('Content-Type: application/json');
            echo json_encode($resultQuery);
        }
        function sumAccounts() {
            $sql = $this->connection->query("SELECT SUM(account_value) AS total_accounts_value FROM $this->table");
            $resultQuery = $sql->fetchAll(PDO::FETCH_ASSOC);
    
            // Retorne os dados como JSON
            echo json_encode($resultQuery);
        }

        public function addAccount() {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $accountName = $_POST['accountName'];
                $accountValue = $_POST['accountValue'];
                
                // Chama a função addUser no modelo
                $sql = "INSERT INTO $this->table (account_name, account_value) VALUES (:accountName, :accountValue)";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':accountName', $accountName);
                $stmt->bindParam(':accountValue', $accountValue);
            
                if ($stmt->execute()) {
                    echo json_encode(
                        array(
                            'accountName' => $accountName,
                            'accountValue' => $accountValue
                        )
                    );
                } else {
                    // Erro na inserção, retorna null e imprime o erro
                    $errorInfo = $stmt->errorInfo();
                    echo "Erro na inserção: " . $errorInfo[2];
                    return null;
                }
            }
        }

        function getAccountById() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accountId'])) {
                $accountId = $_GET['accountId'];
        
                $sql = "SELECT * FROM $this->table WHERE account_id = :accountId";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':accountId', $accountId);
        
                if ($stmt->execute()) {
                    $resultQuery = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
                    // Retorne os dados como JSON
                    header('Content-Type: application/json');
                    echo json_encode($resultQuery);
                } else {
                    // Erro na execução da consulta
                    $errorInfo = $stmt->errorInfo();
                    echo json_encode(array('error' => "Erro na execução da consulta: " . $errorInfo[2]));
                }
            } else {
                echo json_encode(array('error' => 'Método de requisição inválido ou ID de categoria não fornecido'));
            }
        }

        function deleteAccount() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accountId'])) {
                $accountId = $_GET['accountId'];

                $sql = "DELETE FROM $this->table WHERE account_id = :accountId;";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':accountId', $accountId);

                if ($stmt->execute()) {
                    header('Content-Type: application/json');
                    echo json_encode(
                        array(
                            'accountId' => $accountId,
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

        function editAccount() {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $accountId = $_POST['accountId'] ?? null;
                $accountName = $_POST['accountName'] ?? null;
                $accountValue = $_POST['accountValue'] ?? null;
    
                if ($accountName && $accountValue) {
                    $sql = "UPDATE $this->table SET account_name = :accountName, account_value = :accountValue WHERE account_id = :accountId";
                    $stmt = $this->connection->prepare($sql);
                    $stmt->bindParam(':accountId', $accountId);
                    $stmt->bindParam(':accountName', $accountName);
                    $stmt->bindParam(':accountValue', $accountValue);
    
                    if ($stmt->execute()) {
                        header('Content-Type: application/json');
                        echo json_encode(
                            array(
                                'accountName' => $accountName,
                                'accountValue' => $accountValue
                            )
                        );
                    } else {
                        // Erro na inserção, retorna null e imprime o erro
                        $errorInfo = $stmt->errorInfo();
                        echo "Erro na inserção: " . $errorInfo[2];
                        return null;
                    }
                } else {
                    echo json_encode(array('error' => 'Dados incompletos'));
                }
            }
        }
    }
?>

<?php

$model = new AccountModel();

if (isset($_GET['action'])) {
    $action = $_GET['action'];
    switch ($action) {
        case 'getAccount':
            $model->getAccount();
            break;
        case 'addAccount':
            $model->addAccount();
            break;
        case 'getAccountById':
            $model->getAccountById();
            break;
        case 'editAccount':
            $model->editAccount();
            break;
        case 'sumAccounts':
            $model->sumAccounts();
            break;
        case 'deleteAccount':
            $model->deleteAccount();
            break;
        default:
            echo json_encode(array('error' => 'Ação inválida'));
    }
} else {
    echo json_encode(array('error' => 'Nenhuma ação especificada'));
}
?>