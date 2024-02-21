
import './App.css';
import { ArrayUseState } from './components/ImmutableState/ArrayUseState';
import { ObjectUseState } from './components/ImmutableState/ObjectUseState';
import { Parent } from './components/ParentChild/Parent';
// import { UseState } from './components/UseState/UseState';
import { UseReducer } from './components/UseReducer/UseReducer';

function App() {
  return (
    <div className="App">
      {/* <UseState /> */}
      {/* <UseReducer /> */}
      {/* <ObjectUseState /> */}
      {/* <ArrayUseState /> */}
      <Parent />
    </div>
  );
}

export default App;
