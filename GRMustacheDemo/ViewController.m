//
//  ViewController.m
//  GRMustacheDemo
//
//  Created by hkqx on 2018/2/6.
//  Copyright © 2018年 hkqx. All rights reserved.
//

#import "ViewController.h"
#import <Ono/Ono.h>
#import "GRMustache.h"
#import "OSCGitDetailModel.h"
#import "IMYWebView.h"
#define sdd @"<div class='course'><p><i class='iconfont icon-bofangqi-bofangxiaodianshi'></i>课程简介</p>           <div>课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍课程介绍</div>                          <img src='http://img.taopic.com/uploads/allimg/120727/201995-120HG1030762.jpg'></div>"
#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define Screenheight  ([UIScreen mainScreen].bounds.size.height)
static NSString * jsonTxt =  @"werwrwerwe";

@interface ViewController ()<IMYWebViewDelegate,UIWebViewDelegate>
{
    NSString *string ;
}
@property (nonatomic,strong) OSCGitDetailModel *detailModel;
@property (nonatomic,strong) IMYWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IMYWebView *webView = [[IMYWebView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 1) usingUIWebView:NO];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:webView];
    NSDictionary *dic = @{@"content":sdd};
    NSString * htmlstr = [self HTMLWithData:dic usingTemplate:@"qw"];
    
    [webView loadHTMLString: htmlstr baseURL: nil];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(IMYWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}

- (void)webViewDidFinishLoad:(IMYWebView *)webView{
    [webView evaluateJavaScript:@"setImageClickFunction" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(NSNumber* result, NSError *err) {
        CGFloat webViewHeight = [result floatValue];
        webView.frame = CGRectMake(10, 0 , ScreenWidth-20, webViewHeight);
    }];
}

- (void)webView:(IMYWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error.debugDescription);
}
- (NSString *)HTMLWithData:(NSDictionary *)data usingTemplate:(NSString *)templateName
{
    NSString * fileName = @"qw.html";
    
    //获取完整的html 文件路径  带后缀名
    
    NSString * path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent: fileName];
    
    //编码
    
    NSString * template = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: nil];
    
    NSDictionary * renderObject = data;
    
    NSString * content = [GRMustacheTemplate renderObject: renderObject fromString: template error: nil];

    return content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
