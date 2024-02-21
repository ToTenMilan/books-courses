
import './App.css';
import { ArrayUseState } from './components/ImmutableState/ArrayUseState';
import { ObjectUseState } from './components/ImmutableState/ObjectUseState';
import { ChildOne } from './components/Optimization/ChildOne';
import { GrandParent } from './components/Optimization/GrandParent';
import { ParentOne } from './components/Optimization/ParentOne';
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
      {/* <Parent /> */}
      {/* <ParentOne>
        <ChildOne />
      </ParentOne> */}
      <GrandParent />
    </div>
  );
}

export default App;
