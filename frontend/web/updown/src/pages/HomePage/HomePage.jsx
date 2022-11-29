import React, { useEffect, useState } from "react";
import Popup from "reactjs-popup";
import Button from "../../components/Button/Button";
import Input from "../../components/Input/Input";
import request from "../../config/axios";
import "./HomePage.css";

const HomePage = () => {
  const [buildingName, setBuildingName] = useState("");
  const [tax, setTax] = useState(0);
  const [users, setUsers] = useState([]);
  const [buildingId, setBuildingId] = useState(0);
  const [price_per_travel, setPrice_per_travel] = useState(0);
  const [isOn, setIsOn] = useState(0);
  const [body, setBody] = useState("");

  const send = () => {
    const config = {
      Host: "smtp.elasticemail.com",
      Username: "hadidarwish999@gmail.com",
      Password: "F0A692FDBF5A1C0CF99133920EDD56913BD6",
      Port: "2525",
      //   SecureToken: "c911847c-cc5b-455c-8184-ffe3ec2a4315",
      To: users,
      From: "hadi.darwish.03@gmail.com",
      Subject: "This is the subject",
      // Body: body,
      Body: body,
    };

    if (window.Email) {
      window.Email.send(config).then(function (message) {
        alert("mail sent successfully");
      });
      setBody("");
    }
  };

  useEffect(() => {
    request({
      method: "get",
      url: "owner_building",
    })
      .then((response) => {
        console.log(response);
        setBuildingId(response.building.id);
        console.log(response.building.id);
        localStorage.setItem("buildingId", response.building.id);
        setBuildingName(response.building.name);
        setIsOn(response.building.is_on);
        request({
          method: "post",
          url: "building_price",
          data: {
            building_id: response.building.id,
          },
        })
          .then((response) => {
            console.log(response);
            setTax(response.prices[0].tax);
            localStorage.setItem("tax", response.prices[0].tax);
            setPrice_per_travel(response.prices[0].price_per_travel);
            localStorage.setItem(
              "price_per_travel",
              response.prices[0].price_per_travel
            );
            request({
              method: "post",
              url: "residents",
              data: {
                building_id: localStorage.getItem("buildingId"),
              },
            }).then((response) => {
              console.log(response);
              let usrs = [];
              response.residents.forEach((user) => {
                usrs.push(user.email);
              });

              setUsers(usrs);
            });
          })
          .catch((error) => {
            console.log(error);
          });
      })
      .catch((error) => {
        console.log(error);
      });
  }, [isOn]);

  const toggle = () => {
    request({
      method: "put",
      url: "elevator_status",
      data: {
        building_id: buildingId,
      },
    })
      .then((response) => {
        console.log(response);
        setIsOn(!isOn);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const editPrices = () => {
    request({
      method: "put",
      url: "price",
      data: {
        building_id: buildingId,
        tax,
        price_per_travel,
      },
    })
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className="home-container">
      <h1>Home</h1>
      <div className="building-info">
        <div>{buildingName}</div>
        <div>Tax = ${tax}</div>
        <div>Price/Travel = ${price_per_travel}</div>
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
                <Button mode={"primary"} text={"Edit"} width={"small"} />{" "}
              </button>
            }
          >
            {(close) => (
              <div className="modal popup-container">
                <button className="close" onClick={close}>
                  &times;
                </button>
                <h1>Edit Prices</h1>
                <div className="popup-inputs">
                  <Input
                    type={"text"}
                    label={"Tax"}
                    placeholder={"Tax"}
                    onChange={(e) => setTax(e.target.value)}
                  />
                  <Input
                    type={"text"}
                    label={"Price/Travel"}
                    placeholder={"Price/Travel"}
                    onChange={(e) => setPrice_per_travel(e.target.value)}
                  />
                </div>
                <div className="popup-buttons">
                  <Button
                    mode={"primary"}
                    text={"Save"}
                    width={"small"}
                    onClick={() => {
                      editPrices();
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
        </div>
      </div>
      <div className="building-info">
        <div>Elevator Status</div>
        <div>
          <Button
            mode={"primary"}
            onClick={toggle}
            text={isOn === 1 ? "ON" : "OFF"}
            width={"small"}
          />
        </div>
      </div>
      <h1>Notify Residents</h1>

      <h2>Message</h2>

      <textarea
        className="message"
        placeholder="Enter message here"
        rows="4"
        cols="50"
        value={body}
        onChange={(e) => setBody(e.target.value)}
      />
      <div className="button">
        <Button mode={"primary"} onClick={send} text={"Send"} width={"big"} />
      </div>
    </div>
  );
};

export default HomePage;
