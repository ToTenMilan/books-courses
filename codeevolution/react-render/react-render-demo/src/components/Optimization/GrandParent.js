import React, { useState } from 'react'
import { ParentOne } from './ParentOne'
import { ChildOne } from './ChildOne'


export const GrandParent = () => {
  const [newCount, setNewCount] = useState(0)
  return (
    <div>
      <button onClick={() => setNewCount((nc) => nc + 1)}>GrandParent Count - {newCount}</button>
      {/* Even if ChildOne is a 'children' prop to ParentOne,
      it will rerender if GrandParent rerenders,
      since GrandParent will force rerendering all of it's children */}
      <ParentOne newCount={newCount}>
        {/* Optimization techinque: */}
        {/* Extract expensive child components from the parent component */}
        {/* and pass them as children to the parent component */}
        <ChildOne />
      </ParentOne>
    </div>
  )
}
