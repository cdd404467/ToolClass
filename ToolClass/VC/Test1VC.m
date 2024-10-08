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
@property (nonatomic, strong)UIButton *openIcon;
@end

@implementation Test1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test1";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [[MulticastDelegate shared] addDelegate:self];
    
   
//    [openIcon addTarget:self action:@selector(tapOpenAction) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@",self.view.cs_id);
    self.view.cs_id = @"111";
    NSLog(@"%@",self.view.cs_id);
    [self test11];
}




- (void)didReceiveEvent:(NSString *)event {
    NSLog(@"1111 -----  %@",event);
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


- (void)startRotateButton {
//    self.openIcon.enabled = NO;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = 10000000;
    rotationAnimation.removedOnCompletion = YES;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.openIcon.layer addAnimation:rotationAnimation forKey:@"rotationAnimationY"];
    
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
    [self startRotateButton];
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
