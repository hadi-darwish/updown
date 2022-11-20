import React from "react";
import Button from "../../components/Button/Button";
import "./StatsPage.css";

const StatsPage = () => {
  return (
    <div className="home-container">
      <h1>Home</h1>
      <div className="building-info">
        <div>Apartment Number</div>
        <div>Total = $10 </div>
        <div> Number of residents = 5</div>
        <div>
          {" "}
          Paid <div></div>
          <Button mode={"primary"} text={"Pay"} width={"small"} />
        </div>
        <div>
          <Button
            mode={"primary"}
            onClick={null}
            text={"BAN"}
            width={"small"}
          />
        </div>
      </div>
    </div>
  );
};

export default StatsPage;
