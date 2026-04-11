# GitHub 发布操作文档

## 1. 文档目的

本文件记录当前项目发布到 `GitHub` 的操作过程、已完成步骤、阻塞点和后续命令，便于重复执行和审计留痕。

## 2. 执行时间

- 操作日期：`2026-03-28`
- 工作目录：`F:\CodeX\Project\VFP`

## 3. 当前项目内容

- `VFP_WEB方案.md`
- `README.md`
- `samples/webconnection/ApiProcess.prg`
- `samples/webconnection/OrderService.prg`
- `samples/web/mobile-demo.html`

## 4. 已完成操作

### 4.1 补充仓库基础文件

已创建：

- `README.md`
- `.gitignore`
- `docs/GitHub发布操作文档.md`

### 4.2 本机环境检查结果

已检查以下条件：

- 当前目录最初不是 Git 仓库
- 已安装 `git`
- 已安装 `gh` 命令行工具
- 当前未检测到全局 Git 用户名
- 当前未检测到全局 Git 邮箱
- 当前未检测到 `GITHUB_TOKEN` 或 `GH_TOKEN`
- 当前 `gh auth status` 显示尚未登录任何 GitHub 主机

### 4.3 本次已实际执行的 Git 操作

已执行：

```powershell
git init
git branch -M main
git config user.name "serve"
git config user.email "serve@local"
git add .
git commit -m "Initial commit: VFP web solution and samples"
```

执行结果：

- 已创建本地 Git 仓库
- 当前分支：`main`
- 首次提交已完成
- 当前提交号：`bd047b3`

说明：

- 由于当前机器没有预设 Git 提交身份，本次先在仓库级别设置了最小可用身份：
  - `user.name = serve`
  - `user.email = serve@local`
- 若后续需要与你的 GitHub 账号严格关联，建议改为你自己的 Git 用户名和邮箱后再继续提交

## 5. 建议的发布方式

优先推荐下面两种方式之一：

### 方式 A：先在 GitHub 网站创建空仓库，再推送

适用场景：

- 本机没有 `gh`
- 需要由仓库所有者自己决定仓库名、可见性和组织归属

步骤：

1. 在 GitHub 上创建一个空仓库，例如：`VFP`
2. 不要勾选自动生成 `README`、`.gitignore`、`LICENSE`
3. 复制仓库 URL，例如：

```text
https://github.com/<your-account>/VFP.git
```

4. 在本目录执行以下命令：

```powershell
git init
git branch -M main
git config user.name "你的Git提交名"
git config user.email "你的Git邮箱"
git add .
git commit -m "Initial commit: VFP web solution and samples"
git remote add origin https://github.com/<your-account>/VFP.git
git push -u origin main
```

### 方式 B：安装 GitHub CLI 后创建仓库并推送

适用场景：

- 允许在本机安装 `gh`
- 已准备好完成 GitHub 登录认证

参考命令：

```powershell
winget install --id GitHub.cli -e
gh auth login
git init
git branch -M main
git config user.name "你的Git提交名"
git config user.email "你的Git邮箱"
git add .
git commit -m "Initial commit: VFP web solution and samples"
gh repo create VFP --private --source . --remote origin --push
```

## 6. 本次实际执行建议

由于当前环境中：

- 虽已安装 `gh`，但尚未完成 GitHub 登录
- 没有现成 GitHub 远程地址
- 没有可用 GitHub 认证信息

因此最稳妥的实际落地方式是：

1. 先在本地完成 Git 初始化和首次提交
2. 再补入远程仓库 URL
3. 最后执行首次推送

## 6.1 本次实际发布结果

已实际完成 GitHub 仓库创建和首次推送：

- GitHub 账号：`gongke-cxt`
- 仓库名：`VFP`
- 可见性：`private`
- 仓库地址：`https://github.com/gongke-cxt/VFP`
- Git 地址：`https://github.com/gongke-cxt/VFP.git`
- 远程名：`origin`
- 默认分支：`main`

实际执行命令：

```powershell
& 'C:\Program Files\GitHub CLI\gh.exe' repo create VFP --private --source . --remote origin --push
```

执行结果：

- 已创建远程仓库 `gongke-cxt/VFP`
- 已建立本地 `main` 到 `origin/main` 的跟踪关系
- 本地提交已成功推送到 GitHub

### 4.4 仓库公开与元数据设置

已实际执行以下仓库设置：

- 仓库可见性从 `private` 改为 `public`
- 已设置仓库描述
- 已设置 Topics

当前公开仓库地址：

- `https://github.com/gongke-cxt/VFP`

当前描述：

- `Visual FoxPro Web solution with West Wind Web Connection skeleton, mobile H5 demo, and deployment docs.`

当前 Topics：

- `visual-foxpro`
- `foxpro`
- `vfp`
- `web-connection`
- `iis`
- `sql-server`
- `rest-api`
- `mobile-web`

实际执行命令：

```powershell
& 'C:\Program Files\GitHub CLI\gh.exe' repo edit gongke-cxt/VFP --visibility public --accept-visibility-change-consequences --description "Visual FoxPro Web solution with West Wind Web Connection skeleton, mobile H5 demo, and deployment docs." --add-topic visual-foxpro --add-topic foxpro --add-topic vfp --add-topic web-connection --add-topic iis --add-topic sql-server --add-topic rest-api --add-topic mobile-web
```

## 7. 本项目推荐仓库设置

- 仓库名：`VFP`
- 默认分支：`main`
- 可见性：`private`

如果项目仅供内部讨论和方案沉淀，建议使用 `private`。若后续要做开源样例，再改为公开更合适。

## 8. 提交信息建议

首次提交建议：

```text
Initial commit: VFP web solution and samples
```

后续提交建议：

- `docs: refine VFP web solution`
- `feat: add Web Connection sample api`
- `feat: add mobile demo page`

## 9. 风险说明

- 若 Git 提交邮箱与 GitHub 账号邮箱不一致，提交记录可能无法自动关联到 GitHub 账号。
- 若远程仓库已经存在且包含初始化文件，首次推送前应先确认是否要拉取并合并。
- 若后续加入数据库样例，请避免把真实业务数据、账号密码、连接串直接提交到仓库。

## 10. 后续维护建议

- 把数据库连接串放入本地配置文件，不要硬编码进可公开提交的源文件
- 发布前再次检查是否包含真实业务数据
- 每次重要变更都更新本文件，保留可追溯操作记录
