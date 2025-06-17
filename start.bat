@echo off
echo 🚀 启动冰箱贴定制独立站系统 (Windows)...

REM 检查虚拟环境是否存在
if not exist "venv\Scripts\activate.bat" (
    echo ❌ 未找到虚拟环境，请先运行 install.bat 进行安装
    pause
    exit /b 1
)

REM 激活虚拟环境
echo 📦 激活虚拟环境...
call venv\Scripts\activate.bat

REM 检查Redis是否运行
echo 🔍 检查Redis连接...
redis-cli ping >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ Redis未运行，请启动Redis服务
    echo 提示: 运行 redis-server.exe 或启动Redis Windows服务
    pause
)

REM 启动后端服务
echo 🔧 启动后端服务...
cd backend
start "Django Backend" cmd /k "python manage.py runserver"

REM 等待后端启动
timeout /t 3 /nobreak >nul

REM 启动Celery
echo ⚙️ 启动Celery任务队列...
start "Celery Worker" cmd /k "celery -A backend worker -l info"

cd ..

REM 启动前端服务
echo 🎨 启动前端服务...
cd frontend
start "Vue Frontend" cmd /k "npm run dev"

cd ..

echo ✅ 系统启动完成！
echo.
echo 🌐 访问地址：
echo - 前端: http://localhost:3000
echo - 后端API: http://localhost:8000
echo - 管理后台: http://localhost:8000/admin
echo - API文档: http://localhost:8000/api/docs/
echo.
echo ⚠️ 注意事项：
echo 1. 已在新窗口中启动各个服务
echo 2. 请确保PostgreSQL和Redis服务已启动
echo 3. 关闭相应的CMD窗口即可停止对应服务
echo 4. 如需停止所有服务，可关闭所有新开的CMD窗口
echo.
echo 📝 服务窗口说明：
echo - "Django Backend" 窗口: 后端API服务
echo - "Celery Worker" 窗口: 异步任务处理
echo - "Vue Frontend" 窗口: 前端开发服务器
echo.
pause