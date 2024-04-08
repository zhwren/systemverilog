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
import sqlite3
from hashlib import md5
from jinja2 import Template
try:
    import logmanager,status
except:
    from src import logmanager,status

class DBmanager:
    manager = None
    create = Template("create table if not exists {{name}} ({%for (c,t) in columns.items()%}{{c}} {{t}}{%if not loop.last%},{%endif%}{%endfor%})")
    insert = Template('insert into {{name}} values ({%for v in values%}"{{v}}"{%if not loop.last%},{%endif%}{%endfor%})')

    def __init__(self, dbfilename='regress.db', logfilename='app.run_log'):
        self.dbfilename  = dbfilename
        self.logfilename = logfilename
        self.connections = []
        self.database_initialize()
        self.logger = logmanager.LogManager.get_instance(logfilename)
        pass

    @staticmethod
    def get_instance(dbfilename='regress.db', logfilename='app.run_log'):
        if (DBmanager.manager == None):
            DBmanager.manager = DBmanager(dbfilename, logfilename)
        return DBmanager.manager

    def get_connect(self):
        if (len(self.connections) > 0):
            return self.connections.pop(0)
        return sqlite3.connect(self.dbfilename, check_same_thread=False)

    def release_connect(self, connect):
        self.connections.append(connect)
        pass

    def database_initialize(self):
        connect = self.get_connect()
        connect.execute(self.create.render(name="USER_INFO", columns={"USERNAME":"text primary key", "PASSWORD":"text"}))
        connect.execute(self.create.render(name="USER_CONNECT", columns={"USERNAME":"text", "CONNECTION":"text"}))
        connect.commit()
        self.release_connect(connect)
        pass

    def execute(self, sql):
        connect = self.get_connect()
        print(sql)
        try:
            cursor = connect.cursor()
            #cursor.row_factory = sqlite3.Row
            results = cursor.execute(sql).fetchall()
            connect.commit()
            self.release_connect(connect)
            return results
        except Exception as error:
            self.logger.write(error)
            raise Exception(error)

####################################################################################################################
## Time        : 2024-04-07 21:43:15                                                                              ##
## Author      : generator                                                                                        ##
## Description : Create                                                                                           ##
####################################################################################################################
if __name__ == "__main__":
    manager = DBmanager.get_instance()
    connect = manager.get_connect()
    print(connect)
    manager.release_connect(connect)
    print(manager.connections)

    results = manager.execute(manager.insert.render(name="USER_INFO", values=["zhuhw", "zhuhw@1234"]))
    results = manager.execute("select * from USER_INFO")
    print(results)
