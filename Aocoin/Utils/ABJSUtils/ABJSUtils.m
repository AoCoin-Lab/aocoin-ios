//
//  ABJSUtils.m
//  Aocoin
//  Created by 邢现庆 on 2020/9/10.
//  Copyright © 2020 Xing. All rights reserved.
//

#import "ABJSUtils.h"
#import "WKWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

static ABJSUtils *jsUtils = nil;

@interface ABJSUtils() <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * webView;

@property WKWebViewJavascriptBridge* bridge;

@end

@implementation ABJSUtils

+(ABJSUtils*)shareUtils{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsUtils = [[ABJSUtils alloc] init];
    });
    return jsUtils;
}

-(void)callMethedWithName:(NSString*)methedName data:(NSString* _Nullable)data responseBlock:(IdResponseBlock)responseBlock{
    [self.bridge callHandler:methedName data:data responseCallback:^(id responseData) {
        responseBlock(responseData);
    }];
}

+(NSString*)js_errorMsg:(id)error{
    if (error == nil) {
        return nil;
    }
    if ([[error class] isSubclassOfClass:[NSString class]]) {
        return error;
    }
    if ([[error class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *value = (NSDictionary*)error;
        if ([[value allKeys]containsObject:@"reason"]) {
            id reason = [value objectForKey:@"reason"];
            if ([[reason class] isSubclassOfClass:[NSString class]]) {
                return reason;
            }
            return nil;
        }
        if ([[value allKeys]containsObject:@"error"]) {
            id reason = [value objectForKey:@"error"];
            if ([[reason class] isSubclassOfClass:[NSString class]]) {
                return reason;
            }
            return nil;
        }
        return nil;
    }
    return nil;
}

-(NSString*)htmlFileName{
    return @"index";
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
#if defined (DEBUG)
    // 开启日志，方便调试
    [WKWebViewJavascriptBridge enableLogging];
#endif
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    // 设置代理，如果不需要实现，可以不设置
    [self.bridge setWebViewDelegate:self];
        
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:[self htmlFileName]
                                                          ofType:@"html"];
    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

- (WKWebView *)webView{
    if(_webView == nil){
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        [preference setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        config.preferences = preference;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 400, 800) configuration:config];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor redColor];
        [[UIApplication sharedApplication].keyWindow insertSubview:_webView atIndex:0];
    }
    return _webView;
}

#pragma mark -- WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
//    NSLog(@" 加载失败 ");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@" 加载成功 ");
}



@end
