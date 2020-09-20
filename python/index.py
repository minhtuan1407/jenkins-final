from flask import Flask, render_template
import os
app = Flask(__name__)
@app.route("/")
os.environ['docker_tag'] = '$DOCKER_TAG'
os.environ['hostname'] = '$HOSTNAME'
def hello():
    return "Hello World Tuan!"
#print("Hello World!", os.environ['docker_tag'], os.environ['hostname'])
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5000"), debug=True)
