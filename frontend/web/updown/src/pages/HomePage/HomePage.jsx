import React, { useEffect, useState } from "react";
import Button from "../../components/Button/Button";
import request from "../../config/axios";
import "./HomePage.css";

const HomePage = () => {
  const [buildingName, setBuildingName] = useState("");
  const [tax, setTax] = useState(0);
  const [buildingId, setBuildingId] = useState(0);
  const [price_per_travel, setPrice_per_travel] = useState(0);
  const [isOn, setIsOn] = useState(0);
  const [body, setBody] = useState("");

  const send = () => {
    const config = {
      Host: "smtp.elasticemail.com",
      Username: "vifodi7767@pamaweb.com",
      Password: "72DFADEB3EB5DFDF9066B80C94E8A3B45119",
      Port: "2525",
      //   SecureToken: "c911847c-cc5b-455c-8184-ffe3ec2a4315",
      To: "vifodi7767@pamaweb.com",
      From: "vifodi7767@pamaweb.com",
      Subject: "This is the subject",
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
        localStorage.setItem("buildingId", response.building.id);
        setBuildingName(response.building.name);
        setIsOn(response.building.is_on);
        request({
          method: "post",
          url: "building_price",
          data: {
            building_id: buildingId,
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

  return (
    <div className="home-container">
      <h1>Home</h1>
      <div className="building-info">
        <div>{buildingName}</div>
        <div>Tax = ${tax}</div>
        <div>Price/Travel = ${price_per_travel}</div>
        <div>
          <Button
            mode={"primary"}
            onClick={null}
            text={"Edit"}
            width={"small"}
          />
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
