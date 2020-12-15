import React, { useState } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {
    View, 
    Text, 
    TextInput, 
    TouchableOpacity, 
    StyleSheet} from 'react-native';

export default function LoginScreen({navigation}){

    const[telefono,setTelefono] = useState('');  
    const login = () => {

      let data = new FormData();
      data.append('t',telefono);
      
      fetch('http://192.168.1.106/ProyectoWhapp/login.php',
      {
        method: 'POST',
        body: data
      })
      .then((response) =>  response.json())
      .then((datos) => {
            if(datos.estado == 1){ 
                AsyncStorage.setItem('usr', JSON.stringify(datos.datos));
                navigation.navigate('Main');
            }else{
                console.log("El usuario no existe")
            }
        }).catch((error) => console.log(error));
    };

    return(
        <View style = {styles.container}>
            <TextInput 
            style = {styles.entrada}
            placeholder = "Telefono"
            placeholderTextColor = "black"
            onChangeText={(usertelefono) => setTelefono(usertelefono)}/>


            <TouchableOpacity style = {styles.boton} onPress={login}>
                <Text style = {{color : 'white', fontSize : 20, fontWeight: 'bold'}}> Login </Text>
            </TouchableOpacity>
        </View>
                
    );
}

const styles = StyleSheet.create({

    container : {
        flex : 1,
        justifyContent : 'center',
        alignItems : 'center'
    },
    entrada: {
        borderWidth : 1,
        borderColor : "black",
        width : '90%',
        margin : 15,
        height : 40,
    },
    boton : {
        backgroundColor : 'black',
        margin : 15,
        height : 40,
        width : 150,
        alignItems : 'center',
        justifyContent : 'center'
    }
});