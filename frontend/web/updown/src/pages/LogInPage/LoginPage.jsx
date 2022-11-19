import React from "react";
import Button from "../../components/Button/Button";
import Input from "../../components/Input/Input";
import TopBar from "../../components/TopBar/TopBar";

const LoginPage = () => {
  return (
    <>
      <TopBar />
      <div className="login">
        <Input
          type={"email"}
          label={"email"}
          placeholder={"Enter your Email"}
        />
        <Input
          type={"password"}
          label={"password"}
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
