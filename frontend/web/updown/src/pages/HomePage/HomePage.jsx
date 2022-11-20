import React from "react";
import Button from "../../components/Button/Button";
import "./HomePage.css";
import Dropdown from "react-dropdown";
import "react-dropdown/style.css";
import ReactDropdown from "react-dropdown";
import { DropDownList } from "@progress/kendo-react-dropdowns";

const HomePage = () => {
  return (
    <div className="home-container">
      <h1>Home</h1>
      <div className="building-info">
        <div>Building Name</div>
        <div>Tax = $10</div>
        <div>Price/Travel = $0.3</div>
        <div>
          <Button
            mode={"primary"}
            onClick={null}
            text={"Edit"}
            width={"small"}
          />
        </div>
      </div>
      <div className="building-info">
        <div>Elevator Status</div>
        <div>
          <Button mode={"primary"} onClick={null} text={"ON"} width={"small"} />
        </div>
      </div>
      <h1>Notify Residents</h1>

      <h2>Message</h2>

      <textarea
        className="message"
        placeholder="Enter message here"
        rows="4"
        cols="50"
      />
      <div className="button">
        <Button mode={"primary"} onClick={null} text={"Send"} width={"big"} />
      </div>
    </div>
  );
};

export default HomePage;
