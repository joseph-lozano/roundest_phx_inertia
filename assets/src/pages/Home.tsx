import { useState } from "react"

export default function Home() {
  const [count, setCount] = useState(0)
  return <div className="flex flex-col items-center justify-center h-screen gap-8">
    <h1 className="text-5xl text-indigo-700 font-black">Home</h1>
    <div className="flex gap-4 items-center">
      <button className="bg-indigo-700 text-white px-4 py-2 rounded-md" onClick={() => setCount(count - 1)}>Decrement</button>
      <p className="text-2xl font-bold">Count: {count}</p>
      <button className="bg-indigo-700 text-white px-4 py-2 rounded-md" onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  </div>
}
