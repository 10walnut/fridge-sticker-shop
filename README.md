# 定制冰箱贴商城项目

一个基于Django + Vue.js的定制冰箱贴电商平台。

## 功能特性

- 🎨 在线图片处理与定制
- 🛒 购物车与订单管理
- 💳 支付集成（支付宝/微信支付）
- 📱 响应式设计
- 🔐 用户认证系统
- 📊 订单分析统计

## 技术栈

### 后端
- Django 4.x
- Django REST Framework
- PostgreSQL/SQLite
- Redis
- Celery

### 前端
- Vue.js 3
- Vite
- Element Plus

## 快速开始

### 安装

```bash
# 克隆项目
git clone https://github.com/10walnut/fridge-sticker-shop.git
cd fridge-sticker-shop

# 运行安装脚本
./install.sh
```

### 启动

```bash
# 启动所有服务
./start.sh
```

### 访问地址

- 前端: http://localhost:3000
- 后端API: http://localhost:8000
- 管理后台: http://localhost:8000/admin

## 项目结构

```
├── backend/           # Django后端
│   ├── apps/         # 应用模块
│   ├── backend/      # 项目配置
│   └── requirements.txt
├── frontend/         # Vue.js前端
│   ├── src/
│   └── package.json
├── install.sh        # 安装脚本
└── start.sh         # 启动脚本
```

## 开发说明

### 环境要求

- Python 3.9+
- Node.js 16+
- PostgreSQL (可选，默认使用SQLite)
- Redis

### 开发模式

```bash
# 后端开发
cd backend
python manage.py runserver

# 前端开发
cd frontend
npm run dev

# Celery任务队列
cd backend
celery -A backend worker -l info
```

## 支付配置

项目支持支付宝和微信支付，需要在环境变量中配置相应的密钥。

## License

MIT License