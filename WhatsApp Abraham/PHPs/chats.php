<?php

include_once("database.php");

$database = new Database();
$db = $database->getConexion();

try{
$sql = "SELECT usuarios.nombre, usuarios.foto, usuarios_has_conversacion.conversacion_idconversacion as idconversacion FROM usuarios JOIN usuarios_has_conversacion ON usuarios.idusuarios = usuarios_has_conversacion.usuarios_idusuarios JOIN (SELECT conversacion_idconversacion FROM usuarios_has_conversacion WHERE usuarios_idusuarios = :id1) AS c ON c.conversacion_idconversacion = usuarios_has_conversacion.conversacion_idconversacion WHERE usuarios_idusuarios != :id2";
$sentencia = $db->prepare($sql);
$sentencia->bindValue(':id1', $_POST['idusuario']);
$sentencia->bindValue(':id2', $_POST['idusuario']);
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
        'nombre' => $value['nombre'],
        'foto' => $value['foto'],
        'idconversacion' => $value['idconversacion']
    );
}


if( $datos){
    $arr = array('estado' => 1, 'datos' => $datos);
    echo json_encode( $arr);
}else{
    $arr = array('estado' => 0);
    echo json_encode($arr);
}