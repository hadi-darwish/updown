import React from "react";
import Button from "../../components/Button/Button";
import Input from "../../components/Input/Input";
import TopBar from "../../components/TopBar/TopBar";
import "./LoginPage.css";

const LoginPage = () => {
  return (
    <>
      <TopBar />
      <div className="login">
        <Input
          type={"email"}
          label={"Email"}
          placeholder={"Enter your Email"}
        />
        <Input
          type={"password"}
          label={"Password"}
          placeholder={"Enter your Password"}
        />
        <Button
          mode={"primary"}
          onClick={null}
          text={"Signup"}
          width={"31rem"}
        />
      </div>
    </>
  );
};

export default LoginPage;
