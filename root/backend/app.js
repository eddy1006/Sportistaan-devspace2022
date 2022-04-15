// modules exported and middlewares
const express = require("express");
const app = express();
const http = require("http");
const fs = require("fs");
const server = http.createServer(app);
const path = require("path");
const { find } = require("async");

// middleware for testing on webapps
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.static("public"));
app.use(express.json());

// hostname and port
// const hostname = "0.0.0.0"; // ignore for deployment
const port = process.env.PORT || 3000;

//database connections
const mongoose = require("mongoose");

// models import
const Event = require("./models/events");

// connect to the mongodb database
require("dotenv").config();
// const mongo_atlas_path =
//   "mongodb+srv://Architjain:UEkpXUAtUP6Pt6B@cluster0.2jwdx.mongodb.net/sportistaan-db?retryWrites=true&w=majority";
mongoose
  .connect(
    process.env.MONGODB_URI ||
      "mongodb+srv://Architjain:UEkpXUAtUP6Pt6B@cluster0.2jwdx.mongodb.net/sportistaan-db?retryWrites=true&w=majority",
    {
      useNewUrlParser: true,
      // useCreateIndex: true,
      useUnifiedTopology: true,
      // useFindAndModify: false,
    }
  )
  .then(() => {
    console.log("mongodb connected!");
  })
  .catch((err) => {
    console.log(err);
  });

// routes and controllers

// route for creating an event/tournament basically for hosting
app.post("/create-event", (req, res) => {
  // const event1 = new Event({
  //   gameName: "football",
  //   time: "11pm",
  //   venue: "grounds",
  //   student_id: ["person1", "person2"],
  //   finish: false,
  //   winner: "person1",
  // });
  const event = new Event(req.body);
  event
    .save()
    .then((result) => {
      res.end("inserted a new data");
    })
    .catch((err) => {
      res.end("error in insertion");
    });
});

// route for a client to join a particular tournament
app.post("/join-event", (req, res) => {
  Event.updateMany(
    { _id: req.body._id },
    { $push: { student_info: { name: req.body.name } } } //  {_id: "12345", student_id: person's Name}
  )
    .then(() => res.end("updated the event"))
    .catch(() => res.end("error in joint event"));
});

// route to all the information of the scheduled events.
app.get("/show-event", (req, res) => {
  Event.find({})
    .then((result) => {
      if (result.finish == true) res.send(result.winner);
      else {
        res.send(result);
      }
    })
    .catch((err) => {
      console.log(err);
    });
});

app.get("/registered-event", (req, res) => {
  Event.find({ student_info: { $elemMatch: { name: req.query.username } } }) // username is the req given by the client
    .then((result) => {
      console.log(result);
      console.log(req.body.username);
      res.send(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.get("/winners", (req, res) => {
  Event.find();
});

// chat application
const WebSocket = require("ws");
const wss = new WebSocket.Server({ server });
app.get("/", (req, res) => {
  wss.once("connection", function onConnection(ws) {
    console.log("New ws connection established!");

    // ws.on("message", (data) => {
    //   console.log("client sends:" + data);

    //   ws.send(String(data).toUpperCase());
    // });

    ws.on("message", function incoming(data, isBinary) {
      wss.clients.forEach(function each(client) {
        if (client.readyState === WebSocket.OPEN) {
          // console.log(data);
          client.send(data, { binary: isBinary });
          // client.send(JSON.stringify([data, name]), { binary: isBinary });
        }
      });
    });

    ws.on("close", () => {
      console.log("client disconnected");
    });
  });
  res.render("home");
});

// listening to the server
server.listen(port, () => {
  console.log(`server running`);
  // console.log(`server running `);
});
