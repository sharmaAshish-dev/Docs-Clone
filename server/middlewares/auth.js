const jwt = require("jsonwebtoken");

const auth = async (request, response, next) => {
  try {
    const token = request.header("x-auth-token");

    if (token == null) {
      response.status(401).json({ msg: "No auth token found, Access denied" });
    }

    const verified = jwt.verify(token, "passwordKey");

    if (verified == null) {
      response
        .status(401)
        .json({ msg: "Token authorization failed, Access denied" });
    }

    request.user = verified.id;
    request.token = token;
    next();
  } catch (e) {
    response.status(500).json({ msg: e.message });
  }
};

module.exports = auth;
