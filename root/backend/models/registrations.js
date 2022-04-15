const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const registrationSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  email_id: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  bio: {
    type: String,
    required: true,
  },
});

const Registrations = mongoose.model("Registration", registrationSchema);

module.exports = Registrations;
