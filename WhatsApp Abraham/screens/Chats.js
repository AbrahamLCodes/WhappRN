
import AsyncStorage from '@react-native-async-storage/async-storage';
import React, {useEffect, useState} from 'react';
import {View, Text, StyleSheet, FlatList, Image, TouchableWithoutFeedback, Button} from 'react-native';
import {FloatingAction} from 'react-native-floating-action';
import { TouchableOpacity } from 'react-native-gesture-handler';
import { Value } from 'react-native-reanimated';

export default function Pantalla ({navigation}) {

    const[data, setData] = useState([]);

    useEffect(() => {
        AsyncStorage.getItem('usr')
        .then((value) => {
            let d = new FormData();
            d.append('idusuario', JSON.parse(value).idusuarios);
            fetch('http://192.168.1.106/ProyectoWhapp/chats.php',
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
        <TouchableOpacity onPress ={() => {navigation.push('Conversacion')}}>
            <View style = {styles.contenedor}>
                <View style={styles.renglon}>
                    <Image source = {{uri : item.foto}} style = {styles.imagen}/>
                    <View style = {styles.contenedor}>
                        <View style = {styles.renglon2}>
                            <Text style={styles.nombre}>{item.nombre}</Text>
                        </View>
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
        </TouchableOpacity>
        );
    
    return(
        <View style={styles.contenedor}>
            <FlatList
            data={data}
            keyExtractor={(item, index) => index.toString()}    
            renderItem={renderItem}/>
            <FloatingAction
                onPressMain = { () => {navigation.push('Contactos')}} style = {styles.contenedor}
                floatingIcon = {require("../images/chat.png")}
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
    renglon2 : {
        flexDirection : 'row',
        flex : 1
    },
    nombre:{
        fontSize: 17,
        fontWeight: 'bold'
    },
    mensaje : {
        color: 'gray'
    },
    hora : {
        fontSize : 10,
        color : 'gray'
    },
    imagen : {
        width: 50,
        height: 50,
        borderRadius: 150 / 2,
        overflow: "hidden",
        marginRight : 20
    },
    derecha : {
        alignItems : 'flex-end',
        flex : 1
    }
});
