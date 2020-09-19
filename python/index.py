from flask import Flask, render_template
import os
app = Flask(__name__)
@app.route("/")
def hello():
    return "Hello World!"
    print(os.environ['DOCKER_TAG'])
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5000"), debug=True)
