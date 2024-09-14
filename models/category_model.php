<?php
    require_once '../settings/connect_database.php';

    class CategoryModel extends ConnectDatabase {
        private $table;

        public function __construct() {
            parent::__construct();
            $this->table = "category";
        }

        // Função para listar categorias
        function getCategory() {
            $sql = $this->connection->query("SELECT * FROM $this->table");
            $resultQuery = $sql->fetchAll(PDO::FETCH_ASSOC);

            // Retorna os dados como JSON
            header('Content-Type: application/json');
            echo json_encode($resultQuery);
        }

        function getCategoryById() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['categoryId'])) {
                $categoryId = $_GET['categoryId'];
        
                $sql = "SELECT * FROM $this->table WHERE category_id = :categoryId";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':categoryId', $categoryId);
        
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

        // Função para adicionar categoria
        function addCategory() {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $categoryName = $_POST['categoryName'] ?? null;
                $categoryTarget = $_POST['categoryTarget'] ?? null;

                // Validação dos campos
                if ($categoryName && $categoryTarget) {
                    $sql = "INSERT INTO $this->table (category_name, category_target) VALUES (:categoryName, :categoryTarget)";
                    $stmt = $this->connection->prepare($sql);
                    $stmt->bindParam(':categoryName', $categoryName);
                    $stmt->bindParam(':categoryTarget', $categoryTarget);

                    // Execução da inserção
                    if ($stmt->execute()) {
                        header('Content-Type: application/json');
                        echo json_encode(array(
                            'categoryName' => $categoryName,
                            'categoryTarget' => $categoryTarget
                        ));
                    } else {
                        $errorInfo = $stmt->errorInfo();
                        echo json_encode(array('error' => 'Erro na inserção: ' . $errorInfo[2]));
                    }
                } else {
                    // Retorna erro de dados incompletos
                    header('Content-Type: application/json');
                    echo json_encode(['error' => 'Dados incompletos']);
                }
            } else {
                // Retorna erro de método inválido
                header('Content-Type: application/json');
                echo json_encode(['error' => 'Método inválido']);
            }
        }

        function deleteCategory() {
            if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['categoryId'])) {
                $categoryId = $_GET['categoryId'];

                $sql = "DELETE FROM $this->table WHERE category_id = :categoryId;";
                $stmt = $this->connection->prepare($sql);
                $stmt->bindParam(':categoryId', $categoryId);

                if ($stmt->execute()) {
                    header('Content-Type: application/json');
                    echo json_encode(
                        array(
                            'categoryId' => $categoryId,
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

        function editCategory() {
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $categoryName = $_POST['categoryName'] ?? null;
                $categoryTarget = $_POST['categoryTarget'] ?? null;
                $categoryId = $_POST['categoryId'] ?? null;

                if ($categoryName && $categoryTarget) {
                    $sql = "UPDATE $this->table SET category_name = :categoryName, category_target = :categoryTarget WHERE category_id = :categoryId";
                    $stmt = $this->connection->prepare($sql);
                    $stmt->bindParam(':categoryId', $categoryId);
                    $stmt->bindParam(':categoryName', $categoryName);
                    $stmt->bindParam(':categoryTarget', $categoryTarget);

                    if ($stmt->execute()) {
                        header('Content-Type: application/json');
                        echo json_encode(
                            array(
                                'categoryName' => $categoryName,
                                'categoryTarget' => $categoryTarget
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

    // Instancia a classe CategoryModel
    $model = new CategoryModel();

    // Verifica qual ação foi passada pela URL
    if (isset($_GET['action'])) {
        $action = $_GET['action'];

        switch ($action) {
            case 'getCategory':
                $model->getCategory();
                break;

            case 'getCategoryById':
                $model->getCategoryById();
                break;

            case 'addCategory':
                $model->addCategory();
                break;

            case 'deleteCategory':
                $model->deleteCategory();
                break;

            case 'editCategory':
                $model->editCategory();
                break;

            default:
                // Retorna erro para ação inválida
                header('Content-Type: application/json');
                echo json_encode(['error' => 'Ação inválida']);
                break;
        }
    } else {
        // Retorna erro se nenhuma ação for especificada
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Nenhuma ação especificada']);
    }
?>