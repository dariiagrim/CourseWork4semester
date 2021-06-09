from flask import Flask
from recommendations import get_recommendations

app = Flask(__name__)


@app.route("/user/<user_id>")
def hello_world(user_id):
    return {
        "user_id": int(user_id),
        "recommendations": get_recommendations(int(user_id), 69162)
    }


app.run()