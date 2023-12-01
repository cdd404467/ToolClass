//
//  Test3VC.m
//  ToolClass
//
//  Created by zhuzi-cdd on 2023/11/21.
//

#import "Test3VC.h"


@interface Test3VC ()<MyDelegateProtocol>


@end

@implementation Test3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = [[MulticastDelegate alloc] init];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.delegate performDelegateMethod];
}




@end
