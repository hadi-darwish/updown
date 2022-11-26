import "./App.css";
import LoginPage from "./pages/LogInPage/LoginPage";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import SideBar from "./components/SideBar/SideBar";
import SideBarLayout from "./pages/SideBarLayout/SideBarLayout";
import HomePage from "./pages/HomePage/HomePage";
import StatsPage from "./pages/StatsPAge/StatsPage";
import AccessPage from "./pages/AccessPage/AccessPage";

function App() {
  return (
    <>
      <BrowserRouter>
        <div className="App">
          <Routes>
            <Route path="/" element={<LoginPage />} />
            <Route element={<SideBarLayout />}>
              <Route path="/home" element={<HomePage />} />
              <Route path="/stats" element={<StatsPage />} />
              <Route path="/access" element={<AccessPage />} />
            </Route>
          </Routes>
        </div>
      </BrowserRouter>
    </>
  );
}

export default App;
