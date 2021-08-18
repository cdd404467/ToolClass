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

@interface Test1VC ()
@property (nonatomic, strong)NSMutableArray *mArr;
@end

@implementation Test1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSLog(@"------- %@",[NSString notRounding:0.80]);
    UIButton *b = [UIButton new];
    
    [b imagePositionAt:ButtonImageEdgeInsetsStyleTop space:9];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Test2VC *vc = Test2VC.alloc.init;
    vc.pArr = self.mArr;
    vc.clickB = ^{
        NSLog(@"----- %ld",self.mArr.count);
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test1 {
    TestView1 *view = [[TestView1 alloc] initWithFrame:CGRectMake(10, 200, 300, 500)];
    [self.view addSubview:view];
    
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
