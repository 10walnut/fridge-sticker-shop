# 项目结构说明

本项目是一个定制冰箱贴商城系统，基于Django + Vue.js构建。

## 已清理的无用文件

以下文件已在清理过程中被删除：

### 版本号文件
- backend/0.11.0, 0.27.0, 1.14.0, 1.24.0, 1.29.0, 10.0.0, 2.0.0, 2.5.0, 2.9.0, 21.0.0, 3.1.0, 3.14.0, 3.2.0, 4.2, 4.3.0, 4.8.0, 5.0.0, 5.3.0, 6.6.0, 7.0.0

### 测试和调试文件
- test_*.py (所有测试文件)
- debug_*.py (所有调试文件)
- simple_test.py
- check_db.py

### 临时文件
- processed_*.png (所有处理过的图片)
- *.sqlite3 (数据库文件)

### 多余的脚本文件
- install.bat, install-dev.bat, install-fix.bat
- start.bat, start-dev.bat, start-simple.bat, start-docker.bat
- build-docker.bat

### 工具文件
- iconfont_downloader.py
- download_result.py

### 不必要的文档
- WINDOWS_INSTALL_FIX.md
- 支付问题修复说明.md
- STARTUP_GUIDE.md
- PAYMENT_SETUP.md
- QUICK_START.md
- usage.md
- 图标资源报告.md

### 运行时文件夹
- venv/ (虚拟环境)
- backend/venv/
- backend/logs/
- backend/media/

## 保留的核心文件

### 根目录
- README.md (项目说明)
- .gitignore (Git忽略文件)
- install.sh (安装脚本)
- start.sh (启动脚本)
- docker-compose.yml (Docker配置)
- deployment.md (部署说明)

### 后端 (Django)
- backend/manage.py
- backend/requirements.txt
- backend/backend/ (Django项目配置)
- backend/apps/ (应用模块)
  - users/ (用户管理)
  - products/ (产品管理)
  - orders/ (订单管理)
  - payments/ (支付管理)
  - images/ (图片处理)
  - analytics/ (数据分析)

### 前端 (Vue.js)
- frontend/package.json
- frontend/index.html
- frontend/src/ (源码目录)
- frontend/public/ (静态资源)

## 使用说明

1. **安装**: 运行 `./install.sh`
2. **启动**: 运行 `./start.sh`
3. **访问**: 
   - 前端: http://localhost:3000
   - 后端: http://localhost:8000
   - 管理后台: http://localhost:8000/admin

## 技术栈

- **后端**: Django 4.x + DRF + PostgreSQL + Redis + Celery
- **前端**: Vue.js 3 + Vite + Element Plus
- **部署**: Docker + Nginx