# VfpWebDemo

这是一个按 `West Wind Web Connection` 常见项目结构整理的最小示例工程。

## 目录说明

- `Web/`
  - 静态页面、手机演示页、默认入口页
- `Deploy/`
  - Web Connection 服务器代码、启动脚本、配置文件
- `Data/`
  - 本地数据目录占位

## 运行前提

- `Visual FoxPro 9.0` 或 `VFP Advanced`
- `West Wind Web Connection`
- `IIS` 或 `IIS Express`

## 开发启动

1. 设置系统环境变量 `WC_HOME` 指向 Web Connection 安装目录
2. 在 VFP IDE 中切换到 `projects/VfpWebDemo/Deploy`
3. 执行：

```foxpro
DO Launch
```

如果你更想只启动本地服务器，再自行打开浏览器，也可以执行：

```foxpro
DO Load
```

## 默认访问地址

- `http://localhost/vfpwebdemo/default.htm`
- `http://localhost/vfpwebdemo/ping.vapi`
- `http://localhost/vfpwebdemo/mobile-demo.html`

## 路由约定

本示例把 `.vapi` 作为 REST 服务脚本扩展，因此：

- `ping.vapi` 对应 `ApiProcess.Ping`
- `login.vapi` 对应 `ApiProcess.Login`
- `orders.vapi` 对应 `ApiProcess.Orders`
- `saveorder.vapi` 对应 `ApiProcess.SaveOrder`

## 备注

- 当前工程骨架对齐了 Web Connection 官方文档中常见的 `Web / Deploy / Data / Launch.prg / SetPaths.prg / Main.prg / _ServerConfig.prg` 布局。
- 若你使用的是 Web Connection Shareware，官方文档说明即便没有自动生成项目文件和 EXE，仍可通过 `DO <YourProject>Main.prg` 直接运行主程序。
