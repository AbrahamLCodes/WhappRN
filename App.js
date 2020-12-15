import React from 'react';

/* Dependencias */
import { NavigationContainer } from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';

/* Pantallas */
import Login from './screens/Login';
import Contactos from './screens/Contactos';
import Main from './screens/Main'
import Conversacion from './screens/Conversacion';

const Stack = createStackNavigator();

export default function App(){
  return(
    <NavigationContainer>
      <Stack.Navigator>

      <Stack.Screen 
        name = "Login" 
        component = {Login} 
        options = {
          {
            headerShown : false
          }
        }/>

        <Stack.Screen 
        name = "Main" 
        component = {Main} 
        options = {
          {
            title: 'WhatsApp',
            headerTitleStyle : {
              color : 'white'
            },
            headerStyle : {
              backgroundColor : '#075e54'
            },
            headerTintColor : 'white'
          }
        }/>

        <Stack.Screen 
        name = "Contactos" 
        component = {Contactos}
        options = {
          {
            title: 'Contactos',
            headerTitleStyle : {
              color : 'white'
            },
            headerStyle : {
              backgroundColor : '#075e54'
            },
            headerTintColor : 'white'
          }
        }/>

        <Stack.Screen 
        name = "Conversacion" 
        component = {Conversacion}
        options = {
          {
            title: 'Conversacion',
            headerTitleStyle : {
              color : 'white'
            },
            headerStyle : {
              backgroundColor : '#075e54'
            },
            headerTintColor : 'white'
          }
        }/>
      </Stack.Navigator>
    </NavigationContainer>
  );
}