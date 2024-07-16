//
//  Test3VC.m
//  ToolClass
//
//  Created by zhuzi-cdd on 2023/11/21.
//

#import "Test3VC.h"
#import "Test2VC.h"

@interface Test3VC ()<MyDelegateProtocol>


@end

@implementation Test3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Test2";
    [[MulticastDelegate shared] addDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [MulticastDelegate.shared performDelegateMethod];
}


- (void)didReceiveEvent:(NSString *)event {
    NSLog(@"3333 -----  %@",event);
}

@end
