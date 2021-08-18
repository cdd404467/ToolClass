//
//  Test2VC.m
//  ToolClass
//
//  Created by caidongdong on 2021/7/29.
//

#import "Test2VC.h"

@interface Test2VC ()

@end

@implementation Test2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"2";
    self.view.backgroundColor = UIColor.grayColor;
    // Do any additional setup after loading the view.
}

//- (NSMutableArray *)pArr {
//    if (!_pArr) {
//        _pArr = [NSMutableArray new];
//    }
//    return _pArr;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSMutableArray *arr = self.pArr.mutableCopy;
    
    if (self.clickB) {
        self.clickB();
    }
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
