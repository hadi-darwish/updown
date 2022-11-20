import "./App.css";
import LoginPage from "./pages/LogInPage/LoginPage";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import SideBar from "./components/SideBar/SideBar";
import SideBarLayout from "./pages/SideBarLayout/SideBarLayout";
import HomePage from "./pages/HomePage/HomePage";

function App() {
  return (
    <>
      <BrowserRouter>
        <div className="App">
          <Routes>
            <Route path="/" element={<LoginPage />} />
            <Route element={<SideBarLayout />}>
              <Route path="/home" element={<HomePage />} />
              <Route path="/stats" element={<h1>Stats</h1>} />
              <Route path="/access" element={<h1>Access</h1>} />
            </Route>
          </Routes>
        </div>
      </BrowserRouter>
    </>
  );
}

export default App;
