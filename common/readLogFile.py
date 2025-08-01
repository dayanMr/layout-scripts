import sys
args = sys.argv 
logPath = args[1]
writeFilePath = args[2]
def readLogFile1(readPath ,writeFilePath): 
	res=""
	with open(readPath, 'rb') as f:
		lines = f.readlines()
		for i in range(len(lines)-1,-1,-1):
			if b"\\a getRepeatCMD()\n" == lines[i]:
				for j in range(i-1,-1,-1):
					res = lines[j] + res
					if b"\\a getRepeatCMD()\n" in lines[j]:
						break
				break
	with open(writeFilePath ,"wb") as f:
		f.write(res)

def readLogFile(readPath ,writeFilePath): 
	res=""
	with open(readPath, 'rb') as f:
		lines = f.readlines()
		for i in range(len(lines)-1,-1,-1):
			res = lines[i] + res
			if b"\\a getRepeatCMD()\n" == lines[i]:
				break
	res = res.split("\n")
	ignoreList = ["\\a getRepeatCMD()","\\a hiZoomInAtMouse()","\\a hiZoomIn()","\\a addPoint(hiGetCommandPoint())"]
	with open(writeFilePath ,"wb") as f:
		for line in res:
			if line.startswith("\\a"):
				if line in ignoreList:
					continue
				else:
					f.write(line.split(' ',1)[1]+"\n")
readLogFile(logPath ,writeFilePath)


"""
case1
\a hiZoomIn()
\i 1240.626:1232.655
\p > 
\a addPoint(hiGetCommandPoint())
\i 1602.114:677.512
hiZoomIn(getCurrentWindow() 1240.626:1232.655 1602.114:677.512)


case2
\a hiZoomInAtMouse()
\i 1072.638:-182.234
\r t
ignore

case3
\a only
"""
