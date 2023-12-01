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
    self.title = @"2";
    self.view.backgroundColor = UIColor.grayColor;
    self.delegateObject = [[MulticastDelegate alloc] init];
        
    // 将当前视图控制器设置为委托对象
    
 
}

- (void)didReceiveEvent:(NSString *)event {
    NSLog(@"2222 -----  %@",event);
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSMutableArray *arr = self.pArr.mutableCopy;
    
//    if (self.clickB) {
//        self.clickB();
//    }
    Test3VC *vc = [Test3VC new];
    [vc.delegate addDelegate:self];
    vc.delegate = self.delegateObject;
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
