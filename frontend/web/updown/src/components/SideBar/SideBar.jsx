import MaterialIcon from "material-icons-react";
import React, { useEffect, useLayoutEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import logo from "../../assets/logo.svg";
import "./SideBar.css";
const SideBar = () => {
  const [activeHome, setActiveHome] = useState("active");
  const [activeStats, setActiveStats] = useState("inactive");
  const [activeAccess, setActiveAccess] = useState("inactive");
  useLayoutEffect(() => {
    if (window.location.pathname === "/home") {
      setActiveHome("active");
      setActiveStats("inactive");
      setActiveAccess("inactive");
    } else if (window.location.pathname === "/stats") {
      setActiveHome("inactive");
      setActiveStats("active");
      setActiveAccess("inactive");
    } else if (window.location.pathname === "/access") {
      setActiveHome("inactive");
      setActiveStats("inactive");
      setActiveAccess("active");
    }
  }, [window.location.pathname]);

  return (
    <>
      <div className="sidebar">
        <div className="logo-container">
          <img src={logo} alt="logo" />
        </div>
        <div className="sidebar-menu">
          <Link
            to={"/home"}
            onClick={() => {
              setActiveHome("active");
              setActiveStats("inactive");
              setActiveAccess("inactive");
              //   console.log(active);
            }}
          >
            <div
              className={`sidebar-menu-item
            ${activeHome}
            `}
            >
              <div className="sidebar-menu-item-icon">
                <MaterialIcon icon="home" size={"large"} color="#ffffff" />
              </div>
              <div
                className={`sidebar-menu-item-text ${activeHome}
            `}
              >
                Home
              </div>
            </div>
          </Link>

          <Link
            to={"/stats"}
            onClick={() => {
              setActiveHome("inactive");
              setActiveStats("active");
              setActiveAccess("inactive");
            }}
          >
            <div className={`sidebar-menu-item ${activeStats}`}>
              <div className="sidebar-menu-item-icon">
                <MaterialIcon icon="bar_chart" size={"large"} color="#ffffff" />
              </div>
              <div
                className={`
                sidebar-menu-item-text ${activeStats}
              `}
              >
                Stats
              </div>
            </div>
          </Link>

          <Link
            to={"access"}
            onClick={() => {
              setActiveHome("inactive");
              setActiveStats("inactive");
              setActiveAccess("active");
              //   console.log(active);
            }}
          >
            <div className={`sidebar-menu-item ${activeAccess}`}>
              <div className="sidebar-menu-item-icon">
                <MaterialIcon
                  icon="accessibility"
                  size={"large"}
                  color="#ffffff"
                />
              </div>
              <div
                className={`
                sidebar-menu-item-text ${activeAccess}
              `}
              >
                Accessibility
              </div>
            </div>
          </Link>
        </div>
      </div>
    </>
  );
};

export default SideBar;
