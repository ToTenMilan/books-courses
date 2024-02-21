import { useState } from "react";
import { MemoizedChildThree } from "./ChildThree";

export const ParentThree = () => {
  const [count, setCount] = useState(0)
  const [name, setName] = useState('Vishwas')

  console.log('ParentThree Render');
  return (
    <div>
      <button onClick={() => setCount(c => c + 1)}>Count - {count}</button>
      <button onClick={() => setName('Codevolution')}>Change Name</button>
      No need to wrap component in a memo, if the 'Child' itself has children elements
      Because, React.memo only does a shallow comparison of props and if the props are objects,
      it will always re-render
      <MemoizedChildThree name={name}>
        <strong>Hello</strong>
      </MemoizedChildThree>
    </div>
  );
}
