import React from 'react';

import {createMaterialTopTabNavigator} from '@react-navigation/material-top-tabs';
import Icon from 'react-native-vector-icons/FontAwesome';

import Camara from './Camara'; 
import Chats from './Chats';
import Estados from './Estados';
import Llamadas from './Llamadas';

/* Navegador */
const Navegador = createMaterialTopTabNavigator();

export default function Pantalla ({navigation}){
    return(
      <Navegador.Navigator
      tabBarOptions = {{
        showIcon : true,
        activeTintColor : 'white',
        style : {
          backgroundColor : '#075e54'
        }
      }}
      
      screenOptions = {({route}) => ({
        tabBarIcon : ({focused, color, size}) => { 
          let nombreIcono = "camera"
          if(route.name === 'Camara'){
            return <Icon 
            name = {nombreIcono} 
            color = {color} 
            size = {20}
            style = {{
                marginTop : 17
            }}/>;
          }
        }})}>
        
        <Navegador.Screen
        name = "Camara"
        component = {Camara}
        options = {{
          tabBarLabel: () => null
        }}/>

        <Navegador.Screen
        name = "Chats"
        component = {Chats}
        options = {{
            tabBarLabel : 'Chats'
          }}/>

        <Navegador.Screen
        name = "Estados"
        component = {Estados}
        options = {{
            tabBarLabel : 'Estados'
          }}/>

        <Navegador.Screen
        name = "Llamadas"
        component = {Llamadas}
        options = {{
            tabBarLabel : 'Llamada'
          }}/>

      </Navegador.Navigator>
    );
}
