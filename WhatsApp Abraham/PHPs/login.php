<?php

    include_once("database.php");

    $database = new Database();
    $db = $database->getConexion();

    try{
    $sql = "SELECT * FROM usuarios WHERE telefono = :telefono";
    $sentencia = $db->prepare($sql);
    $sentencia->bindValue(':telefono', $_POST['t']);
    $sentencia->execute();

    $datos = $sentencia->fetch(PDO::FETCH_ASSOC);
    }catch(PDOException $e){
        $arr = array('estado' => 3, 'error' => $e);
        exit();
    }

    if( $datos){
        $arr = array('estado' => 1, 'datos' => $datos);
        echo json_encode( $arr);
    }else{
        $arr = array('estado' => 0);
        echo json_encode($arr);
    }