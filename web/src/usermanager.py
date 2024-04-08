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
## Last modified: 2024-04-07 22:13:51                                                                                 ##
## Filename     : usermanager.py                                                                                      ##
## Phone Number :                                                                                                     ##
## Discription  :                                                                                                     ##
########################################################################################################################
import time
from hashlib import md5
import flask
try:
    import dbmanager,logmanager,status
except:
    from src import dbmanager,logmanager,status


####################################################################################################################
## Time        : 2024-04-08 22:17:58                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
class UserManager(flask.Blueprint):
    def __init__(self, name='user', appnamne=__name__):
        self.manager = dbmanager.DBmanager.get_instance()
        flask.Blueprint.__init__(self, name, appnamne)
        self.add_url_rule("/login", view_func=self.login_process, methods=['GET', 'POST'])
        self.add_url_rule("/logout", view_func=self.logout_process, methods=['GET', 'POST'])
        self.add_url_rule("/signup", view_func=self.signup_process, methods=['GET', 'POST'])
        pass

####################################################################################################################
## Time        : 2024-04-08 22:18:04                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
    def login_process(self):
        if (flask.request.method == 'GET'):
            resp = flask.make_response(flask.render_template("login.html"))
            return resp

        username = flask.request.form.get("username")
        password = flask.request.form.get("password")

        stime = time.strftime("%Y-%m-%d %H:%M:%S")
        cpassword = md5(password.encode()).hexdigest()

        rst = self.manager.execute('select PASSWORD from USER_INFO where USERNAME="{0}"'.format(username))
        state = ((len(rst) > 0) and (rst[0][0] == cpassword))

        if (state == status.Status.SUCCESS):
            resp = flask.make_response(flask.redirect("/"))
            if (flask.request.form.get("remember")):
                cookie = stime + cpassword
                resp.set_cookie("userid", cookie)
                self.manager.execute(self.manager.insert.render(name="USER_CONNECT", values=[username, cookie]))
            return resp
        return "username or password error!"

####################################################################################################################
## Time        : 2024-04-08 22:18:07                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
    def logout_process(self):
        resp = make_response(redirect("/"))
        resp.delete_cookie("userid")
        return resp

####################################################################################################################
## Time        : 2024-04-08 22:41:00                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
    def signup_process(self):
        if (flask.request.method == 'GET'):
            return flask.make_response(flask.render_template("signup.html"))

        username = flask.request.form.get("username")
        password = flask.request.form.get("password")
        
        try:
            cpassword = md5(password.encode()).hexdigest()
            self.manager.execute(self.manager.insert.render(name="USER_INFO", values=[username, cpassword]))
            return flask.make_response(flask.redirect("/login"))
        except Exception as error:
            return str(error)

####################################################################################################################
## Time        : 2024-04-07 22:18:35                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
if __name__ == "__main__":
    app = Flask(__name__)
    app.register_blueprint(UserManager())
    app.run()
