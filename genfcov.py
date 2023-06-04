#********************************************************************************
#** Author       : zhuhw                                                       **
#** Email        : zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn                      **
#** Last modified: 2023-06-03 15:19:22                                         **
#** Filename     : genfcov.py                                                  **
#** Phone Number : 15388232083                                                 **
#** Discription  :                                                             **
#********************************************************************************
import re
import os
import sys
import jinja2

#********************************************************************************
#** Author      : zhuhw                                                        **
#** Description : Create                                                       **
#*******************************************************************************/
class Field:
    def __init__(self, name="f", width=1, dmin=0, dmax=1):
        self.name   = name
        self.width  = int(width)
        self.dmin   = int(dmin)
        self.dmax   = int(dmax)

#********************************************************************************
#** Author      : zhuhw                                                        **
#** Description : Create                                                       **
#*******************************************************************************/
class Covergroup:
    def __init__(self, name, describ, cross_ignore=""):
        self.name         = name
        self.describ      = describ
        self.cross_ignore = cross_ignore
        self.fields       = []
        self.cignores     = []

    def parse_info_0(self, info):
        ma = re.match(r'([a-zA-Z0-9_]+)<(\d+)\[(\d+):(\d+)\]>', info.strip())
        if not ma: return False
        field = Field(ma.group(1), ma.group(2), ma.group(4), ma.group(3))
        self.fields.append(field)
        return True

    def parse_info_1(self, info):
        ma = re.match(r'([a-zA-Z0-9_]+)<(\d+)>', info.strip())
        if not ma: return False
        width = int(ma.group(2))
        field = Field(ma.group(1), width, 0, 2**width - 1)
        self.fields.append(field)
        return True

    def parse_info_2(self, info):
        ma = re.match(r'([a-zA-Z0-9_]+)', info.strip())
        if not ma: return False
        field = Field(ma.group(1), 1, 0, 1)
        self.fields.append(field)
        return True

    def parse_cross_ignore(self):
        if self.cross_ignore == "":return
        infos = self.cross_ignore.split(";")
        for info in infos:
            ignores = info.split('#')
            cignore = {}
            for i in range(len(ignores)):
                if (len(ignores[i].strip()) == 0):continue
                cignore[self.fields[i].name] = ignores[i]
            self.cignores.append(cignore)
            print(cignore)
        return

    def parse(self):
        infos = self.describ.split(',')
        for info in infos:
            if (self.parse_info_0(info)): continue
            if (self.parse_info_1(info)): continue
            if (self.parse_info_2(info)): continue
        self.parse_cross_ignore()
        pass

#********************************************************************************
#** Author      : zhuhw                                                        **
#** Description : Create                                                       **
#*******************************************************************************/
class Generator:
    def __init__(self):
        self.covergroups = []
        self.loader   = jinja2.FileSystemLoader(os.path.join(sys.path[0]))
        self.env      = jinja2.Environment(loader=self.loader, trim_blocks=True)
        self.template = self.env.get_template("fcov.sv")

    def parse(self, path):
        f = open(path, "r")
        for line in f.readlines():
            ma = re.match(r'\s*//fcov::(.*)\((.*)\)', line)
            mb = re.match(r'\s*//fcov::(.*)\((.*)\)\{(.*)\}', line)
            if not ma and not mb: continue
            if mb:
                cg = Covergroup(mb.group(1), mb.group(2), mb.group(3))
            elif ma:
                cg = Covergroup(ma.group(1), ma.group(2))
            cg.parse()
            self.covergroups.append(cg)
        f.close()
        pass

    def create_fcov(self):
        f = open("tfcov.sv", "w")
        for cg in self.covergroups:
            f.write(self.template.render(cg=cg))
        f.close()
        pass

#********************************************************************************
#** Author      : zhuhw                                                        **
#** Description : Create                                                       **
#*******************************************************************************/
if __name__ == "__main__":
    gen = Generator()
    gen.parse(sys.argv[1])
    gen.create_fcov()
