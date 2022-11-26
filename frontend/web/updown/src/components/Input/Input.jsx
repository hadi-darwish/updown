import React from "react";
import "./Input.css";

const Input = ({ label, type, placeholder, onChange }) => {
  return (
    <div className="input-container">
      <div className="center">
        {" "}
        <label className="input-label">{label}</label>
        <input
          className="input"
          type={type}
          placeholder={placeholder}
          onChange={onChange}
        />
      </div>
    </div>
  );
};

export default Input;
