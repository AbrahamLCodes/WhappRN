import React, {useEffect, useState} from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {View, Text, Button, FlatList, StyleSheet, Image} from 'react-native';
import {FloatingAction} from 'react-native-floating-action';


//import data from '../jsons/estados.json';

export default function Pantalla ({navigation}) {

    const[data, setData] = useState([]);

    useEffect(() => {
        AsyncStorage.getItem('usr')
        .then((value) => {
            let d = new FormData();
            d.append('idusuario', JSON.parse(value).idusuarios);
            fetch('http://192.168.1.106/ProyectoWhapp/estados.php',
            {
                method : 'POST',
                body : d
            })
            .then((response) => response.json())
            .then((datos) => {
                console.log("MOSTRANDO DATOS");
                console.log(datos);
                if(datos.estado == 1){
                    setData(datos.datos);
                }else{
                    console.log("El usuario no existe");
                }
            })
            .catch((error) => console.log(error));
        })
    },[]);
     
    const renderItem = ({item}) => (
        <View>
            <View style={styles.renglon}>
                <Image source = {{uri : item.foto}} style = {styles.imagen}/>
                <View>
                    <Text style={styles.nombre}>{item.nombre}</Text>
                    <Text style={styles.tiempo}>{item.hora}</Text>
                </View>
            </View>
            <View
                style={{
                    borderBottomColor: '#E3E1E0',
                    borderBottomWidth: 1,
                    marginRight : 10,
                    marginLeft: 80,
                }}/> 
        </View>
    );

    return(
        <View style={styles.contenedor}>
            <FlatList
            data={data}
            renderItem={renderItem}
            keyExtractor={(item, index) => index.toString()}    
            />

                <FloatingAction
                actions = {actions}
                onPressItem = { name => {
                    console.log(`selected button: ${name}`);
                }}
                floatingIcon = {require("../images/camera.png")}
                color = '#075e54'/>   
        </View>
    );    
}

const styles = StyleSheet.create({
    contenedor: {
        flex:1
    },
    renglon:{
        borderColor: '#f1f1f1',
        borderBottomWidth: 5,
        flexDirection: 'row',
        marginLeft: 10,
        marginRight: 10,
        marginTop: 15,
        paddingBottom: 15
    },
    nombre:{
        fontWeight : 'bold',
        fontSize : 17
    },
    tiempo:{
        color: 'gray'
    },
    imagen : {
        width: 50,
        height: 50,
        borderRadius: 150 / 2,
        overflow: "hidden",
        marginRight : 20
    }
});

const actions = [
    {
      text: "Chat",
      icon: require("../images/chat.png"),
      name: "btnChat",
      position: 2
    },
    {
      text: "Estados",
      icon: require("../images/camera.png"),
      name: "btnEstados",
      position: 1
    },
    {
      text: "Llamadas",
      icon: require("../images/telephone.png"),
      name: "btnLlamadas",
      position: 3
    }
  ];