#!/bin/bash

#Get Project name
projectname=$1

# Create a new React.js project
npx create-react-app  $projectname
cd  $projectname

# Create the required folder structure
mkdir src/components src/routes src/css src/models src/controllers src/services src/config

# Install dependencies
npm install react-bootstrap react-router-dom sequelize mysql2 axios @mui/material @emotion/react bootstrap reactstrap @fortawesome/fontawesome-svg-core  @fortawesome/free-brands-svg-icons  @fortawesome/react-fontawesome @fortawesome/free-solid-svg-icons '--save'

# Configure Sequelize
cat <<EOF > src/config/database.js
const Sequelize = require('sequelize');

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASS, {
  host: process.env.DB_HOST,
  dialect: 'mysql',
});

module.exports = sequelize;
EOF

# Define a sample model
cat <<EOF > src/models/User.js
const Sequelize = require('sequelize');
const sequelize = require('../config/database');

const User = sequelize.define('user', {
  firstName: {
    type: Sequelize.STRING,
  },
  lastName: {
    type: Sequelize.STRING,
  },
  email: {
    type: Sequelize.STRING,
    unique: true,
  },
  password: {
    type: Sequelize.STRING,
  },
});

module.exports = User;
EOF

# Create a sample controller
cat <<EOF > src/controllers/userController.js
const User = require('../models/User');

const createUser = async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.status(201).json(user);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

module.exports = { createUser };
EOF

# Configure Axios
cat <<EOF > src/config/axios.js
import axios from 'axios';

const instance = axios.create({
  baseURL: process.env.API_BASE_URL,
});

export default instance;
EOF

# Set up basic routing with React Router
cat <<EOF > src/routes/AppRouter.js
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import SignUp from '../components/SignUp';
import Login from '../components/Login';
import Main from '../components/Main';

const AppRouter = () => (
    <Routes>
      <Route path="/signup" element={<SignUp />} />
      <Route path="/login" element={<Login />} />
      <Route path="/" element={<Main />} />
    </Routes>
);

export default AppRouter;
EOF

# Generate custom CSS file
cat <<EOF > src/css/styles.css
@import '~bootstrap/dist/css/bootstrap.min.css';
/* @import '~@mui/material/styles'; */
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}



.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.header .nav {
  display: flex;
  align-items: center;
}

.header .nav-item {
  margin-left: 10px;
}

@media (max-width: 768px) {
  .header {
    flex-direction: column;
    align-items: center;
  }
  .header .nav {
    flex-direction: column;
  }
  .header .nav-item {
    margin-bottom: 10px;
  }
}

.footer {
  background-color: #f5f5f5;
  padding: 20px 0;
  color: #333;
}

.footer .container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.footer .row {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.footer .col-md-4 {
  flex-basis: 33.33%;
  margin-bottom: 20px;
}

.footer h5 {
  font-weight: bold;
  margin-top: 0;
}

.footer ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer li {
  margin-bottom: 10px;
}

.footer a {
  color: #337ab7;
  text-decoration: none;
}

.footer a:hover {
  color: #23527c;
}

.footer .copyright {
  font-size: 14px;
  color: #666;
  text-align: center;
  margin-top: 20px;
}

/* Responsive styles */

@media (max-width: 768px) {
  .footer .col-md-4 {
    flex-basis: 50%;
  }
}

@media (max-width: 480px) {
  .footer .col-md-4 {
    flex-basis: 100%;
  }
  .footer .row {
    flex-direction: column;
  }
}


EOF

# Sample code for components (you can add more as needed)
cat <<EOF > src/components/SignUp.js
import React from 'react';

const SignUp = () => {
  return <div>SignUp Component</div>;
};

export default SignUp;
EOF

cat <<EOF > src/components/Login.js
import React from 'react';

const Login = () => {
  return <div>Login Component</div>;
};

export default Login;
EOF

cat <<EOF > src/components/Main.js
import React from 'react';
import { Container, Row, Col, Button } from 'reactstrap';

const Main = () => {
  return (
    <Container fluid className="welcome-page d-flex flex-column min-vh-100">
      <Row className="flex-grow-1 align-items-center justify-content-center text-center">
        <Col md="8">
          <h1>Welcome to React project </h1>
          <p className="lead">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.
          </p>
          <Button color="primary" size="lg">Get Started</Button>
        </Col>
      </Row>
    </Container>
  );
};

export default Main;

EOF

# Add sample Axios HTTP methods in the services folder
cat <<EOF > src/services/apiService.js
import axios from '../config/axios';

const get = async (url) => {
  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message || error.message);
  }
};

