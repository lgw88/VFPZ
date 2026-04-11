# VFP Web 方案示例

一个面向 `Visual FoxPro` 老系统 Web 化的公开示例仓库，内容包括：

- `VFP` 做 `B/S` 的方案说明
- 基于 `West Wind Web Connection` 的项目骨架
- 手机端 `H5` 演示页
- GitHub 发布与维护文档

## 仓库目标

这个仓库不追求“VFP 独自完成全部现代 Web 技术栈”，而是采用更现实的路线：

`IIS + VFP(Web Connection) + SQL Server + H5`

对应职责是：

- `VFP` 负责业务逻辑、权限、数据加工和接口输出
- 浏览器负责 `HTML/CSS/JavaScript` 渲染
- 手机端和桌面端复用同一套 Web 页面和 JSON API

## 快速入口

- 方案文档：[VFP_WEB方案.md](./VFP_WEB%E6%96%B9%E6%A1%88.md)
- GitHub 操作文档：[docs/GitHub发布操作文档.md](./docs/GitHub%E5%8F%91%E5%B8%83%E6%93%8D%E4%BD%9C%E6%96%87%E6%A1%A3.md)
- Web Connection 项目骨架：[projects/VfpWebDemo](./projects/VfpWebDemo)
- 手机端演示页：[projects/VfpWebDemo/Web/mobile-demo.html](./projects/VfpWebDemo/Web/mobile-demo.html)

## 当前内容

- `VFP_WEB方案.md`
  - 方案说明、技术选型、部署建议、风险边界
- `projects/VfpWebDemo/`
  - 按 Web Connection 项目向导常见结构整理的可启动骨架
- `samples/webconnection/`
  - 早期拆分出来的 REST 示例代码
- `samples/web/`
  - 早期独立手机 H5 演示页
- `docs/`
  - 操作文档，包括 GitHub 发布记录

## 直接启动骨架

`projects/VfpWebDemo` 是当前仓库里最接近真实工程形态的目录，结构对齐了 Web Connection 官方向导常见输出：

```text
projects/VfpWebDemo
├─Data
├─Deploy
│  ├─Launch.prg
│  ├─Load.prg
│  ├─SetPaths.prg
│  ├─VfpWebDemo.ini
│  ├─VfpWebDemoMain.prg
│  ├─VfpWebDemo_ServerConfig.prg
│  ├─ApiProcess.prg
│  └─OrderService.prg
├─Web
│  ├─default.htm
│  └─mobile-demo.html
└─README.md
```

建议启动步骤：

1. 安装 `Visual FoxPro 9.0` 或 `VFP Advanced`
2. 安装 `West Wind Web Connection`
3. 设置环境变量 `WC_HOME` 指向 Web Connection 安装目录
4. 在 VFP IDE 中打开 `projects/VfpWebDemo/Deploy`
5. 运行 `DO Launch`

默认测试地址：

- `http://localhost/vfpwebdemo/default.htm`
- `http://localhost/vfpwebdemo/ping.vapi`

说明：

- 仓库创建机器上没有现成的 `VFP` 和 `Web Connection` 运行环境，因此这里完成的是“项目骨架整理 + 启动文件就位”，没有在当前机器上做最终运行验收。
- `OrderService.prg` 已内置无数据库时的示例返回数据，便于先把接口和页面跑通。

## 公开仓库边界

- `Visual FoxPro 9.0` 的微软官方支持已于 `2015-01-13` 结束
- 这套路线适合延续既有 VFP 资产，不适合作为全新长期平台终局方案
- 当前代码是教学和起步骨架，不包含真实业务数据和生产配置

## 维护文档

- 发布到 GitHub 的操作记录见 `docs/GitHub发布操作文档.md`
- 若后续加入数据库连接或部署脚本，请先排除真实账号、密码和生产连接串
