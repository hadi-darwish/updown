import React, { useEffect, useState } from "react";
import ApartmentStats from "../../components/ApartmentStats/ApartmentStats";
import Button from "../../components/Button/Button";
import request from "../../config/axios";
import "./StatsPage.css";

const StatsPage = () => {
  const [apartments, setApartments] = useState([]);

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
      <h1>Stats</h1>
      {apartments.map((apartment) => {
        return <ApartmentStats apartment={apartment} />;
      })}
    </div>
  );
};

export default StatsPage;
