const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const documentRouter = require("./routes/document");
const cors = require("cors");

const PORT = process.env.PORT | 3001;

const app = express();

app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);

const DB =
  "mongodb+srv://ashish:AshishMonDB@doccluster.ctz2ktx.mongodb.net/?retryWrites=true&w=majority";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected to mongoDB");
  })
  .catch((err) => {
    console.log(err);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`server running at port ${PORT}`);
});
