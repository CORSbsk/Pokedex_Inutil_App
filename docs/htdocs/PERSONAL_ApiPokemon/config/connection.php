<?php
    class Connect{
        protected $dbh;

        protected function Connection(){
            try{
                $connect = $this->dbh = new PDO(
                    "mysql:local=localhost;dbname=andercode_pokemon",
                    "root",
                    "");
                    return $connect;
            }catch(Exception $e){
               print "!Error DB!: " . $e->getMessage() . "<br/>";
               die();
            }
        }

        protected function set_names(){
            return $this->dbh->query("SET NAMES 'utf8'");
        }
    }
?>