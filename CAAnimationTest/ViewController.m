//
//  ViewController.m
//  CAAnimationTest
//
//  Created by lunarboat on 15/10/15.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    CALayer *_layer;
    BOOL _isTransactionRunning;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"这是创建的新分支");
    //    CALayer 来自于QuartzCore.framework，主要用来中CoreAnimation核心动画，用法和UIView相似
    //添加到一个用来做动画的图层
    _layer = [CALayer layer];
    [self.view.layer addSublayer:_layer];
    _layer.frame = CGRectMake(110, 200, 80, 80);
    _layer.backgroundColor = [[UIColor redColor]CGColor];
    _layer.borderColor = [[UIColor greenColor]CGColor];
    _layer.borderWidth = 3;
    _layer.shadowColor = [[UIColor yellowColor]CGColor];
    _layer.shadowOffset = CGSizeZero;
    _layer.shadowRadius = 15;
    _layer.cornerRadius = 10;
    _layer.anchorPoint = CGPointZero;
    _layer.shadowOpacity = 0.9;
    
    NSDate *date = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:22222222];
    
    double timeZoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([date timeIntervalSince1970] + timeZoneFix)/(24*3600)) -
        (int)(([date2 timeIntervalSince1970] + timeZoneFix)/(24*3600))
        == 0
        ) {
        NSLog(@"1");
        
    }
    
    CGFloat perWidth = 320.0 / 4;
    NSArray *aniTypes = @[@"事物", @"CA基本（属性）动画", @"关键帧动画", @"过渡的动画"];
    for (int i = 0; i < aniTypes.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:aniTypes[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(perWidth * i, 80, perWidth, 44);
        [self.view addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor greenColor]];
        button.tag = 100 + i;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(100, 100, 100, 100);
    layer1.backgroundColor = [[UIColor redColor]CGColor];
    layer1.cornerRadius = layer1.frame.size.width / 2;
    [self.view.layer addSublayer:layer1];
    layer1.shadowColor = [[UIColor greenColor]CGColor];
    layer1.shadowOffset = CGSizeMake(100, 10);
    layer1.shadowOpacity = 0.8f;
    
    
    CGSize size = CGSizeMake(200, 200);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    float radius = 50.0f;
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, NULL, size.width - radius, size.height);
    CGPathAddArc(mutablePath, NULL, size.width - radius, size.height - radius, radius, M_PI_2, 0.0, YES);
    CGPathAddLineToPoint(mutablePath, NULL, size.width, 0.0);
    CGPathAddLineToPoint(mutablePath, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(mutablePath, NULL, .0, size.height - radius);
    CGPathAddArc(mutablePath, NULL, radius, size.height - radius, radius, M_PI, M_PI_2, YES);
    CGPathCloseSubpath(mutablePath);
    [shapeLayer setPath:mutablePath];
    CFRelease(mutablePath);
    self.view.layer.mask = shapeLayer;
    
    [self.view.layer addSublayer:shapeLayer];
    
//    CGPathAddRect(mutablePath, &CGAffineTransformIdentity, CGRectMake(0 , 0, 10, 10));
//    
//    layer1.shadowPath = mutablePath;
    //阴影扩散的半径
    layer1.shadowRadius = 10;
    //添加蒙板 剪切layer层外的东西，阴影也无效了
    layer1.masksToBounds = YES;
    //手动释放
    CGPathRelease(mutablePath);
    //图层的不透明度
    layer1.opacity = 0.6f;
    //位置的属性
    NSLog(@"%@", NSStringFromCGPoint(layer1.position));
    layer1.position = CGPointMake(160, 80);
    NSLog(@"%@", [NSValue valueWithCGPoint:layer1.position]);
    //边框属性
    layer1.borderColor = [[UIColor yellowColor]CGColor];
    layer1.borderWidth = 5.0f;
    
    //内容属性
    layer1.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"路径 2"]CGImage]);
    
        //文字涂层
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame  = CGRectMake(0, 200, self.view.bounds.size.width, 200);
    textLayer.backgroundColor = [[UIColor purpleColor]CGColor];
    textLayer.string = @"Swift 编程指南Swift 编程指南Swift 编程指南Swift 编程指南Swift 编程指南Swift 编程指南";
    textLayer.foregroundColor = [[UIColor cyanColor]CGColor];
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.fontSize = 20;
    //设置换行
    textLayer.wrapped = YES;
    textLayer.font = CGFontCreateWithFontName((CFStringRef)@"Zapfino");
    
    [self.view.layer addSublayer:textLayer];
    
    //渐变涂层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.frame = self.view.layer.bounds;
    gradientLayer.backgroundColor = [[UIColor redColor]CGColor];
    gradientLayer.opacity = 0.5f;
    gradientLayer.colors = @[(id)[UIColor orangeColor].CGColor,
                            (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor blueColor].CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 1);
    //设置渐变色的区域位置
    gradientLayer.locations = @[@0, @.6, @1];
    [self.view.layer insertSublayer:gradientLayer below:layer1];
    
    
    
}

