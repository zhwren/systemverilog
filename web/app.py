#!/bin/python3
########################################################################################################################
##                                                      _ooOoo_                                                       ##
##                                                     o8888888o                                                      ##
##                                                     88" . "88                                                      ##
##                                                     (| -_- |)                                                      ##
##                                                      O\ = /O                                                       ##
##                                                  ____/`---'\____                                                   ##
##                                                .   ' \\| |// `.                                                    ##
##                                                 / \\||| : |||// \                                                  ##
##                                               / _||||| -:- |||||- \                                                ##
##                                                 | | \\\ - /// | |                                                  ##
##                                               | \_| ''\---/'' | |                                                  ##
##                                                \ .-\__ `-` ___/-. /                                                ##
##                                             ___`. .' /--.--\ `. . __                                               ##
##                                          ."" '< `.____<|>_/___.' >'"".                                             ##
##                                         | | : `- \`.;` _ /`;.`/ - ` : | |                                          ##
##                                           \ \ `-. \_ __\ /__ _/ .-` / /                                            ##
##                                   ======`-.____`-.___\_____/___.-`____.-'======                                    ##
##                                                      `=---='                                                       ##
##                                                                                                                    ##
##                                   .............................................                                    ##
##                                          Buddha bless me, No bug forever                                           ##
##                                                                                                                    ##
########################################################################################################################
## Author       : generator                                                                                           ##
## Email        : zhwren0211@whu.edu.cn                                                                               ##
## Last modified: 2024-01-20 10:59:15                                                                                 ##
## Filename     : app.py                                                                                              ##
## Phone Number :                                                                                                     ##
## Discription  :                                                                                                     ##
########################################################################################################################
import flask

app = flask.Flask(__name__)

@app.route("/")
def index():
    return flask.render_template("index.html")

@app.route("/login", methods=['GET', 'POST'])
def login():
    resp = flask.make_response(flask.render_template("login.html"))
    return resp

@app.route("/signup", methods=['GET', 'POST'])
def signup():
    resp = flask.make_response(flask.render_template("signup.html"))
    return resp

@app.route("/logout")
def logout():
    return flask.render_template("login.html")

@app.route("/regress")
def regress():
    return flask.render_template("regress.html")

@app.route("/status")
def status():
    return flask.render_template("status.html")

@app.route("/example")
def example():
    return flask.render_template("example.html")

app.run(debug=True)
