import React from 'react';
import {View, Text, Button, StyleSheet} from 'react-native';

export default function Pantalla ({navigation}) {
    return(
        <View style = {styles.container}>
            <Text style = {styles.texto}>Pantalla Camaras</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    container : {
        backgroundColor : 'black',
        flex : 1,
        alignItems : 'center',
        justifyContent : 'center'
    },
    texto : {
        color : 'white'
    }
})