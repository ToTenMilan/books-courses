import { useState } from "react";
import { MemoizedChildTwo } from "./ChildTwo";

export const ParentTwo = () => {
  const [count, setCount] = useState(0)
  const [name, setName] = useState('Vishwas')

  console.log('ParentTwo Render');
  return (
    <div>
      <button onClick={() => setCount(c => c + 1)}>Count - {count}</button>
      <button onClick={() => setName('Codevolution')}>Change Name</button>
      {/* Clicking 'Change name' button: */}
      {/* Child component rerender, because parent component rerenderd */}
      {/* NOT because of change in props */}
      {/* THERE IS NO unnecessary render */}
      <MemoizedChildTwo name={name} />
    </div>
  );
}
