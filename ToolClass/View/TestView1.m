//
//  TestView1.m
//  ToolClass
//
//  Created by caidongdong on 2021/6/27.
//

#import "TestView1.h"

@implementation TestView1

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    [path addLineToPoint:CGPointMake(250, 100)];
    [path addLineToPoint:CGPointMake(250, 200)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path closePath]; // 最后一根线条,可以直接调此方法
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //终点处理
    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
  [path stroke];  //不填充
  // [path fill];  //填充
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setPath:path.CGPath];
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
}
@end
