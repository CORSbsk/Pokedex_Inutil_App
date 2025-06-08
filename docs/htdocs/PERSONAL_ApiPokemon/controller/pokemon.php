<?php
    require_once("../config/connection.php");
    require_once("../models/Pokemon.php");
    $pokemon = new Pokemon();

    switch($_GET["op"]){
        case "list":
            $data=$pokemon->get_pokemon();
            if(is_array($data)==true and count($data)>0){
                $results=array(
                    "results"=>$data
                );
                echo json_encode($results);
            }
            break;
    }   
?>