from flask import Flask
from main import algo

app = Flask(__name__)


@app.route("/user/<user_id>")
def hello_world(user_id):
    return {
        "user_id": user_id,
        "words": "hello"
    }


app.run()