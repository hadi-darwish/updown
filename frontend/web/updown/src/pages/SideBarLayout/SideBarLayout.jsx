import React from "react";
import { Outlet } from "react-router-dom";
import SideBar from "../../components/SideBar/SideBar";
import "./SideBarLayout.css";
const SideBarLayout = () => {
  return (
    <>
      <SideBar />
      <div className="big-container outlet">
        <Outlet />
      </div>
    </>
  );
};

export default SideBarLayout;
