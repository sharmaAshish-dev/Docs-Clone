const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const authRouter = express.Router();

// user signup
authRouter.post("/api/SignUp", async (request, response) => {
  try {
    const { name, email, profilePicture } = request.body;

    let user = await User.findOne({ email });

    if (user == null) {
      user = new User({
        name,
        email,
        profilePicture
      });

      user = await user.save();
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    response.status(200).json({ user, token });
  } catch (e) {
    response.status(500).json({
      msg: e.toString()
    });
  }
});

authRouter.get("/", auth, async (request, response) => {
  const user = await User.findById(request.user);
  const token = request.token;

  response.json({ user, token });
});

module.exports = authRouter;
