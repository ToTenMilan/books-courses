import { useState } from "react";
import { Child } from "./Child";

export const Parent = () => {
  const [count, setCount] = useState(0)
  console.log('Parent Render');
  return (
    <div>
      {/* when parent renders, child component also renders */}
      {/* when state does not change, parent rerender one time only and child wont rerender */}
      <button onClick={() => setCount(c => c + 1)}>Count - {count}</button>
      <button onClick={() => setCount(0)}>Count to 0</button>
      <button onClick={() => setCount(5)}>Count to 5</button>
      <Child />
    </div>
  );
}
