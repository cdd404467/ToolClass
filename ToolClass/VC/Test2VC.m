//
//  Test2VC.m
//  ToolClass
//
//  Created by caidongdong on 2021/7/29.
//

#import "Test2VC.h"

#import "Test3VC.h"

@interface Test2VC ()<MyDelegateProtocol>

@end

@implementation Test2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test2";
    self.view.backgroundColor = UIColor.grayColor;
    UIButton *btn = [UIButton buttonWithType:0];
    btn.backgroundColor = UIColor.blackColor;
    btn.frame = CGRectMake(100, 200, 44, 44);
    [btn addTarget:self action:@selector(clickDe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [[MulticastDelegate shared] addDelegate:self];
 
}

- (void)didReceiveEvent:(NSString *)event {
    NSLog(@"2222 -----  %@",event);
}

- (void)clickDe {
    [MulticastDelegate.shared performDelegateMethod];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSMutableArray *arr = self.pArr.mutableCopy;
    
//    if (self.clickB) {
//        self.clickB();
//    }
    Test3VC *vc = [Test3VC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
