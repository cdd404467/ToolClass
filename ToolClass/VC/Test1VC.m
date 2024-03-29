//
//  Test1VC.m
//  ToolClass
//
//  Created by caidongdong on 2021/6/4.
//

#import "Test1VC.h"
#import "UIView+Effects.h"
#import "TestView1.h"
#import "PaddingLabelOC.h"
#import "Test2VC.h"
#import "TBarVC.h"
#import "MulticastDelegate.h"

@interface Test1VC ()<MyDelegateProtocol>
@property (nonatomic, strong)NSMutableArray *mArr;
@property (nonatomic, strong) MulticastDelegate *delegateObject;
@end

@implementation Test1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1111";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.delegateObject = [[MulticastDelegate alloc] init];
        
    // 将当前视图控制器设置为委托对象
    [self.delegateObject addDelegate:self];
    
    
    [self test11];
//    NSLog(@"------- %@",[NSString notRounding:0.80]);
}


- (void)didReceiveEvent:(NSString *)event {
    NSLog(@"2222 -----  %@",event);
}


- (void)test11 {
    
    
    
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCarBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [shoppingCarBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [shoppingCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [shoppingCarBtn setImage:[UIImage imageNamed:@"icon_test2"] forState:UIControlStateNormal];
    [self.view addSubview:shoppingCarBtn];
    shoppingCarBtn.frame = CGRectMake(100, 200, 44, 44);
//    [shoppingCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(rightView);
//        make.right.mas_equalTo(-15);
//        make.width.mas_equalTo(44);
//        make.height.mas_equalTo(44);
//    }];
    shoppingCarBtn.titleLabel.backgroundColor = UIColor.whiteColor;
    shoppingCarBtn.imageView.backgroundColor = UIColor.blueColor;
    [shoppingCarBtn imagePositionAt:ButtonImageEdgeInsetsStyleTop space:1];
//    [shoppingCarBtn layoutWithEdgeInsetsStyle:ButtonEdgeInsetsStyleTop imageTitleSpace:1];
    shoppingCarBtn.backgroundColor = UIColor.redColor;
    [shoppingCarBtn addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    shoppingCarBtn.touchEdgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    Test2VC *vc = Test2VC.alloc.init;
//    vc.pArr = self.mArr;
//    vc.clickB = ^{
//        NSLog(@"----- %ld",self.mArr.count);
//    };
//    [self.navigationController pushViewController:vc animated:YES];
//    TBarVC *vc = TBarVC.alloc.init;
//    vc.name = @"ddd";
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test1 {
    TestView1 *view = [[TestView1 alloc] initWithFrame:CGRectMake(10, 200, 300, 500)];
    [self.view addSubview:view];
    
}

- (void)clickTest {
    NSLog(@"qwer ---- cdd click");
    [self visitPhoto];
    
}

- (void)visitPhoto {
    Test2VC *vc = [Test2VC new];
    [vc.delegateObject addDelegate:self];
    vc.delegateObject = self.delegateObject;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)test {
    UIColor *color = [UIColor redColor];
        [color set]; //设置线条颜色
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 100)];
//        [path addLineToPoint:CGPointMake(150, 50)];
//        [path addLineToPoint:CGPointMake(250, 100)];
//        [path addLineToPoint:CGPointMake(250, 200)];
//        [path addLineToPoint:CGPointMake(100, 200)];
    
    
    [path addQuadCurveToPoint:CGPointMake(250, 100) controlPoint:CGPointMake(150, 20)];
//    [path addQuadCurveToPoint:CGPointMake(50, 100) controlPoint:CGPointMake(150, 180)];
    [path closePath]; // 最后一根线条,可以直接调此方法
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    [path stroke];
    
    [path removeAllPoints];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 300, 300, 500);
    [layer setPath:path.CGPath];
    layer.lineWidth = 5;
    layer.strokeColor = UIColor.lightGrayColor.CGColor;
    layer.fillColor = [UIColor yellowColor].CGColor;

    [self.view.layer addSublayer:layer];

}


@end
