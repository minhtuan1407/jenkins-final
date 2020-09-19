const http = require('http');
const port = process.env.PORT || 3000;

const hostname = process.env.HOSTNAME || "unknown";
const app_version = process.env.APP_VERSION || "unknown";

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const msg = `Hello Word! Docker tag is ${app_version} - Hostname is ${hostname}\n`
  res.end(msg);
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
