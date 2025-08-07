# Layout Scripts

这是一个包含各种布局脚本工具的项目，用于辅助芯片设计和布局工作。这些脚本可以帮助提高布局效率，自动化重复性任务，以及优化设计流程。

## 功能列表

项目包含以下主要脚本工具（按字母顺序排列）：

- **autoVia.il**: 自动创建过孔
- **autopin.il**: 自动引脚处理
- **calcStdcell.il**: 标准单元计算
- **caseMixed.il**: 大小写混合处理
- **changeLayer.il**: 改变图层
- **ChangeMode.il**: 更改模式
- **checkLogicPins.il**: 检查逻辑引脚
- **countLabelForSch.il**: 统计原理图标签
- **createIOShape.il**: 创建IO形状
- **createLabelXL.il**: 创建XL标签
- **createPathfromCenter.il**: 从中心创建路径
- **createPinforShape.il**: 为形状创建引脚
- **createRulerBbox.il**: 创建边界 rulers
- **createViaForShape.il**: 为形状创建过孔
- **dyfMergeShapes.il**: 合并形状
- **findObjForLayAndSch.il**: 查找布局和原理图对象
- **Findlocationxy.il**: 查找位置坐标
- **FindWindow.il**: 查找窗口
- **fixBoundary.il**: 修复边界
- **getLayFullPath.il**: 获取布局完整路径
- **getLibCellView.il**: 获取库单元视图
- **getNetConnectInfo.il**: 获取网络连接信息
- **getSchHier.il**: 获取原理图层次结构
- **getSchLabels.il**: 获取原理图标签
- **getTopcell.il**: 获取顶层单元
- **layerSelEntry.il**: 图层选择入口
- **layoutToolbar.il**: 布局工具栏
- **modifyLabelCase.il**: 修改标签大小写
- **modifyLabelbit.il**: 修改标签位
- **modifyPremission.il**: 修改权限
- **myDeleteLayer.il**: 删除图层
- **myDeletsclkfile.il**: 删除sclk文件
- **openLaySchCellView.il**: 打开布局/原理图单元视图
- **openLaySchCellView1.il**: 打开布局/原理图单元视图1
- **readLogFile.py**: 读取日志文件
- **removeSchWire.il**: 删除原理图导线
- **repeatCMD.il**: 重复命令
- **replaceLay.il**: 替换布局
- **reportPin.il**: 引脚报告
- **schSaveAll.il**: 保存所有原理图
- **schSelCreatepin.il**: 选择并创建原理图引脚
- **schematicPulldown.il**: 原理图下拉菜单
- **selectBusnet.il**: 选择总线网络
- **selectObj.il**: 选择对象
- **setlayer.il**: 设置图层
- **sortSel.il**: 排序选择
- **StreamOut.il**: 流输出
- **testLayoutXL.il**: 测试布局XL
- **uLabel.il**: 用户标签处理

## 使用方法

1. 将脚本复制到你的设计工具的脚本目录
2. 在设计工具中加载并运行所需的脚本
3. 按照脚本提示进行操作

## 安装指南

1. 克隆此仓库到本地: `git clone https://github.com/dayanMr/layout-scripts.git`
2. 根据你的设计工具要求，配置脚本路径
3. 启动设计工具并加载脚本

## 常用快捷键

以下是一些常用脚本的快捷键（Layout模式下）：

- **Ctrl+x**: 排序选择对象（支持垂直方向排序网络，从左到右） - sortSel.il
- **$**: 从选中对象中心创建路径（支持垂直和水平方向） - createPathfromCenter.il
- **%**: 选择特定类型的过孔 - selectObj.il
- **Shift+8**: 合并选定区域内的形状 - dyfMergeShapes.il
- **Super+`**: 改变图层 - changeLayer.il
- **Shift+O**: 自动创建过孔 - autoVia.il
- **F12**: 打开布局/原理图单元视图 - openLaySchCellView.il
- **4**: 修改标签大小写 - modifyLabelCase.il
- **@**: 用户标签处理 - uLabel.il

## 贡献指南

欢迎贡献新的脚本或改进现有脚本。请遵循以下步骤：

1.  Fork 此仓库
2.  创建你的功能分支: `git checkout -b feature/new-script`
3.  提交你的更改: `git commit -am 'Add new script'`
4.  推送到分支: `git push origin feature/new-script`
5.  创建一个新的 Pull Request

## 参数化单元（PCell）

pcell目录包含以下参数化单元文件，用于创建可配置的标准单元：

- **cdf.il**: 定义了nmos_decap参数化单元的组件描述格式(CDF)，包含宽度(w)、长度(l)、行数(row)和列数(col)等参数的定义和回调函数。
- **filler.il**: 实现填充单元的参数化布局，支持配置长度(l)、接触孔(ct)、行数(row)和金属1层宽度(boldM1)等参数。
- **tap.il**: 实现Tap单元的参数化布局，支持配置宽度(w)、长度(l)、接触孔(ct)、阱类型(nw)等参数。
- **libinit.il**: 初始化库文件，包含加载CDF文件的代码和参数验证回调函数(decapCB)，确保参数值在有效范围内。
- **nmos_decap**: 包含nmos_decap参数化单元的实现。

## 许可证

本项目采用 MIT 许可证 - 详情请见 LICENSE 文件