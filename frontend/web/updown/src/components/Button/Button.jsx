import React from "react";
import "./Button.css";

const Button = ({ width, mode, onClick, text }) => {
  return (
    <button
      className={`button-${mode}`}
      style={{ width: width }}
      onClick={onClick}
    >
      {text}
    </button>
  );
};

export default Button;
