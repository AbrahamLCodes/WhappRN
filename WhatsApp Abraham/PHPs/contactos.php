<?php

include_once("database.php");

$database = new Database();
$db = $database->getConexion();

try{
$sql = "SELECT nombre, foto FROM usuarios WHERE idusuarios != :id1";
$sentencia = $db->prepare($sql);
$sentencia->bindValue(':id1', $_POST['idusuario']);
$sentencia->execute();
$chats = $sentencia->fetchAll(PDO::FETCH_ASSOC);

}catch(PDOException $e){
    $arr = array('estado' => 3, 'error' => $e);
    echo json_encode($arr);
    exit();
}


$datos = array();
foreach($chats as $key => $value){
    $datos[] = array(
        'foto' => $value['foto'],
        'nombre' => $value['nombre']
    );
}


if( $datos){
    $arr = array('estado' => 1, 'datos' => $datos);
    echo json_encode( $arr);
}else{
    $arr = array('estado' => 0);
    echo json_encode($arr);
}