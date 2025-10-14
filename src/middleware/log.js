const logRequest = (req, res, next) => {
  console.log(req.method, req.url);
  next();
};

module.exports = { logRequest };
