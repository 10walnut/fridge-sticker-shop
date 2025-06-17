#!/bin/bash

echo "🚀 启动冰箱贴定制独立站系统..."

# 检查是否在虚拟环境中
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "📦 激活虚拟环境..."
    source venv/bin/activate
fi

# 启动后端服务
echo "🔧 启动后端服务..."
cd backend
python manage.py runserver &
BACKEND_PID=$!

# 启动Celery
echo "⚙️ 启动Celery..."
celery -A backend worker -l info &
CELERY_PID=$!

cd ..

# 启动前端服务
echo "🎨 启动前端服务..."
cd frontend
npm run dev &
FRONTEND_PID=$!

cd ..

echo "✅ 系统启动完成！"
echo ""
echo "🌐 访问地址："
echo "- 前端: http://localhost:3000"
echo "- 后端API: http://localhost:8000"
echo "- 管理后台: http://localhost:8000/admin"
echo "- API文档: http://localhost:8000/api/docs/"
echo ""
echo "⚠️ 注意事项："
echo "1. 请确保PostgreSQL和Redis服务已启动"
echo "2. 按 Ctrl+C 停止所有服务"
echo ""

# 等待用户中断
wait_for_stop() {
    while true; do
        read -r -n 1 -s key
        if [[ $key = $'\x03' ]]; then # Ctrl+C
            echo ""
            echo "🛑 正在停止所有服务..."
            kill $BACKEND_PID $CELERY_PID $FRONTEND_PID 2>/dev/null
            echo "✅ 所有服务已停止"
            exit 0
        fi
    done
}

trap 'kill $BACKEND_PID $CELERY_PID $FRONTEND_PID 2>/dev/null; exit 0' INT

wait_for_stop