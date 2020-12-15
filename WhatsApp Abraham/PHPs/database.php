<?php 
class Database{
    public $con;

    public function getConexion(){
        $this -> con = null;
        try{
            $this -> con = new PDO("mysql:host=127.0.0.1;dbname=whatsapp","root","");
        }catch(PDOException $e){
            echo "Error: ".$e->getMessage();
        }
        return $this -> con;
    }
}