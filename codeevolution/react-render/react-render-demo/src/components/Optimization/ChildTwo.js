import React from 'react'

export const ChildTwo = () => {
  console.log('ChildTwo Render');
  return (
    <div>
      Child component
    </div>
  )
}

export const MemoizedChildTwo = React.memo(ChildTwo) // React.memo is a higher order component
