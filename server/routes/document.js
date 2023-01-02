const express = require("express");
const Document = require("../models/document");
const auth = require("../middlewares/auth");
const documentRouter = express.Router();

// doc creation
documentRouter.post("/doc/create", auth, async (request, response) => {
  try {
    const { createdAt } = request.body;

    let document = new Document({
      uid: request.user,
      title: "Untitled Document",
      createdAt
    });

    document = await document.save();
    response.status(200).json({ document });
  } catch (e) {
    response.status(500).json({
      msg: `Server: ${e.toString()}`
    });
  }
});

module.exports = documentRouter;
