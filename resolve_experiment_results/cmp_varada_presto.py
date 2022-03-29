import os
import copy
import matplotlib.pyplot as plt
import numpy as np

file = "./mix/"
drop_queries = []

# connectors
def connector_logs():
    connector_logs = []
    for root, dirs, files in os.walk(file):
        # 遍历文件
        for f in files:
            connector_logs.append(os.path.join(root, f))
    return connector_logs

# get results
def resolve_results(log_paths):
    # connector name
    results = {}
    for path in log_paths:
        connector = path.split("/")[-1].split(".")[0]
        results[connector] = {}
        # results for each turn
        f = open(path, "r+", encoding="utf-8")
        for line in f:
            content = line.split(":")
            sec = int(content[1])
            exp = content[0]
            query = exp.split(",")[0]
            if query in drop_queries:
                continue
            time = exp.split(",")[1].strip()
            if time not in results[connector]:
                results[connector][time] = {}
            if query not in results[connector][time]:
                results[connector][time][query.split(".")[0]] = sec
        f.close()

    return results

def analysis(results, exps):
    # analysis
    print("compare hive with varada ...")
    # warm
    avg_0 = 0
    max_0 = 0
    for exp in exps:
        avg_0 += (results["hive"]["0"][exp] - results["varada"]["0"][exp]) / results["hive"]["0"][exp]
        max_0 = max(max_0, (results["hive"]["0"][exp] - results["varada"]["0"][exp]) / results["hive"]["0"][exp])
    avg_0 /= len(exps)
    print("round 0 : avg increase : {}, max increase : {}".format(avg_0, max_0))
    # 1
    avg_1 = 0
    max_1 = 0
    for exp in exps:
        avg_1 += (results["hive"]["0"][exp] - results["varada"]["1"][exp]) / results["hive"]["0"][exp]
        max_1 = max(max_1, (results["hive"]["0"][exp] - results["varada"]["1"][exp]) / results["hive"]["0"][exp])
    avg_1 /= len(exps)
    print("round 1 : avg increase : {}, max increase : {}".format(avg_1, max_1))
    # 2
    avg_2 = 0
    max_2 = 0
    for exp in exps:
        avg_2 += (results["hive"]["0"][exp] - results["varada"]["2"][exp]) / results["hive"]["0"][exp]
        max_2 = max(max_2, (results["hive"]["0"][exp] - results["varada"]["2"][exp]) / results["hive"]["0"][exp])
    avg_2 /= len(exps)
    print("round 2 : avg increase : {}, max increase : {}".format(avg_2, max_2))
    # 3
    # avg_3 = 0
    # max_3 = 0
    # for exp in exps:
    #     avg_3 += (results["hive"]["0"][exp] - results["varada"]["3"][exp]) / results["hive"]["0"][exp]
    #     max_3 = max(max_3, (results["hive"]["0"][exp] - results["varada"]["3"][exp]) / results["hive"]["0"][exp])
    # avg_3 /= len(exps)
    # print("round 3 : avg increase : {}, max increase : {}".format(avg_3, max_3))
    # whole time
    for type in results:
        print("Connector is {}".format(type))
        for turn in results[type]:
            print("Turn is {}".format(turn))
            whole_time = 0
            for exp in results[type][turn]:
                whole_time += results[type][turn][exp]
            print("Whole time is {}".format(whole_time))

def get_exps():
    exps = []
    for root, dirs, files in os.walk(file):
        # 遍历文件
        for f in files:
            if "hive" in f:
                _f = open(os.path.join(root, f), "r+", encoding="utf-8")
                for line in _f:
                    exps.append(line.strip().split(".")[0])
                _f.close()

    return exps

def draw_pic():
    # pic config
    plt.figure(figsize=(13, 5))
    bar_width = 15
    color = ["red", "dodgerblue", "orange", "grey", "green"]

    # draw
    logs = connector_logs()
    results = resolve_results(logs)

    # exps = []
    # for i in range(1, 23):
    #     if i == 21:
    #         continue
    #     if i < 10:
    #         exps.append("q0" + str(i))
    #     else:
    #         exps.append("q" + str(i))
    exps = get_exps()


    analysis(results, exps)
    # get y
    ys = []
    for connector in results:
        for type in results[connector]:
            type_y = []
            for exp in exps:
                type_y.append(results[connector][type][exp])
            ys.append([connector + "_" + type, copy.deepcopy(type_y)])
    # get x
    xs = [[] for i in range(len(ys))]
    x_ticks = []
    for i in range(len(exps)):
        start = i * 100
        x = [start + j * bar_width for j in range(len(xs))]
        x_ticks.append(x[int(len(x)/2)])
        for _ in range(len(xs)):
            xs[_].append(x[_])

    for _ in range(len(xs)):
        if "hive_0" == ys[_][0]:
            plt.bar(xs[_], ys[_][1], width=bar_width, color=color[_], label="presto")
        else:
            plt.bar(xs[_], ys[_][1], width=bar_width, color=color[_], label=ys[_][0])

    # 刻度

    plt.xticks(x_ticks, exps, rotation=90)


    # bins = np.linspace(-1, 1, 21)  # 横坐标起始和结束值，分割成21份
    # plt.figure(figsize=(13, 5))  # 图像大小
    # plt.xticks(bins)  # 设置x轴
    # plt.xlim(-1, 1)  # x轴开始和结束位置

    ax = plt.axes()
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)

    # plt.title("Accelerate")

    plt.ylabel("Completion time(sec)")

    # plt.grid(axis="y", ls="--")
    # 展示
    # plt.legend( ncol=3, frameon=False, bbox_to_anchor=(0, 1))
    # plt.legend('boxoff')
    plt.legend(loc='upper center', ncol=5, frameon=False)


    plt.show()


print(draw_pic())