const post = async (url, data) => {
  try {
    const response = await axios.post(url, data);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message || error.message);
  }
};

const put = async (url, data) => {
  try {
    const response = await axios.put(url, data);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message || error.message);
  }
};

const remove = async (url) => {
  try {
    const response = await axios.delete(url);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message || error.message);
  }
};

export { get, post, put, remove };
EOF

# Add header navigation component
cat <<EOF > src/components/Header.js
import React, { useState } from 'react';
import { Navbar, NavbarBrand, Nav, NavItem, NavLink, NavbarToggler, Collapse } from 'reactstrap';

const Header = () => {
  const [isOpen, setIsOpen] = useState(false);


  const logo = 'https://bigtappanalytics.com/uploads/logo/logo.png'
  const toggle = () => setIsOpen(!isOpen);

  return (
    <Navbar color="light" light expand="md">
      <NavbarBrand href="/">
        <img src={logo} alt="Logo" style={{ width: '40px', height: '40px' }} /> 
      </NavbarBrand>
      <NavbarToggler onClick={toggle} />
      <Collapse isOpen={isOpen} navbar>
        <Nav className="ms-auto" navbar>
          <NavItem>
            <NavLink href="/">Home</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="/about">About</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="/services">Services</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="/contact">Contact</NavLink>
          </NavItem>
              <NavItem>
            <NavLink href="/contact">Login</NavLink>
          </NavItem>
              <NavItem>
            <NavLink href="/contact">SignUp</NavLink>
          </NavItem>
        </Nav>
      </Collapse>
    </Navbar>
  );
}

export default Header;

EOF

# Add Footer navigation component
cat <<EOF > src/components/Footer.js

import React from "react";
import { Container, Row, Col } from "reactstrap";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faFacebook,
  faTwitter,
  faInstagram,
} from "@fortawesome/free-brands-svg-icons";
import { faPhone, faEnvelope } from "@fortawesome/free-solid-svg-icons";

const Footer = () => {
  return (
    <footer className="footer">
      <Container>
        <Row>
          <Col md="4" sm="6">
            <h5>About Us</h5>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit
              amet nulla auctor, vestibulum magna sed, convallis ex.
            </p>
          </Col>
          <Col md="4" sm="6">
            <h5>Quick Links</h5>
            <ul>
              <li>
                <a href="https://www.google.com/">Home</a>
              </li>
              <li>
                <a href="https://www.google.com/">About</a>
              </li>
              <li>
                <a href="https://www.google.com/">Contact</a>
              </li>
            </ul>
          </Col>
          <Col md="4" sm="6">
            <h5>Follow Us</h5>
            <ul className="list-inline">
              <li className="list-inline-item">
                <a
                  href="https://www.facebook.com"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FontAwesomeIcon icon={faFacebook} size="2x" />
                </a>
              </li>
              <li className="list-inline-item">
                <a
                  href="https://www.twitter.com"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FontAwesomeIcon icon={faTwitter} size="2x" />
                </a>
              </li>
              <li className="list-inline-item">
                <a
                  href="https://www.instagram.com"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FontAwesomeIcon icon={faInstagram} size="2x" />
                </a>
              </li>
              <li className="list-inline-item">
                <a
                  href="https://www.instagram.com"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FontAwesomeIcon icon={faEnvelope} size="2x" />
                </a>
              </li>
              <li className="list-inline-item">
                <a
                  href="https://www.instagram.com"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FontAwesomeIcon icon={faPhone} size="2x" />
                </a>
              </li>
            </ul>
          </Col>
        </Row>
        <Row>
          <Col md="12">
            <p className="text-center mt-3">
              Copyright &copy; 2023 My App Name. All rights reserved.
            </p>
          </Col>
        </Row>
      </Container>
    </footer>
  );
};

export default Footer;

EOF



# Update App.js to include the header navigation
cat <<EOF > src/App.js
import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import AppRouter from "./routes/AppRouter";
import Header from "./components/Header";
import Footer from "./components/Footer";
import { Container } from "reactstrap";
import './css/styles.css' //custom css
function App() {
  return (
    <Router>
      <Header />
      <Container className="flex-grow-1 my-4">
        <AppRouter />
      </Container>

      <Footer />
    </Router>
  );
}

export default App;
EOF

# Start the development server
npm start
