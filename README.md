# aocoin-ios

### 1.关于 AoCoin

澳波钱包是一款专业的多币种钱包，目前支持TRON、ETH、Polkadot 、Kusama 、Kulupu等公链，构建了一个完善的 DApp 生态系统，致力于为用户提供更稳定更安全的资产增值方式。

### 2.运行

##### 2.1运行环境
  
`iOS 11.0+`
`Xcode 11+`

##### 2.2运行
	
	1.clone aocoin-ios
	git clone https://github.com/AoCoin-Lab/aocoin-ios.git
	2.打开 Aocoin.xcworkspace，运行
	Command+R
	
##### 2.3 依赖项
    #js 与 原生交互
    pod 'WebViewJavascriptBridge', '~> 6.0.3'
    #加载框
    pod 'MBProgressHUD', '~> 1.1.0'
    #数据库
    pod 'Realm', '~> 3.14.1'
    #下拉刷新，上拉加载
    pod 'MJRefresh'
    #导航栏
    pod 'RTRootNavigationController'
	
	
### 3.功能

##### 3.1 已实现功能

- 创建钱包
- 导入钱包
  - 助记词导入 
  - 私钥导入 
  - keystore导入
- 获取钱包资产
- 转账；
- 多公链/钱包的切换；

##### 3.2待实现功能：

- 治理
- 质押
- 交易记录、交易详情；
- 手续费展示
- 钱包的管理

### 4.Todos

- **Realm 数据库在使用时未进行加密，需自行添加**


### 5.更多
Website: https://aocoin.io 

github: https://github.com/AoCoin-Lab