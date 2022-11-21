import React, { useEffect, useState } from "react";
import Button from "../../components/Button/Button";
import request from "../../config/axios";
import "./AccessPage.css";
import Popup from "reactjs-popup";
import "reactjs-popup/dist/index.css";
import Input from "../../components/Input/Input";

const AccessPage = () => {
  const [apartments, setApartments] = useState([]);
  const [newPassword, setNewPassword] = useState("");

  useEffect(() => {
    request({
      method: "post",
      url: "building_apartments",
      data: {
        building_id: localStorage.getItem("buildingId"),
      },
    })
      .then((response) => {
        console.log(response);
        setApartments(response.apartments);
      })
      .catch((error) => {
        console.log(error);
      });
  }, []);

  return (
    <div className="home-container">
      <h1>Accessibility</h1>
      <div className="row">
        <Button mode={"secondary"} text={"Add new Resident"} width={"small"} />
      </div>

      <div className="building-info">
        <div>{"User Name"}</div>
        <div>{"Apartment number"}</div>
        <div>
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
                  onClick={null}
                  text={"Edit"}
                  width={"small"}
                />{" "}
              </button>
            }
          >
            <div className="popup-container">
              <h1>Edit Apartment</h1>
              <div className="popup-inputs">
                <Input
                  label={"Change Password"}
                  type={"text"}
                  placeholder={"New Password"}
                  onChange={(e) => setNewPassword(e.target.value)}
                />
              </div>
              <div className="popup-buttons">
                <Button
                  mode={"primary"}
                  onClick={null}
                  text={"Save"}
                  width={"small"}
                />
                <Button
                  mode={"secondary"}
                  onClick={null}
                  text={"Cancel"}
                  width={"small"}
                />
              </div>
            </div>
          </Popup>
        </div>
        <div>
          <Button
            mode={"primary"}
            onClick={null}
            text={"Ban"}
            width={"small"}
          />
          <Button
            mode={"primary"}
            onClick={null}
            text={"Delete"}
            width={"small"}
          />
        </div>
      </div>
    </div>
  );
};

export default AccessPage;
