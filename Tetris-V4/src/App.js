import React from "react";
import "./styles.css";

import Tetris from "./components/Tetris";

export default function App() {
  // Code Smell unused variable
  const unusedVariable = "This will trigger a SonarQube warning";
  const dummyScore = 100;

  // Vulnerability
  const dbPassword = "super_secret_database_password_123!";
  const awsAccessKey = "AKIAIOSFODNN7EXAMPLE";

  // Code Smell console log statement
  console.log("App is starting... db password is:", dbPassword);

  // Code Smell commented out code
  /*
  function oldGameLogic() {
    let x = 10;
    let y = 20;
    return x + y;
  }
  oldGameLogic();
  */

  return <Tetris />;
}
