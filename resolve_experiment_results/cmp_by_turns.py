import os
import copy
import matplotlib.pyplot as plt

file = "./mix/"

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
        if connector != "varada":
            continue
        results[connector] = {}
        # results for each turn
        f = open(path, "r+", encoding="utf-8")
        for line in f:
            content = line.split(":")
            sec = int(content[1])
            exp = content[0]
            query = exp.split(",")[0]
            time = int(exp.split(",")[1].strip())
            if time not in results[connector]:
                results[connector][time] = {}
            if query not in results[connector][time]:
                results[connector][time][query.split(".")[0]] = sec
        f.close()

    return results

def analysis(results, exps):
    # analysis
    print("analysis varada change by time ...")
    # warm
    for time in results["varada"]:
        if time == 0:
            continue
        _avg = 0
        _max = 0
        for exp in exps:
            _avg += (results["varada"][time - 1][exp] - results["varada"][time][exp]) / results["varada"][time - 1][exp]
            _max = max(_max, (results["varada"][time - 1][exp] - results["varada"][time][exp]) / results["varada"][time - 1][exp])
        print("for time {}, avg {}, max {}".format(time, _avg / len(exps), _max))

def draw_pic():
    # pic config
    bar_width = 9
    cnames = {
        'black': '#000000',
        'blue': '#0000FF',
        'blueviolet': '#8A2BE2',
        'brown': '#A52A2A',
        'burlywood': '#DEB887',
        'cadetblue': '#5F9EA0',
        'chartreuse': '#7FFF00',
        'chocolate': '#D2691E',
        'coral': '#FF7F50',
        'cornflowerblue': '#6495ED',
        'cornsilk': '#FFF8DC',
        'crimson': '#DC143C',
        'cyan': '#00FFFF',
        'darkblue': '#00008B',
        'darkcyan': '#008B8B',
        'darkgoldenrod': '#B8860B',
        'darkgray': '#A9A9A9',
        'darkgreen': '#006400',
        'darkkhaki': '#BDB76B',
        'darkmagenta': '#8B008B',
        'darkolivegreen': '#556B2F',
        'darkorange': '#FF8C00',
        'darkorchid': '#9932CC',
        'darkred': '#8B0000',
        'darksalmon': '#E9967A',
        'darkseagreen': '#8FBC8F',
        'darkslateblue': '#483D8B',
        'darkslategray': '#2F4F4F',
        'darkturquoise': '#00CED1',
        'darkviolet': '#9400D3',
        'deeppink': '#FF1493',
        'deepskyblue': '#00BFFF',
        'dimgray': '#696969',
        'dodgerblue': '#1E90FF',
        'firebrick': '#B22222',
        'floralwhite': '#FFFAF0',
        'forestgreen': '#228B22',
        'fuchsia': '#FF00FF',
        'gainsboro': '#DCDCDC',
        'ghostwhite': '#F8F8FF',
        'gold': '#FFD700',
        'goldenrod': '#DAA520',
        'gray': '#808080',
        'green': '#008000',
        'greenyellow': '#ADFF2F',
        'honeydew': '#F0FFF0',
        'hotpink': '#FF69B4',
        'indianred': '#CD5C5C',
        'indigo': '#4B0082',
        'ivory': '#FFFFF0',
        'khaki': '#F0E68C',
        'lavender': '#E6E6FA',
        'lavenderblush': '#FFF0F5',
        'lawngreen': '#7CFC00',
        'lemonchiffon': '#FFFACD',
        'lightblue': '#ADD8E6',
        'lightcoral': '#F08080',
        'lightcyan': '#E0FFFF',
        'lightgoldenrodyellow': '#FAFAD2',
        'lightgreen': '#90EE90',
        'lightgray': '#D3D3D3',
        'lightpink': '#FFB6C1',
        'lightsalmon': '#FFA07A',
        'lightseagreen': '#20B2AA',
        'lightskyblue': '#87CEFA',
        'lightslategray': '#778899',
        'lightsteelblue': '#B0C4DE',
        'lightyellow': '#FFFFE0',
        'lime': '#00FF00',
        'limegreen': '#32CD32',
        'linen': '#FAF0E6',
        'magenta': '#FF00FF',
        'maroon': '#800000',
        'mediumaquamarine': '#66CDAA',
        'mediumblue': '#0000CD',
        'mediumorchid': '#BA55D3',
        'mediumpurple': '#9370DB',
        'mediumseagreen': '#3CB371',
        'mediumslateblue': '#7B68EE',
        'mediumspringgreen': '#00FA9A',
        'mediumturquoise': '#48D1CC',
        'mediumvioletred': '#C71585',
        'midnightblue': '#191970',
        'mintcream': '#F5FFFA',
        'mistyrose': '#FFE4E1',
        'moccasin': '#FFE4B5',
        'navajowhite': '#FFDEAD',
        'navy': '#000080',
        'oldlace': '#FDF5E6',
        'olive': '#808000',
        'olivedrab': '#6B8E23',
        'orange': '#FFA500',
        'orangered': '#FF4500',
        'orchid': '#DA70D6',
        'palegoldenrod': '#EEE8AA',
        'palegreen': '#98FB98',
        'paleturquoise': '#AFEEEE',
        'palevioletred': '#DB7093',
        'papayawhip': '#FFEFD5',
        'peachpuff': '#FFDAB9',
        'peru': '#CD853F',
        'pink': '#FFC0CB',
        'plum': '#DDA0DD',
        'powderblue': '#B0E0E6',
        'purple': '#800080',
        'red': '#FF0000',
        'rosybrown': '#BC8F8F',
        'royalblue': '#4169E1',
        'saddlebrown': '#8B4513',
        'salmon': '#FA8072',
        'sandybrown': '#FAA460',
        'seagreen': '#2E8B57',
        'seashell': '#FFF5EE',
        'sienna': '#A0522D',
        'silver': '#C0C0C0',
        'skyblue': '#87CEEB',
        'slateblue': '#6A5ACD',
        'slategray': '#708090',
        'snow': '#FFFAFA',
        'springgreen': '#00FF7F',
        'steelblue': '#4682B4',
        'tan': '#D2B48C',
        'teal': '#008080',
        'thistle': '#D8BFD8',
        'tomato': '#FF6347',
        'turquoise': '#40E0D0',
        'violet': '#EE82EE',
        'wheat': '#F5DEB3',
        'white': '#FFFFFF',
        'whitesmoke': '#F5F5F5',
        'yellow': '#FFFF00',
        'yellowgreen': '#9ACD32'}

    colors = list(cnames.keys())



    # draw
    logs = connector_logs()
    results = resolve_results(logs)

    exps = []
    for i in range(1, 23):
        if i == 21:
            continue
        if i < 10:
            exps.append("q0" + str(i))
        else:
            exps.append("q" + str(i))

    analysis(results, exps)
    # get y
    ys = []
    for connector in results:
        for type in results[connector]:
            type_y = []
            for exp in exps:
                type_y.append(results[connector][type][exp])
            ys.append([connector + "_" + str(type), copy.deepcopy(type_y)])
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
            plt.bar(xs[_], ys[_][1], width=bar_width, color=colors[_], label="presto")
        else:
            plt.bar(xs[_], ys[_][1], width=bar_width, color=colors[_], label=ys[_][0])

    # 刻度
    plt.xticks(x_ticks, exps, rotation=275)

    ax = plt.axes()
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)

    # plt.title("Accelerate")

    plt.ylabel("Completion time(sec)")

    # plt.grid(axis="y", ls="--")
    # 展示
    # plt.legend( ncol=3, frameon=False, bbox_to_anchor=(0, 1))
    # plt.legend('boxoff')
    # plt.legend(loc='upper center', ncol=4, frameon=False)


    plt.show()


print(draw_pic())




