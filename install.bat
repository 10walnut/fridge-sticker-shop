@echo off
echo === 冰箱贴定制独立站系统安装脚本 (Windows) ===

REM 检查Python版本
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未找到Python，请安装Python 3.9或更高版本
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set python_version=%%i
echo 检测到Python版本: %python_version%

REM 检查Node.js版本
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未找到Node.js，请安装Node.js 16或更高版本
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=1" %%i in ('node --version') do set node_version=%%i
echo 检测到Node.js版本: %node_version%

echo ✅ 环境检查通过

REM 创建Python虚拟环境
echo 📦 创建Python虚拟环境...
python -m venv venv
if %errorlevel% neq 0 (
    echo ❌ 创建虚拟环境失败
    pause
    exit /b 1
)

REM 激活虚拟环境
echo 📦 激活虚拟环境...
call venv\Scripts\activate.bat

REM 安装后端依赖
echo 📦 安装后端依赖...
cd backend
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ❌ 安装后端依赖失败
    pause
    exit /b 1
)

REM 创建环境变量文件
if not exist .env (
    echo 📝 创建环境变量文件...
    (
        echo DEBUG=True
        echo SECRET_KEY=django-insecure-dev-key-change-in-production
        echo DB_NAME=fridge_sticker_db
        echo DB_USER=postgres
        echo DB_PASSWORD=password
        echo DB_HOST=localhost
        echo DB_PORT=5432
        echo REDIS_URL=redis://localhost:6379/0
        echo CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
        echo EMAIL_HOST=smtp.gmail.com
        echo EMAIL_PORT=587
        echo EMAIL_HOST_USER=
        echo EMAIL_HOST_PASSWORD=
        echo STRIPE_PUBLIC_KEY=
        echo STRIPE_SECRET_KEY=
        echo ALIPAY_APP_ID=
        echo ALIPAY_PRIVATE_KEY=
    ) > .env
)

REM 数据库迁移
echo 🗄️ 执行数据库迁移...
python manage.py makemigrations
python manage.py migrate
if %errorlevel% neq 0 (
    echo ❌ 数据库迁移失败
    pause
    exit /b 1
)

REM 创建超级用户
echo 👤 创建管理员账户...
echo 请输入管理员信息：
python manage.py createsuperuser

REM 加载初始数据
echo 📋 加载初始数据...
python manage.py loaddata initial_data.json 2>nul || echo 未找到初始数据文件，跳过...

cd ..

REM 安装前端依赖
echo 📦 安装前端依赖...
cd frontend
npm install
if %errorlevel% neq 0 (
    echo ❌ 安装前端依赖失败
    pause
    exit /b 1
)

cd ..

echo ✅ 安装完成！
echo.
echo 🚀 启动说明：
echo 1. 启动Redis: 在Redis安装目录运行 redis-server.exe
echo 2. 启动系统: 双击运行 start.bat
echo    或手动启动各个服务：
echo    - 后端: cd backend ^&^& python manage.py runserver
echo    - Celery: cd backend ^&^& celery -A backend worker -l info
echo    - 前端: cd frontend ^&^& npm run dev
echo.
echo 🌐 访问地址：
echo - 前端: http://localhost:3000
echo - 后端API: http://localhost:8000
echo - 管理后台: http://localhost:8000/admin
echo - API文档: http://localhost:8000/api/docs/
echo.
echo ⚠️ 注意事项：
echo 1. 请确保PostgreSQL和Redis服务已安装并启动
echo 2. 如果使用SQLite，可跳过PostgreSQL安装
echo.
pause