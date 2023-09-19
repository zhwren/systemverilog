#*******************************************************************************
#*                                  _ooOoo_                                   **
#*                                 o8888888o                                  **
#*                                 88" . "88                                  **
#*                                 (| -_- |)                                  **
#*                                  O\ = /O                                   **
#*                              ____/`---'\____                               **
#*                            .   ' \\| |// `.                                **
#*                             / \\||| : |||// \                              **
#*                           / _||||| -:- |||||- \                            **
#*                             | | \\\ - /// | |                              **
#*                           | \_| ''\---/'' | |                              **
#*                            \ .-\__ `-` ___/-. /                            **
#*                         ___`. .' /--.--\ `. . __                           **
#*                      ."" '< `.____<|>_/___.' >'"".                         **
#*                     | | : `- \`.;` _ /`;.`/ - ` : | |                      **
#*                       \ \ `-. \_ __\ /__ _/ .-` / /                        **
#*               ======`-.____`-.___\_____/___.-`____.-'======                **
#*                                  `=---='                                   **
#*                                                                            **
#*               .............................................                **
#*                      Buddha bless me, No bug forever                       **
#*                                                                            **
#*******************************************************************************
#* Author        : generator                                                  **
#* Email         : zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn                     **
#* Last modified : 2023-09-19 09:34:34                                        **
#* Filename      : genenv.py                                                  **
#* Phone Number  :                                                            **
#* Discription   :                                                            **
#******************************************************************************/
import os
import sys
import json
import time
import argparse
from collections import OrderedDict
from jinja2 import FileSystemLoader,Environment

#*******************************************************************************
#* Time        : 2023-09-19 09:35:28                                           *
#* Author      : zhwren                                                        *
#* Description : Create                                                        *
#*******************************************************************************
class MyTemplate:
    def __init__(self, name, temp):
        self.name = name
        self.template = temp

class Field:
    def __init__(self, name='', width=1):
        self.name = name
        self.width = width

class Agent:
    def __init__(self, name=''):
        self.name = name
        self.fields = []
        self.valids = []
        self.inst_num = 1
        self.inst_type = "master"

    def ParseConfiguration(self, cfg):
        if 'inst_num' in cfg.keys():self.inst_num = cfg['inst_num']
        if 'inst_type' in cfg.keys():self.inst_type = cfg['inst_type']
        if 'valids' in cfg.keys():self.valids = cfg['valids']
        if 'fields' in cfg.keys():
            for fieldName in cfg['fields'].keys():
                self.fields.append(Field(fieldName, cfg['fields'][fieldName]))

class Configuration:
    def __init__(self):
        self.clk = '1ns'
        self.proj = 'test'
        self.module = 't1'
        self.timescale = '1ns/1ns'
        self.agents = []
        self.header = ""
        self.time = time.strftime("%Y-%m-%d %H:%M:%S")
        self.parameter = OrderedDict()
        self.files = []
        self.filelists = []

    def ParseConfiguration(self, cfg):
        if 'clk' in cfg.keys():self.clk = cfg['clk']
        if 'proj' in cfg.keys():self.proj = cfg['proj']
        if 'files' in cfg.keys():self.files = cfg['files']
        if 'module' in cfg.keys():self.module = cfg['module']
        if 'timescale' in cfg.keys():self.timescale = cfg['timescale']
        if 'parameter' in cfg.keys():self.parameter = cfg['parameter']
        if 'filelists' in cfg.keys():self.filelists = cfg['filelists']
        if 'agents' in cfg.keys():
            for agentName in cfg['agents'].keys():
                agent = Agent(agentName)
                agent.ParseConfiguration(cfg['agents'][agentName])
                self.agents.append(agent)

#*******************************************************************************
#* Time        : 2023-09-19 09:38:39                                           *
#* Author      : zhwren                                                        *
#* Description : Create                                                        *
#*******************************************************************************
class Generator:
    def __init__(self):
        self.loader    = FileSystemLoader(os.path.join(sys.path[0]))
        self.env       = Environment(loader=self.loader, trim_blocks=True)
        self.myTemplates = OrderedDict()
        self.head_temp = self.env.from_string("")
        self.GetAllTemplates()
        self.outputPath = os.getcwd()
        self.config = Configuration()
        self.keepNames = ['harness.sv', 'Makefile', 'module_inst.sv', 'tc.list', 'tb.f']

    def GetAllTemplates(self):
        tempPath = os.path.join(sys.path[0], "templates")
        subdirs = [i for i in os.listdir(tempPath) if os.path.isdir(os.path.join(tempPath, i))]
        for subdir in subdirs:
            self.myTemplates[subdir] = []
            tempPath = os.path.join(sys.path[0], "templates", subdir)
            subfiles = [i for i in os.listdir(tempPath) if os.path.isfile(os.path.join(tempPath, i))]
            for subfile in subfiles:
                #temp = self.env.get_template(os.path.join("templates", subdir, subfile))
                temp = self.env.get_template("templates/" + subdir + "/" + subfile)
                self.myTemplates[subdir].append(MyTemplate(subfile, temp))
        pass

    def Run(self, opt):
        self.outputPath = opt.o
        with open(opt.fh, "r") as f:
            self.head_temp = self.env.from_string(f.read())

        with open(opt.i, "r") as f:
            self.config.ParseConfiguration(json.load(f))
        self.GenerateAgents()
        self.GenerateOtherFiles()
        pass

    def GenerateAgents(self):
        for agent in self.config.agents:
            for myTemp in self.myTemplates['agent']:
                filename = "{0}_{1}".format(agent.name, myTemp.name)
                dstPath = os.path.join(self.outputPath, "agent", agent.name)
                os.makedirs(dstPath, exist_ok=True)
                self.config.header = self.head_temp.render(time=self.config.time, filename=filename)
                with open(os.path.join(dstPath, filename), "w") as f:
                    f.write(myTemp.template.render(agent=agent, cfg=self.config))
        pass

    def GenerateOtherFiles(self):
        for subdir in self.myTemplates.keys():
            if subdir == 'agent':continue
            dstPath = os.path.join(self.outputPath, subdir)
            os.makedirs(dstPath, exist_ok=True)
            for myTemp in self.myTemplates[subdir]:
                filename = "{0}_{1}_{2}".format(self.config.proj, self.config.module, myTemp.name)
                if myTemp.name in self.keepNames:filename = myTemp.name
                self.config.header = self.head_temp.render(time=self.config.time, filename=filename)
                with open(os.path.join(dstPath, filename), "w") as f:
                    f.write(myTemp.template.render(cfg=self.config))
        pass

#*******************************************************************************
#* Time        : 2023-09-19 09:44:54                                           *
#* Author      : zhwren                                                        *
#* Description : Create                                                        *
#*******************************************************************************
def ParseInput():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", type=str, default="cfg.json", help="configure filename")
    parser.add_argument("-o", type=str, default=os.getcwd(), help="output dir")
    parser.add_argument("-fh", type=str, default=os.path.join(sys.path[0], "fhead"), help="fileheader")
    opt = parser.parse_args()
    return opt

if __name__ == "__main__":
    gen = Generator()
    gen.Run(ParseInput())
