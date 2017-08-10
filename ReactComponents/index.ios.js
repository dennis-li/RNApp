'use strict'
import React from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    NativeModules,
    View,
    TouchableOpacity,
} from 'react-native';

class RNApp extends React.Component {

    _onPressButton() {
      NativeModules.TSMethod.addEvent('react native');

    }

    _test(data) {
        data.map((param) => {
            console.warn(param)
        })
    }

    _onPress() {
      let params = JSON.stringify({
          "action":"hello",
          "params":{"message":"react native message"},
      })

        NativeModules.TSMethod.schemaParams(params,
            (data) => {
          let result = JSON.parse(data)
          console.warn(result)
          console.warn(result.react)
        },
            (data) => {
                console.warn(data)
                console.warn(data.hello)
        })
    }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={this._onPressButton}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={this._onPress.bind(this)}>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        </TouchableOpacity>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

//  项目名要有所对应
AppRegistry.registerComponent('RNApp', () => RNApp);
