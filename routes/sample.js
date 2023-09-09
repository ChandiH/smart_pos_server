API/routes/file.js
const express = require('express')
const router = express.Router()
const {
  getData,
  postData,
  putData,
  deleteData
} = require('../controllers/file')
router.route('/')
  .get(getData)
  .post(postData)
  .put(putData)
  .delete(deleteData)
// extended url route example
router.route('/:id')
  .get(getSingleDataByID)
module.exports = router 