#!/bin/python3
##########################################################
## Author       : generator                             ##
## Email        : zhwren0211@whu.edu.cn                 ##
## Last modified: 2022-09-13 11:30:21                   ##
## Filename     : generator.py                          ##
## Discription  : Auto UVM testbench generator          ##
##########################################################

import os
import re
import sys
import json
import time
import argparse
from jinja2 import Template,FileSystemLoader,Environment

class generator:
    """
    """

    def __init__(self, config_file, output_dir):
        self.config_file = open(config_file, "r")
        self.output_dir  = output_dir
        self.config_data = json.load(self.config_file)
        self.mkdir()
        self.envTemp   = {}
        self.utilsTemp = {}
        self.templateInit(self.envTemp,   "env"  )
        self.templateInit(self.utilsTemp, "utils")
        self.time = time.strftime("%Y-%m-%d %H:%M:%S")

    def templateInit(self, dic, subdir):
        loader = FileSystemLoader(os.path.join(sys.path[0], subdir))
        env    = Environment(loader=loader, trim_blocks=True)
        for filename in os.listdir(os.path.join(sys.path[0], subdir)):
            print(filename)
            dic[filename] = env.get_template(filename)

    def mkdir(self):
        cmd = "mkdir -p %s/utils/" % self.output_dir
        for key in self.config_data['agents'].keys():
            os.system(cmd + key)
        os.system("mkdir -p %s/env" % self.output_dir)

    def run(self):
        for ifname in self.config_data['agents'].keys():
            self.genOneAgent(ifname)
        self.genEnv()

    def genOneAgent(self, ifname):
        fields = self.config_data['agents'][ifname]
        for lastname in self.utilsTemp.keys():
            ofname = os.path.join(self.output_dir, "utils", ifname, ifname + "_" + lastname)
            o = open(ofname, "w")
            o.write(self.utilsTemp[lastname].render(ifname=ifname, fields=fields, time=self.time))
            o.close()

    def genEnv(self):
        prjName = self.config_data["proj_name"]
        modName = self.config_data['module_name']
        for lastname in self.envTemp.keys():
            ofname = os.path.join(self.output_dir, "env", prjName + "_" + modName + "_" + lastname)
            if (lastname == "Makefile"):
                ofname = os.path.join(self.output_dir, "env", "Makefile")
            o = open(ofname, 'w')
            o.write(self.envTemp[lastname].render(cfg=self.config_data, time=self.time))
            o.close()

##########################################################
def parseInput():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", type=str, default="cfg.json", help="configure filename")
    parser.add_argument("-o", type=str, default=os.getcwd(), help="output dir")
    opt = parser.parse_args()
    return opt
    
##########################################################
if __name__ == "__main__":
    cfg = parseInput()
    gen = generator(cfg.i, cfg.o)
    gen.run()
