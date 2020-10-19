# 备注：
# AFN 框架有手动修改
# 修改的位置：
# AFURLResponseSerialization.m 文件的 第 226 行（AFJSONResponseSerializer 类 AFJSONResponseSerializer 的 init 方法）
# 修改内容：
# 由：self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
# 修改为：
# self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",nil];
# 修改理由：
# 报错 Code=-1016 "Request failed: unacceptable content-type: text/plain"
# 原因：默认的AFNetworking库，不支持解析 text/plain 类型，需要增加 text/plain 类型。

platform:ios,'9.0'
source 'https://github.com/CocoaPods/Specs.git'
target 'Aocoin' do
    # js 与 原生交互
    pod 'WebViewJavascriptBridge', '~> 6.0.3'
    # 加载框
    pod 'MBProgressHUD', '~> 1.1.0'
    # 数据库
    pod 'Realm', '~> 3.14.1'
    # 下拉刷新，上拉加载
    pod 'MJRefresh'
    # 侧滑导航
    pod 'RTRootNavigationController'
end



