//
//  Test1VC.m
//  ToolClass
//
//  Created by caidongdong on 2021/6/4.
//

#import "Test1VC.h"
#import "UIView+Effects.h"

@interface Test1VC ()

@end

@implementation Test1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView *view = UIImageView.alloc.init;
    view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(100);
    }];
    
    
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
