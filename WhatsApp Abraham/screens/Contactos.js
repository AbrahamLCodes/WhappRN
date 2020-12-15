import React, {useEffect, useState} from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {View, Text, StyleSheet, FlatList, Image} from 'react-native';
//import Data from '../jsons/chats.json'

export default function Pantalla ({navigation}) {

    const[data, setData] = useState([]);

    useEffect(() => {
        AsyncStorage.getItem('usr')
        .then((value) => {
            let d = new FormData();
            d.append('idusuario', JSON.parse(value).idusuarios);
            fetch('http://192.168.1.106/ProyectoWhapp/contactos.php',
            {
                method : 'POST',
                body : d
            })
            .then((response) => response.json())
            .then((datos) => {
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
        <View style = {styles.contenedor}>
            <View style={styles.renglon}>
                <Image source = {{uri : item.foto}} style = {styles.imagen}/>
                <View style = {styles.contenedor}>
                    <Text style={styles.nombre}>{item.nombre}</Text>
                </View>
            </View>         
        </View>              
    );

    return (
        <View style = {styles.container}>
            <FlatList
            ListHeaderComponent = {
                <>
                    <View style={styles.renglon}>
                        <Image source = {require('../images/group.png')} style = {styles.imagen}/>
                        <View style = {styles.contenedor}>
                            <Text style={styles.nombre}>Nuevo grupo</Text>
                        </View>
                    </View>
                    <View style={styles.renglon}>
                        <Image source = {require('../images/contact-book.png')} style = {styles.imagen}/>
                        <View style = {styles.contenedor}>
                            <Text style={styles.nombre}>Nuevo contacto</Text>
                        </View>
                    </View>
                </>
            }
            data={data}
            keyExtractor={(item, index) => index.toString()}    
            renderItem={renderItem}/>
        </View>
    );
}

const styles = StyleSheet.create({
    container : {
        flex : 1
    },
    renglon:{
        borderColor: '#f1f1f1',
        borderBottomWidth: 5,
        flexDirection: 'row',
        marginLeft: 10,
        marginRight: 10,
        marginTop: 15
    },
    renglon2 : {
        flexDirection : 'row',
        flex : 1
    },
    nombre:{
        fontSize: 17,
        fontWeight: 'bold'
    },
    imagen : {
        width: 50,
        height: 50,
        borderRadius: 150 / 2,
        overflow: "hidden",
        marginRight : 20
    },
    mensaje : {
        color: 'gray'
    }
}); 