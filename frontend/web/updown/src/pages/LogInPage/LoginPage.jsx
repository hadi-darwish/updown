import React, { useState } from "react";
import Button from "../../components/Button/Button";
import Input from "../../components/Input/Input";
import TopBar from "../../components/TopBar/TopBar";
import "./LoginPage.css";
import request from "../../config/axios";
import { useNavigate } from "react-router-dom";

const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const SignUp = () => {
    const data = {
      email,
      password,
    };
    request({
      method: "post",
      url: "login",
      data,
    })
      .then((response) => {
        console.log(response);
        localStorage.setItem("token", response.token);
        localStorage.setItem("user", JSON.stringify(response.result));
        navigate("/home");
      })
      .catch((error) => {
        console.log(error);
      });
  };
  return (
    <>
      <TopBar />
      <div className="login-container">
        <div className="login">
          <Input
            type={"email"}
            label={"Email"}
            placeholder={"Enter your Email"}
            onChange={(e) => setEmail(e.target.value)}
          />
          <Input
            type={"password"}
            label={"Password"}
            placeholder={"Enter your Password"}
            onChange={(e) => setPassword(e.target.value)}
          />
          <Button
            mode={"primary"}
            onClick={SignUp}
            text={"Signup"}
            width={"big"}
          />
        </div>
      </div>
    </>
  );
};

export default LoginPage;
