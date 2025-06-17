#!/bin/bash

echo "=== 冰箱贴定制独立站系统安装脚本 ==="

# 检查Python版本
python_version=$(python3 --version 2>/dev/null | awk '{print $2}' | cut -d. -f1-2)
if [ -z "$python_version" ] || [ "$(printf '%s\n' "3.9" "$python_version" | sort -V | head -n1)" != "3.9" ]; then
    echo "❌ 需要Python 3.9或更高版本"
    exit 1
fi

# 检查Node.js版本
node_version=$(node --version 2>/dev/null | cut -d'v' -f2 | cut -d. -f1)
if [ -z "$node_version" ] || [ "$node_version" -lt 16 ]; then
    echo "❌ 需要Node.js 16或更高版本"
    exit 1
fi

echo "✅ 环境检查通过"

# 创建Python虚拟环境
echo "📦 创建Python虚拟环境..."
python3 -m venv venv
source venv/bin/activate

# 安装后端依赖
echo "📦 安装后端依赖..."
cd backend
pip install -r requirements.txt

# 创建环境变量文件
if [ ! -f .env ]; then
    echo "📝 创建环境变量文件..."
    cat > .env << EOF
DEBUG=True
SECRET_KEY=django-insecure-dev-key-change-in-production
DB_NAME=fridge_sticker_db
DB_USER=postgres
DB_PASSWORD=password
DB_HOST=localhost
DB_PORT=5432
REDIS_URL=redis://localhost:6379/0
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
STRIPE_PUBLIC_KEY=
STRIPE_SECRET_KEY=
ALIPAY_APP_ID=
ALIPAY_PRIVATE_KEY=
EOF
fi

# 数据库迁移
echo "🗄️ 执行数据库迁移..."
python manage.py makemigrations
python manage.py migrate

# 创建超级用户
echo "👤 创建管理员账户..."
echo "请输入管理员信息："
python manage.py createsuperuser

# 加载初始数据
echo "📋 加载初始数据..."
python manage.py loaddata initial_data.json 2>/dev/null || echo "未找到初始数据文件，跳过..."

cd ..

# 安装前端依赖
echo "📦 安装前端依赖..."
cd frontend
npm install

cd ..

echo "✅ 安装完成！"
echo ""
echo "🚀 启动说明："
echo "1. 启动Redis: redis-server"
echo "2. 启动Celery: cd backend && celery -A backend worker -l info"
echo "3. 启动后端: cd backend && python manage.py runserver"
echo "4. 启动前端: cd frontend && npm run dev"
echo ""
echo "🌐 访问地址："
echo "- 前端: http://localhost:3000"
echo "- 后端API: http://localhost:8000"
echo "- 管理后台: http://localhost:8000/admin"
echo "- API文档: http://localhost:8000/api/docs/"