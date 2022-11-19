import React from "react";
import "./Input.css";

const Input = ({ label, type, placeholder }) => {
  return (
    <div className="input-container">
      <p className="input-label">{label}</p>
      <input className="input" type={type} placeholder={placeholder} />
    </div>
  );
};

export default Input;
