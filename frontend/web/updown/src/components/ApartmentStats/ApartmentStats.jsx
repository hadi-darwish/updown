import React, { useEffect, useState } from "react";
import request from "../../config/axios";
import Button from "../Button/Button";
import "./ApartmentStats.css";

const ApartmentStats = ({ apartment }) => {
  const [travels, setTravels] = useState(0);
  const [total, setTotal] = useState(0);
  const [residentsNumber, setResidentsNumber] = useState(0);
  const [ban, setBan] = useState(apartment.is_banned);
  const [paid, setPaid] = useState(apartment.is_paid);
  useEffect(() => {
    request({
      method: "post",
      url: "number_of_travels",
      data: {
        apartment_id: apartment.id,
      },
    })
      .then((response) => {
        console.log(response);
        setTravels(response.travels);
        setTotal(
          response.travels *
            parseFloat(localStorage.getItem("price_per_travel")) +
            parseFloat(localStorage.getItem("tax"))
        );
        console.log(travels + "hiiiiiiiiii");
        setResidentsNumber(response.numberOfResidents);
      })
      .catch((error) => {
        console.log(error);
      });
  }, []);

  const toggleBan = (id) => {
    request({
      method: "post",
      url: "ban_apartment",
      data: {
        apartment_id: id,
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
  const togglePaid = (id) => {
    request({
      method: "post",
      url: "pay_apartment",
      data: {
        apartment_id: id,
      },
    })
      .then((response) => {
        console.log(response);
        setPaid(!paid);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className="building-info">
      <div>{apartment.number}</div>
      <div>Total = ${total} </div>
      <div> Number of residents = {residentsNumber}</div>
      <div style={paid ? { color: "green" } : { color: "red" }}>Paid</div>
      <div>
        <Button
          mode={"primary"}
          text={paid ? "Not Paid" : "Pay"}
          width={"small"}
          onClick={() => togglePaid(apartment.id)}
        />
      </div>
      <div>
        <Button
          mode={"primary"}
          onClick={() => toggleBan(apartment.id)}
          text={ban ? "Unban" : "Ban"}
          width={"small"}
        />
      </div>
    </div>
  );
};

export default ApartmentStats;