- (void)buttonClick:(UIButton *)sender{
    switch (sender.tag - 100) {
        case 0:
            NSLog(@"0");
            if (_isTransactionRunning) {
                _isTransactionRunning = NO;
            }else{
                _isTransactionRunning = YES;
                [self doTransaction];
            }
            
            
            break;
        case 1:
            NSLog(@"1");
            [self doBasicAnimation];
            break;
        case 2:
            NSLog(@"2");
            [self doKeyFrameAnimation];
            break;
        case 3:
            NSLog(@"3");
            [self doTransitionAnimation];
            break;
        default:
            
            break;
    }
}

//基本核心动画
- (void)doBasicAnimation{
    CABasicAnimation *borderAnimation = [CABasicAnimation animation];
    //kvc方式，制定动画要操作的属性
    borderAnimation.duration = 0.5;
    //自动逆转
    borderAnimation.autoreverses = NO;
    //重复次数
    borderAnimation.repeatCount = 5;
    [borderAnimation setKeyPath:@"borderColor"];
    borderAnimation.toValue = (id)[[UIColor redColor]CGColor];
    //可以根据key来管理移除已经添加的动画
//    [_layer addAnimation:borderAnimation forKey:@"layer_border_color_animation"];
    
    CABasicAnimation *zRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    zRotation.duration = 3.0f;
//    zRotation.fromValue = @(0);
//    zRotation.toValue = @(M_PI);
    zRotation.byValue = @(M_PI/4);
    //把动画从layer上移除
//    zRotation.removedOnCompletion = NO;
    zRotation.autoreverses = YES;
//    zRotation.fillMode = kCAFillModeBoth;
//    [_layer addAnimation:zRotation forKey:@"layer_rotation_z_animation"];
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAnimation.duration = 3.0f;
    scaleAnimation.autoreverses = YES;
//    scaleAnimation.removedOnCompletion = NO;
    //动画填充模式
    
//    scaleAnimation.fillMode = kCAFillModeBoth;
    scaleAnimation.toValue = @(0.5);
//    [_layer addAnimation:scaleAnimation forKey:@"layer_scale_animation"];
    
    //动画组，可以把一些动画组合，起来，同时添加进行控制，
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[borderAnimation, zRotation, scaleAnimation];
    animationGroup.duration = 3;
    [_layer addAnimation:animationGroup forKey:@"animations_group"];
    
}

//关键帧动画
- (void)doKeyFrameAnimation{
    //根据关键点来移动layer
    CAKeyframeAnimation *moveKFAni = [CAKeyframeAnimation animation];
    moveKFAni.keyPath = @"position";
    moveKFAni.duration = 3.0f;
    CGPoint pos = _layer.position;
    moveKFAni.values = @[[NSValue valueWithCGPoint:pos],
                         [NSValue valueWithCGPoint:CGPointMake(0, 400)],
                         [NSValue valueWithCGPoint:CGPointMake(320, 400)],
                         [NSValue valueWithCGPoint:pos]];
    //走的进度，百分数，完全走完是1
    moveKFAni.keyTimes = @[@0.0f, @0.8f, @0.9f, @1.0f];
    [_layer addAnimation:moveKFAni forKey:@"key_frame_move_animation"];
}

//过渡动画，动画和UIViewController的push的效果一样
- (void)doTransitionAnimation{
    CATransition *tranAni = [CATransition animation];
    tranAni.duration = 1.0f;
//    `fade', `moveIn', `push' and `reveal'. Defaults to `fade'.
    tranAni.type = kCATransitionFade;
    tranAni.subtype = kCATransition;
    tranAni.type = @"suckEffect";
    [_layer addAnimation:tranAni forKey:@"transition_animation"];
}

