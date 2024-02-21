import { useState } from "react";

export const ParentOne = ({ children }) => {
  const [count, setCount] = useState(0)
  console.log('ParentOne Render');
  return (
    <div>
      <button onClick={() => setCount(c => c + 1)}>Count - {count}</button>
      {/* NO Unneccesary rendre */}
      {/* Children wont rerender when parent state changes */}
      {/* Children is a prop so it could not change. Rreact knows that and is not "unneccesary rerendering" the children */}
      {children}
    </div>
  );
}
