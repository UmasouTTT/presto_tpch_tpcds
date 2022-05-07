import matplotlib.pyplot as plt

def draw_pic():
    # pic config
    plt.figure(figsize=(8, 5))
    bar_width = 100
    color = ["red", "dodgerblue", "orange", "grey", "green"]

    ys = [["varada"], ["presto"]]

    ys = [[9307, 25954, 14312, 11565, 11263], [5620, 17239, 12648, 11154, 10863]]

    # get x
    xs = [100, 200, 300, 400, 500, 800, 900, 1000, 1100, 1200]

    for _ in range(len(ys[0])):
        if 0 == _:

            plt.bar(xs[_], ys[0][_], width=bar_width, color=color[_], label="presto")
            plt.bar(xs[_ + 5], ys[1][_], width=bar_width, color=color[_],)
        else:
            plt.bar(xs[_], ys[0][_], width=bar_width, color=color[_], label="varada_" + str(_-1))
            plt.bar(xs[_ + 5], ys[1][_], width=bar_width, color=color[_])

    # 刻度

    plt.xticks([300, 1000], ["parquet", "orc"])


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

draw_pic()