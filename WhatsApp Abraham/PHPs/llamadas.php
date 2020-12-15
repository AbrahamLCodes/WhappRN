<?php

include_once("database.php");

$database = new Database();
$db = $database->getConexion();

try{
$sql = "SELECT idllamada, fechahora, usuarios_idusuarios, foto, nombre FROM llamada INNER JOIN usuarios ON usuarios_idusuarios=idusuarios WHERE usuarios_idusuarios != :id1 ORDER BY idllamada";
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
        'fecha' => $value['fechahora'],
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