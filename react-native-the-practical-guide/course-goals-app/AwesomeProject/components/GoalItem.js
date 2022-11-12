import { StyleSheet, View, Text, Pressable } from 'react-native';

function GoalItem(props) {
  // This is equivalent to props.onDeleteHandler.bind(this, props.id) on line 10
  // function deleteGoalHandler() {
  //   props.onDeleteHandler(props.id)
  // }

  return (
    <View style={styles.goalItem}>
      <Pressable
        android_ripple={{color: '#5e0acc'}}
        onPress={props.onDeleteHandler.bind(this, props.id)}
        style={({pressed}) => pressed && styles.pressedItem}
      >
        <Text style={styles.goalItemText}>{props.text}</Text>
      </Pressable>
    </View>
  );
};

export default GoalItem;

const styles = StyleSheet.create({
  goalItem: {
    margin: 8,
    borderRadius: 6,
    backgroundColor: '#5e0acc'
  },
  pressedItem: {
    opacity: 0.8
  },
  goalItemText: {
    color: 'white',
    padding: 8,
  }
});