//用核心动画中的事物来对layer进行操作 隐式
- (void)doTransaction{
//    CATransaction
    //直接赋值就可以隐式调用事物动画
//    _layer.shadowOpacity = 0.1f;
    
    //显示调用
    //一般写代码都把长队的begin 和 commit都写出来
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    
//    self.view.layer.backgroundColor = [[UIColor redColor]CGColor];
    _layer.backgroundColor = [[UIColor blueColor]CGColor];
    
    
    [CATransaction setCompletionBlock:^{
        //递归
        
        if (_isTransactionRunning) {
            [self doTransaction];
        }
    }];
    if (_layer.shadowOpacity >= 0.9f) {
        _layer.shadowOpacity = 0.1;
    }else{
        _layer.shadowOpacity = 0.9;
    }
    
    [CATransaction commit];
    //写在外面隐式调用
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// Do any additional setup after loading the view, typically from a nib.
////// Color Declarations
//UIColor* color1 = [UIColor colorWithRed: 0.391 green: 0.379 blue: 0.379 alpha: 1];
//
////// Group 页1
//
////// Bezier Drawing
//CAShapeLayer *layerShape = [CAShapeLayer layer];
//
//UIBezierPath* bezierPath = UIBezierPath.bezierPath;
//[bezierPath moveToPoint: CGPointMake(166.67, 363.28)];
//[bezierPath addCurveToPoint: CGPointMake(275.93, 363.28) controlPoint1: CGPointMake(200.85, 371.38) controlPoint2: CGPointMake(242.8, 373.85)];
//[bezierPath addCurveToPoint: CGPointMake(322.12, 341.22) controlPoint1: CGPointMake(286.26, 359.98) controlPoint2: CGPointMake(304.12, 347.42)];
//[bezierPath addCurveToPoint: CGPointMake(359.78, 336.12) controlPoint1: CGPointMake(338.63, 335.53) controlPoint2: CGPointMake(355.6, 336.02)];
//[bezierPath addCurveToPoint: CGPointMake(408.23, 373.28) controlPoint1: CGPointMake(389.82, 336.84) controlPoint2: CGPointMake(408.23, 373.28)];
//[bezierPath addCurveToPoint: CGPointMake(408.23, 318.83) controlPoint1: CGPointMake(408.23, 373.28) controlPoint2: CGPointMake(417.1, 352.14)];
//[bezierPath addCurveToPoint: CGPointMake(379.75, 262.33) controlPoint1: CGPointMake(399.37, 285.53) controlPoint2: CGPointMake(379.75, 262.33)];
//[bezierPath addCurveToPoint: CGPointMake(359.78, 112.21) controlPoint1: CGPointMake(379.75, 262.33) controlPoint2: CGPointMake(398.97, 194.57)];
//[bezierPath addCurveToPoint: CGPointMake(252.05, 1.39) controlPoint1: CGPointMake(320.58, 29.85) controlPoint2: CGPointMake(252.05, 1.39)];
//[bezierPath addCurveToPoint: CGPointMake(298.45, 102.75) controlPoint1: CGPointMake(252.05, 1.39) controlPoint2: CGPointMake(287.7, 36.64)];
//[bezierPath addCurveToPoint: CGPointMake(289.29, 198.25) controlPoint1: CGPointMake(309.2, 168.86) controlPoint2: CGPointMake(289.29, 198.25)];
//[bezierPath addCurveToPoint: CGPointMake(185.74, 121.98) controlPoint1: CGPointMake(289.29, 198.25) controlPoint2: CGPointMake(218.85, 148.28)];
//[bezierPath addCurveToPoint: CGPointMake(87.68, 35.51) controlPoint1: CGPointMake(152.09, 95.26) controlPoint2: CGPointMake(87.68, 35.51)];
//[bezierPath addCurveToPoint: CGPointMake(144.77, 112.21) controlPoint1: CGPointMake(87.68, 35.51) controlPoint2: CGPointMake(124.68, 86.91)];
//[bezierPath addCurveToPoint: CGPointMake(199.28, 175.89) controlPoint1: CGPointMake(162.08, 134.02) controlPoint2: CGPointMake(199.28, 175.89)];
//[bezierPath addCurveToPoint: CGPointMake(121.86, 121.98) controlPoint1: CGPointMake(199.28, 175.89) controlPoint2: CGPointMake(182.79, 168.25)];
//[bezierPath addCurveToPoint: CGPointMake(36.9, 54.61) controlPoint1: CGPointMake(60.93, 75.72) controlPoint2: CGPointMake(36.9, 54.61)];
//[bezierPath addCurveToPoint: CGPointMake(121.86, 161.88) controlPoint1: CGPointMake(36.9, 54.61) controlPoint2: CGPointMake(84.27, 119.57)];
//[bezierPath addCurveToPoint: CGPointMake(229.77, 264.65) controlPoint1: CGPointMake(159.46, 204.18) controlPoint2: CGPointMake(229.77, 264.65)];
//[bezierPath addCurveToPoint: CGPointMake(121.86, 288.5) controlPoint1: CGPointMake(229.77, 264.65) controlPoint2: CGPointMake(185.74, 295.32)];
//[bezierPath addCurveToPoint: CGPointMake(1.36, 239.71) controlPoint1: CGPointMake(57.99, 281.68) controlPoint2: CGPointMake(1.36, 239.71)];
//[bezierPath addCurveToPoint: CGPointMake(166.67, 363.28) controlPoint1: CGPointMake(1.36, 239.71) controlPoint2: CGPointMake(55.3, 336.88)];
//[bezierPath closePath];
//bezierPath.miterLimit = 4;
//
//bezierPath.usesEvenOddFillRule = YES;
//[color1 setStroke];
//bezierPath.lineWidth = 1;
//[bezierPath stroke];
//layerShape.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100);
//layerShape.path = bezierPath.CGPath;
//layerShape.fillColor = [[UIColor clearColor]CGColor];
//layerShape.strokeColor =[[UIColor redColor]CGColor];
//[self.view.layer addSublayer:layerShape];

@end
