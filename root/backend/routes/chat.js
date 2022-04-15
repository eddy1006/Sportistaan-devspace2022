const express = require("express");
const router = express.Router();

// const WebSocket = require("ws");
// const wss = new WebSocket.Server({ port: 2000 });
router.get("/", (req, res) => {
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
module.exports = router;
