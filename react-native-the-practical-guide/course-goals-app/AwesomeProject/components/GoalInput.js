import { useState } from 'react';
import { StyleSheet, View, TextInput, Button, Modal, Image } from 'react-native';

function GoalInput(props) {
  const [enteredGoalText, setEnteredGoalText] = useState('')

  function goalInputHandler(enteredText) {
    setEnteredGoalText(enteredText)
  }

  function addGoalHandler() {
    props.onAddGoal(enteredGoalText);
    setEnteredGoalText('');
  };

  return (
    <Modal visible={props.visible} animationType={'slide'} >
      <View style={styles.inputContainer}>
        <Image source={require('../assets/images/goal.png')} style={styles.image}/>
        <TextInput
          style={styles.textInput}
          placeholder='Your course goal'
          onChangeText={goalInputHandler}
          value={enteredGoalText}
        />
        <View style={styles.buttonContainer}>

          <View style={styles.button}>
            <Button title='Cancel' onPress={props.onCancel} color='#f31282' />
          </View>
          <View style={styles.button}>
            <Button title='Add goal' onPress={addGoalHandler} color='#b180f0'/>
          </View>
        </View>

      </View>
    </Modal>
  )
};

export default GoalInput;

const styles = StyleSheet.create({
  inputContainer: {
    flex: 1,
    padding: 16,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#311b6b'
  },
  image: {
    width: 100,
    height: 100,
    margin: 20
  },
  textInput: {
    width: '100%',
    borderWidth: 1,
    borderColor: '#e4d0ff',
    color: '#120438',
    backgroundColor: '#e4d0ff',
    borderRadius: 6,
    padding: 8
  },
  buttonContainer: {
    marginTop: 16,
    flexDirection: 'row', // two buttons next to each other
  },
  button: {
    width: '30%',
    marginHorizontal: 8
  }
});