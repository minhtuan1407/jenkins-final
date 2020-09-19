const http = require('http');
const port = process.env.PORT || 3000;

const hostname = process.env.HOSTNAME || "unknown";
const docker_tag = process.env.DOCKER_TAG || "unknown";

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const msg = `Hello Word! Docker tag is ${docker_tag} - Hostname is ${hostname}\n`
  res.end(msg);
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
