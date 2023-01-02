const mongoose = require("mongoose");

documentSchema = mongoose.Schema({
  uid: {
    type: String,
    required: true
  },
  createdAt: {
    required: true,
    type: Number
  },
  title: {
    required: false,
    type: String,
    trim: true
  },
  content: {
    required: false,
    type: Array,
    default: []
  }
});

const Document = mongoose.model("Document", documentSchema);

module.exports = Document;
