import os

fileList = os.listdir("mix_varada")
path = "mix_varada"


for n in fileList:
    # 设置旧文件名（就是路径+文件名）
    if "_ds" in n:
        continue

    oldname = path + os.sep + n  # os.sep添加系统分隔符

    # 设置新文件名
    newname = oldname.replace(".sql", "_h.sql")

    os.rename(oldname, newname)  # 用os模块中的rename方法对文件改名
    print(oldname, '======>', newname)