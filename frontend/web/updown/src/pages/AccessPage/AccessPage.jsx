import React, { useEffect, useState } from "react";
import Button from "../../components/Button/Button";
import request from "../../config/axios";
import "./AccessPage.css";
import Popup from "reactjs-popup";
import "reactjs-popup/dist/index.css";
import Input from "../../components/Input/Input";
import UserCard from "../../components/UserCard/UserCard";

const AccessPage = () => {
  const [apartments, setApartments] = useState([]);
  const [users, setUsers] = useState([]);
  const [change, setChange] = useState(false);
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [apartmentId, setApartmentId] = useState(0);
  const [age, setAge] = useState(0);
  const [phone, setPhone] = useState("");
  const [floor, setFloor] = useState(0);
  const [number, setNumber] = useState(0);
  const remove = () => {
    setChange(!change);
  };

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

  useEffect(() => {
    request({
      method: "post",
      url: "residents",
      data: {
        building_id: localStorage.getItem("buildingId"),
      },
    }).then((response) => {
      console.log(response);
      setUsers(response.residents);
    });
  }, [change]);

  const addUser = () => {
    request({
      method: "post",
      url: "register",
      data: {
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
        user_type_id: 2,
        age: age,
        phone: phone,
      },
    })
      .then((response) => {
        console.log(response);
        const id = response.user.id;
        request({
          method: "post",
          url: "add_resident",
          data: {
            apartment_id: parseInt(apartmentId),
            user_id: id,
          },
        })
          .then((response) => {
            console.log(response);
            setChange(!change);
          })
          .catch((error) => {
            console.log(error);
          });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const addApartment = () => {
    request({
      method: "post",
      url: "apartment",
      data: {
        building_id: localStorage.getItem("buildingId"),
        floor: floor,
        number: number,
        owner_id: localStorage.getItem("admin_id"),
      },
    })
      .then((response) => {
        console.log(response);
        setChange(!change);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className="home-container">
      <h1>Accessibility</h1>
      <div className="row">
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
                mode={"secondary"}
                text={"Add new Resident"}
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
              <h1>Add New Resident</h1>
              <div className="popup-inputs">
                <Input
                  type={"text"}
                  placeholder={"First Name"}
                  onChange={(e) => setFirstName(e.target.value)}
                />
                <Input
                  type={"text"}
                  placeholder={"Last Name"}
                  onChange={(e) => setLastName(e.target.value)}
                />
                <Input
                  type={"text"}
                  placeholder={"Email"}
                  onChange={(e) => setEmail(e.target.value)}
                />
                <Input
                  type={"password"}
                  placeholder={"Password"}
                  onChange={(e) => setPassword(e.target.value)}
                />
                <Input
                  type={"number"}
                  placeholder={"Apartment"}
                  onChange={(e) => setApartmentId(e.target.value)}
                />
                <Input
                  type={"number"}
                  placeholder={"Age"}
                  onChange={(e) => setAge(e.target.value)}
                />
                <Input
                  type={"number"}
                  placeholder={"Phone"}
                  onChange={(e) => setPhone(e.target.value)}
                />
              </div>
              <div className="popup-buttons">
                <Button
                  mode={"primary"}
                  text={"Create"}
                  width={"small"}
                  onClick={() => {
                    addUser();
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
                mode={"secondary"}
                text={"Add new Apartment"}
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
              <h1>Add New Apartment</h1>
              <div className="popup-inputs">
                <Input
                  type={"text"}
                  placeholder={"Apartment Number"}
                  onChange={(e) => setNumber(e.target.value)}
                />
                <Input
                  type={"text"}
                  placeholder={"Apartment Floor"}
                  onChange={(e) => setFloor(e.target.value)}
                />
              </div>
              <div className="popup-buttons">
                <Button
                  mode={"primary"}
                  text={"Create"}
                  width={"small"}
                  onClick={() => {
                    addApartment();
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
      {users.map((user) => {
        return <UserCard user={user} remove={remove} />;
      })}
    </div>
  );
};

export default AccessPage;
