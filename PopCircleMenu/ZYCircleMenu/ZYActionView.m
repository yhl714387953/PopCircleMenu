//
//  ZYActionView.m
//  PopCircleMenu
//
//  Created by Hailong Yu on 15/10/8.
//  Copyright © 2015年 zhongkeyun. All rights reserved.
//

#import "ZYActionView.h"

@implementation ZYActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside) {
        CGPoint tempPoint = [self convertPoint:point toView:self];//将屏幕上的点转换到自己本身上
        for (UIView* view in self.subviews) {//遍历subViews
            if (CGRectContainsPoint(view.frame, tempPoint)) {//如果这个self上的这个点包含在子视图的frame内，就认为可以响应这个点击事件, 执行下面的代码
                inside = [view pointInside:[self convertPoint:point toView:view] withEvent:event];
                break;
            }
        }
        
    }
    
    return inside;
}

@end
