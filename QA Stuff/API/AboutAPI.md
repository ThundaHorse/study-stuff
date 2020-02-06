# API

---

What is an **API**?

- Application Programming Interface. It's a set of functions or procedures that are used by computer programs to access a multitude of things.
- Simply put, it allows applications to communicate with one another.

What it **Isn't**

- It is **NOT** a database. It's an access point to an app that can access a database.

```javascript
UI -> Action (detailing what a user wants) -> Request -> API -> Database
```

- It's different from a database backed (static) web app. It usually doesn't need a front-end (GUI).
  - For example, using **Postman** to send an API request to get data for a user. Information is communicated via *JSON* (JavaScript Object Notation).

Generally, to build an API you need:

1. A Back end with routing
1. A DB where you app can store its data (PostgreQL, MySQL, etc.)
1. A Server or host (AWS, Netlify, Heroku, etc.)

To integrate an API, you usually have to:

- Make sure you read the documentation
- Understand the data structure of available data
- Call the API from the app and process the responses

```javascript
// something.js
import axios from "axios";

let data = [];
const request = axios.get("some website").then((response) => {
  data = response.data
});
```
