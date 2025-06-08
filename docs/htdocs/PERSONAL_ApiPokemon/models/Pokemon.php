<?php
    class Pokemon extends Connect{
        public function get_pokemon(){
            $connect = parent::Connection();
            parent::set_names();
            $sql = "SELECT * FROM tm_pokemon;";
            $sql = $connect->prepare($sql);
            $sql -> execute();
            return $result = $sql -> fetchAll(pdo::FETCH_ASSOC);
        }

    }
?>