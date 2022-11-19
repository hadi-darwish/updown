import "./App.css";
import TopBar from "./components/TopBar/TopBar";
import Input from "./components/Input/Input";
import LoginPage from "./pages/LogInPage/LoginPage";
import { BrowserRouter, Route, Routes } from "react-router-dom";

function App() {
  return (
    <>
      <BrowserRouter>
        <div className="App">
          <Routes>
            <Route path="/" element={<LoginPage />} />
          </Routes>
        </div>
      </BrowserRouter>
    </>
  );
}

export default App;
