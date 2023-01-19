#!/bin/python3
################################################################################
##                                 _ooOoo_                                    ##
##                                o8888888o                                   ##
##                                88" . "88                                   ##
##                                (| -_- |)                                   ##
##                                 O\ = /O                                    ##
##                             ____/`---'\____                                ##
##                           .   ' \\| |// `.                                 ##
##                            / \\||| : |||// \                               ##
##                          / _||||| -:- |||||- \                             ##
##                            | | \\\ - /// | |                               ##
##                          | \_| ''\---/'' | |                               ##
##                           \ .-\__ `-` ___/-. /                             ##
##                        ___`. .' /--.--\ `. . __                            ##
##                     ."" '< `.____<|>_/___.' >'"".                          ##
##                    | | : `- \`.;` _ /`;.`/ - ` : | |                       ##
##                      \ \ `-. \_ __\ /__ _/ .-` / /                         ##
##              ======`-.____`-.___\_____/___.-`____.-'======                 ##
##                                 `=---='                                    ##
##                                                                            ##
##              .............................................                 ##
##                     Buddha bless me, No bug forever                        ##
##                                                                            ##
################################################################################
## Author       : generator                                                   ##
## Email        : zhwren0211@whu.edu.cn                                       ##
## Last modified: 2021-01-13 21:11:59                                         ##
## Filename     : gen.py                                                      ##
## Phone Number :                                                             ##
## Discription  :                                                             ##
################################################################################

import os
import re
import sys
import json
import time
import argparse
from jinja2 import FileSystemLoader,Environment

class MyTemplate:
    def __init__(self, name, template):
        self.name     = name
        self.template = template

class Generator:
    def __init__(self):
        self.loader    = FileSystemLoader(os.path.join(sys.path[0]))
        self.env       = Environment(loader=self.loader, trim_blocks=True)
        self.hexist    = 0
        self.templates = {}
        self.GetAllTemplates()
        self.originNames = ['Makefile', 'testbench.sv', 'module_inst.sv']
        pass

    def GetAllTemplates(self):
        templatePath = os.path.join(sys.path[0], "templates")
        subdirs = [i for i in os.listdir(templatePath) if os.path.isdir(os.path.join(templatePath, i))]
        for subdir in subdirs:
            self.templates[subdir] = []
            templatePath = os.path.join(sys.path[0], "templates", subdir)
            subfiles = [i for i in os.listdir(templatePath) if os.path.isfile(os.path.join(templatePath, i))]
            for subfile in subfiles:
                template = MyTemplate(subfile, self.env.get_template(os.path.join("templates", subdir, subfile)))
                self.templates[subdir].append(template)
        if (os.path.exists(os.path.join(sys.path[0], "fhead"))):
            self.hexist = 1
            self.fhead = self.env.get_template("fhead")
        pass

    def Generate(self, opt):
        f = open(opt.i, "r")
        self.cfg = json.load(f)
        f.close()
        self.dst = opt.o
        self.time = time.strftime("%Y-%m-%d %H:%M:%S")

        for subdir in self.templates.keys():
            if (subdir == "agent"):
                self.GenerateAgents()
            else:
                self.GenerateOtherFiles(subdir)
        pass

    def GenerateAgents(self):
        for intf in self.cfg["agent"].keys():
            for template in self.templates['agent']:
                filename = "{0}_{1}".format(intf, template.name)
                fhead = ""
                if self.hexist:
                    fhead = self.fhead.render(fname=filename, time=self.time)
                dest_path = os.path.join(self.dst, "agent", intf)
                if (not os.path.exists(dest_path)):
                    os.makedirs(dest_path)
                fo = open(os.path.join(dest_path, filename), "w")
                fo.write(template.template.render(intf=intf, fhead=fhead, cfg=self.cfg, time=self.time))
                fo.close()
        pass

    def GenerateOtherFiles(self, subdir):
        dest_path = os.path.join(self.dst, subdir)
        if (not os.path.exists(dest_path)):
            os.makedirs(dest_path)
        for template in self.templates[subdir]:
            filename = "{0}_{1}_{2}".format(self.cfg["proj"], self.cfg["module"], template.name)
            fhead = ""
            if (template.name in self.originNames):
                filename = template.name
            if self.hexist:
                fhead = self.fhead.render(fname=filename, time=self.time)
            fo = open(os.path.join(dest_path, filename), "w")
            fo.write(template.template.render(cfg=self.cfg, fhead=fhead, time=self.time))
            fo.close()
        pass

################################################################################
## Time        : 2023-01-13 21:12:59
## Author      : generator
## Description : Create
################################################################################
def ParseInput():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", type=str, default="cfg.json", help="configure filename")
    parser.add_argument("-o", type=str, default=os.getcwd(), help="output dir")
    opt = parser.parse_args()
    return opt
    
##########################################################
if __name__ == "__main__":
    opt = ParseInput()
    gen = Generator()
    gen.Generate(opt)
