const http = require('http');
const port = process.env.PORT || 3000;

const app_env = process.env.APP_ENV || "unknown";
const docker_tag = process.env.DOCKER_TAG || "unknown";

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const msg = `Hello Word! Docker tag ${docker_tag} - Environment ${app_env}\n`
  res.end(msg);
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});
