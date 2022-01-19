from flask import Flask
from flask import render_template
import subprocess

app = Flask(__name__)


@app.route("/cbl")
def hello_world():
        return subprocess.check_output("./HelloWorld")

@app.route("/cbl/hal")
def sorry_dave():
        return subprocess.check_output("./Sorry")
