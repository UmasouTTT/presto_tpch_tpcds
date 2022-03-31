import matplotlib.pyplot as plt

def draw_pic():
    # pic config
    plt.figure(figsize=(8, 5))
    bar_width = 18
    color = ["red", "dodgerblue", "orange", "grey", "green"]

    ys = [["varada"], ["presto"]]

    # get x
    xs = [[] for i in range(len(ys))]
    x_ticks = []
    for i in range(4):
        start = i * 100
        x = [start + j * bar_width for j in range(len(xs))]
        x_ticks.append(x[int(len(x)/2)])
        for _ in range(len(xs)):
            xs[_].append(x[_])

    for _ in range(len(xs)):

        plt.bar(xs[_], ys[_][1], width=bar_width, color=color[_], label=ys[_][0])

    # 刻度

    plt.xticks(x_ticks, ["100GB/parquet", "100GB/orc", "1TB/parquet", "1TB/orc"], rotation=90)


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