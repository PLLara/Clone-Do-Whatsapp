from hashlib import new
from urllib.request import urlopen
from bs4 import BeautifulSoup

file = open('index.html', encoding="utf8")
bs = BeautifulSoup(file,'html.parser')

linhas = bs.find_all('tr')

name, number  = [],[]
for x in linhas:
    children = x.findChildren("td")
    if len(children) >= 1:
        newFullName = children[0].text.replace("\n", " ").strip()
        newName = children[1].text.split()[0]
        newNumber = children[2].text.split()
        name.append(newName)
        number.append(newNumber)
        if len(newNumber) > 0 and newName.lower() != '/':
            print('Location(\''+ newFullName + "\',\'" + newName.lower() + '\',' + newNumber[0] + '),')

