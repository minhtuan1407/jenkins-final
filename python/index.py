from flask import Flask, render_template
import os
app = Flask(__name__)
@app.route("/")
os.environ['docker_tag'] = '$DOCKER_TAG'
os.environ['hostname'] = '$HOSTNAME'
def hello():
    return "Hello World !"
print("Hello World!", os.environ['docker_tag'])
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5000"), debug=True)
