# Multi Shop Link - 部署仓库

多店管理系统自动构建的可运行成品。由 GitHub Actions 从源码仓库自动同步。

当前版本：v1.1.6

## 快速部署

### Docker 部署（推荐）
```bash
git clone https://ghfast.top/https://github.com/MingTu01/multi-shop-link-deploy.git
cd multi-shop-link-deploy
docker-compose up -d
```

### 直接部署
```bash
git clone https://ghfast.top/https://github.com/MingTu01/multi-shop-link-deploy.git
cd multi-shop-link-deploy
npm install
node --import tsx src/index.ts
```

默认管理员：admin / 123456

## 在线更新

已部署的系统可通过 Web 端一键更新：
1. 管理员登录 → 系统设置 → 系统升级
2. 点击「检查更新」→「执行更新」
3. 系统自动完成备份、下载、更新、重启

## 相关仓库

- 源码仓库：https://github.com/MingTu01/multi-store-manager

## 说明

此仓库不接受手动 PR。所有更新通过 GitHub Actions 从源码仓库自动同步。
