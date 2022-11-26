import React, { useEffect, useState } from "react";
import Popup from "reactjs-popup";
import Button from "../Button/Button";
import Input from "../Input/Input";
import "reactjs-popup/dist/index.css";
import "./UserCard.css";
import request from "../../config/axios";

const UserCard = ({ user, remove }) => {
  const [newPassword, setNewPassword] = useState("");
  const [ban, setBan] = useState(user.is_banned);
  const [edit, setEdit] = useState(false);

  const toggleBan = () => {
    request({
      method: "post",
      url: "ban_user",
      data: {
        user_id: user.id,
      },
    })
      .then((response) => {
        console.log(response);
        setBan(!ban);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const deleteUser = () => {
    request({
      method: "delete",
      url: "user",
      data: {
        user_id: user.id,
      },
    })
      .then((response) => {
        console.log(response);
        remove();
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const changePassword = () => {
    request({
      method: "put",
      url: "password",
      data: {
        user_id: user.id,
        password: newPassword,
      },
    })
      .then((response) => {
        console.log(response);
        setEdit(false);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className="building-info">
      <div>{user.first_name + " " + user.last_name}</div>
      <div className="card-buttons">
        <Popup
          overlayStyle={{
            background: "rgba(0, 0, 0, 0.5)",
            width: "100%",
            height: "100%",
            position: "fixed",
            top: "0",
            left: "0",
            zIndex: "9999",
          }}
          modal
          nested
          position="right center"
          trigger={
            <button>
              {" "}
              <Button
                mode={"primary"}
                onClick={() => setEdit(!edit)}
                text={"Edit"}
                width={"small"}
              />{" "}
            </button>
          }
        >
          {(close) => (
            <div className="modal popup-container">
              <button className="close" onClick={close}>
                &times;
              </button>
              <h1>Edit User</h1>
              <div className="popup-inputs">
                <Input
                  type={"password"}
                  label={"Change Password"}
                  placeholder={"New Password"}
                  onChange={(e) => setNewPassword(e.target.value)}
                />
              </div>
              <div className="popup-buttons">
                <Button
                  mode={"primary"}
                  text={"Change"}
                  width={"small"}
                  onClick={() => {
                    changePassword();
                    close();
                  }}
                />
                <Button
                  mode={"secondary"}
                  text={"Cancel"}
                  width={"small"}
                  onClick={() => {
                    close();
                  }}
                />
              </div>
            </div>
          )}
        </Popup>
        <Button
          mode={"primary"}
          onClick={() => toggleBan(user.id)}
          text={ban ? "Unban" : "Ban"}
          width={"small"}
        />
        <Button
          mode={"primary"}
          onClick={() => deleteUser()}
          text={"Delete"}
          width={"small"}
        />
      </div>
    </div>
  );
};

export default UserCard;
