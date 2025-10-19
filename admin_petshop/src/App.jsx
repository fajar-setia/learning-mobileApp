import { useState } from 'react'
import './App.css'
import { Route, Routes } from 'react-router-dom'
import AdminPetshop from './pages/adminPetshop.jsx'

function App() {


  return (
    <>
      <Routes>
        <Route path='/' element={< AdminPetshop/>} />
      </Routes>
    </>
  )
}

export default App
