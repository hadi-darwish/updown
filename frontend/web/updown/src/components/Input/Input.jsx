import React from "react";

const Input = ({ label, type }) => {
  return (
    <div className="input-container">
      <p>{label}</p>
      <input type={type} />
    </div>
  );
};

export default Input;
