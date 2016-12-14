//
//  OwnerViewController.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "WebViewController.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,strong) NJKWebViewProgress *progress;
@property(nonatomic,strong) NJKWebViewProgressView *progressView;

@property(nonatomic,strong) JSContext *jsContext;

@end

@implementation WebViewController

-(void)setBasePath:(NSString *)basePath {
    _basePath = basePath;
    [self loadWithUrl:_basePath];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

-(void)initializeComponent {
    [self defaultViewStyle];
    
    _progress = [[NJKWebViewProgress alloc] init];
    _progress.progressDelegate = self;
    _progress.webViewProxyDelegate = self;
    
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(-1,navBounds.size.height - 3,navBounds.size.width,3);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.backgroundColor = ThemeColor;
    _progressView.progressBarView.layer.masksToBounds = YES;
    _progressView.progressBarView.layer.cornerRadius = 1.5;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0 animated:YES];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    _webView = [[UIWebView alloc] init];
    _webView.delegate = _progress;
    _webView.backgroundColor = ThemeBackgroundColor;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    if(!_basePath) {
        _progressView.hidden = YES;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]]];
        [_webView loadRequest:request];
    } else {
        [self loadWithUrl:_basePath];
    }
}

/**
 *  加载网页
 */
-(void)loadWithUrl:(NSString*)urlString {
    if(urlString && _webView) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [_webView loadRequest:request];
    }
}

#pragma -mark progress delegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:NO];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    [_webView stringByEvaluatingJavaScriptFromString:[WebViewController javaScript]];
    
    [self initJSContext];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"WebViewController:%@",error);
}

#pragma -mark JavaScript

/**
 *  JavaScript
 */
+(NSString*)javaScript {
    NSString *javaScript = @"document.documentElement.style.webkitUserSelect='none';\
    document.documentElement.style.webkitTouchCallout='none';\
    ";
    return javaScript;
}

/**
 *  初始化JSContext
 */
-(void)initJSContext {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"WebViewController:%@", expectValue);
    }];
    _jsContext = context;
    [self addMethodToJSContext];
}

/**
 *  向JSContext中添加方法
 */
-(void)addMethodToJSContext {
    if(!_jsContext) {
        return;
    }
    
    _jsContext[@"loadPage"] = [self jsFunctionLoadPage];
}

//type 0:本页面 1:push效果 2:present效果
//function loadPage(url,type){}
-(void(^)(void))jsFunctionLoadPage {
    __weak typeof(self) weakSelf = self;
    void(^block)(void) = ^() {
        NSArray *parameters = [JSContext currentArguments];
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(parameters && parameters.count == 2) {
                NSString *urlString = [parameters[0] toString];
                NSInteger type = [parameters[1] toInt32];
                switch (type) {
                    case 0: {
                        strongSelf.basePath = urlString;
                    }
                        break;
                    case 1: {
                        WebViewController *wbController = [[WebViewController alloc] init];
                        wbController.basePath = urlString;
                        [strongSelf.navigationController pushViewController:wbController animated:YES];
                    }
                        break;
                    case 2: {
                        WebViewController *wbController = [[WebViewController alloc] init];
                        wbController.basePath = urlString;
                        [strongSelf presentViewController:wbController animated:YES completion:nil];
                    }
                    default: {
                        [strongSelf alertMessage:@"错误的类型"];
                    }
                        break;
                }
                
            } else {
                [strongSelf alertMessage:@"参数错误"];
            }
        });
    };
    
    return block;
}

/**
 *  消息提示
 */
-(void)alertMessage:(NSString*)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)dealloc {
    [_webView removeFromSuperview];
    [_progressView removeFromSuperview];
    _webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
