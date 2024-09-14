<?php
    define('HOST', 'localhost');
    define('DATABASENAME', 'controlmoney');
    define('USER', 'root');
    define('PASSWORD', '');

    class ConnectDatabase {
        protected $connection;

        function __construct()
        {
            $this->connectDatabase();
        }

        function connectDatabase()
        {
            try {
                $this->connection = new PDO('mysql:host='.HOST.';dbname='.DATABASENAME, USER, PASSWORD);
            } 
            catch (PDOException $error) {
                echo "Erro".$error->getMessage();
                die();
            }
        }
    }
?>