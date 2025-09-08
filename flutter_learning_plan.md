# 📖 Flutter 学习计划（14 天）

## 第 1 周 ------ 基础与 UI 入门

**Day 1: 环境搭建 & Dart 入门** - 安装 Flutter SDK，配置 iOS 环境 - 学习
Dart 语法：变量、函数、类、async/await - 练习：写一个 Dart
控制台计算器 - 资源: - [Flutter
安装指南](https://docs.flutter.dev/get-started/install) - [Dart
语言](https://dart.dev/language)

**Day 2: Flutter 项目结构** - 熟悉 `lib/main.dart`、`pubspec.yaml` -
新建 Flutter 项目并运行 Hello World - 资源: - [Your first Flutter
app](https://docs.flutter.dev/get-started/codelab)

**Day 3: Widget 基础** - 学习 StatelessWidget / StatefulWidget -
练习：写一个登录页 - 资源: - [Introduction to
widgets](https://docs.flutter.dev/development/ui/widgets-intro)

**Day 4: 布局与样式** - 学习 Row / Column / Stack - 练习：三页 Tab
页面 - 资源: - [Layout
widgets](https://docs.flutter.dev/development/ui/widgets/layout)

**Day 5: 路由与导航** - 学习 Navigator.push / pop - 练习：登录 →
首页跳转 - 资源: - [Navigation &
routing](https://docs.flutter.dev/cookbook/navigation/navigation-basics)

**Day 6: 列表与滚动** - 学习 ListView / GridView -
练习：写一个商品列表 - 资源: -
[ListView](https://docs.flutter.dev/cookbook/lists/basic-list)

**Day 7: 小结 & Demo** - 登录 → 首页 → 列表 Demo - 打包到 iOS 真机 -
资源: - [Build and release for
iOS](https://docs.flutter.dev/deployment/ios)

------------------------------------------------------------------------

## 第 2 周 ------ 进阶与平台能力

**Day 8: 网络请求** - 使用 http 请求 API - 展示天气接口数据 - 资源: -
[Fetch data from the
internet](https://docs.flutter.dev/cookbook/networking/fetch-data)

**Day 9: 状态管理** - 学习 Provider - 练习：保存登录状态 - 资源: -
[Provider](https://pub.dev/packages/provider)

**Day 10: 本地存储** - 学习 shared_preferences / sqflite -
练习：保存用户 Token - 资源: -
[shared_preferences](https://pub.dev/packages/shared_preferences)

**Day 11: 插件与原生交互** - 学习 Platform Channel - 练习：Flutter 调用
iOS 原生方法 - 资源: - [Platform
channels](https://docs.flutter.dev/development/platform-integration/platform-channels)

**Day 12: 多平台适配** - 学习屏幕适配 & 国际化 - 练习：MediaQuery
适配屏幕 - 资源: - [Responsive
design](https://docs.flutter.dev/development/ui/layout/adaptive-responsive)

**Day 13: 集成 Flutter 到 iOS** - 在原生 iOS 工程嵌入 Flutter 模块 -
资源: - [Add Flutter to existing iOS
app](https://docs.flutter.dev/add-to-app/ios/project-setup)

**Day 14: 总结与实战** - 完成小型跨平台商城 App - 打包 iOS / Android -
资源: - [Build and release a Flutter
app](https://docs.flutter.dev/deployment)

------------------------------------------------------------------------

# 🚀 最终 Demo 项目 ------ 小型跨平台商城 App

## 功能模块

### 1. 登录 / 注册

-   手机号 + 密码输入
-   登录后保存 Token
-   状态管理：Provider

### 2. 首页（Tab 导航）

-   底部 3 个 Tab：商品列表 / 我的订单 / 设置

### 3. 商品列表

-   ListView 展示商品
-   点击跳转详情
-   数据来源：API

### 4. 商品详情

-   展示商品信息
-   加入购物车 → Provider 状态管理

### 5. 我的订单

-   展示购物车商品
-   支持清空购物车

### 6. 设置

-   显示用户信息
-   退出登录
-   获取设备型号（调用 iOS 原生）

------------------------------------------------------------------------

# 📂 项目结构设计

    lib/
    ├── main.dart                  # 程序入口
    ├── app.dart                   # App 根部 (MaterialApp + 路由)
    │
    ├── models/                    # 数据模型
    │   ├── product.dart
    │   ├── user.dart
    │
    ├── services/                  # 数据服务层
    │   ├── api_service.dart
    │   ├── storage_service.dart
    │   ├── native_service.dart
    │
    ├── providers/                 # 状态管理
    │   ├── auth_provider.dart
    │   ├── cart_provider.dart
    │
    ├── pages/                     # 页面层
    │   ├── login/login_page.dart
    │   ├── home/home_page.dart
    │   ├── home/product_list_page.dart
    │   ├── home/product_detail_page.dart
    │   ├── home/order_page.dart
    │   ├── home/settings_page.dart
    │
    ├── widgets/                   # 自定义组件
    │   ├── product_card.dart
    │   ├── custom_button.dart
    │
    └── utils/                     # 工具类
        ├── constants.dart
        ├── routes.dart
