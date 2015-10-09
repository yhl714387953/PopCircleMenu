//
//  ZYCircleMenu.m
//  PopCircleMenu
//
//  Created by Hailong Yu on 15/9/30.
//  Copyright © 2015年 zhongkeyun. All rights reserved.
//

#import "ZYCircleMenu.h"

@implementation ZYCircleMenu

-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames itemSize:(CGSize)itemSize radius:(CGFloat)radius{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNames = imageNames;
        self.itemSize = itemSize;
        self.radius = radius;
        self.direction = ZYCircleMenuDirectionTopLeft;
        self.items = [NSMutableArray array];
        
        [self initItems];
        
        self.isOpen = NO;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame customViews:(NSArray<UIView*> *)customViews radius:(CGFloat)radius{
    self = [super initWithFrame:frame];
    if (self) {
        self.radius = radius;
        self.direction = ZYCircleMenuDirectionTopLeft;
        self.items = [NSMutableArray arrayWithArray:customViews];
        
        for (UIView* view in customViews)
            [self addSubview:view];

        self.isOpen = NO;
    }
    
    return self;
}

-(void)initItems{
  
//    中间按钮
    UIButton* middleButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    middleButton.frame = self.bounds;
    [middleButton setBackgroundImage:[UIImage imageNamed:@"KYICircleMenuCenterButtonBackground"] forState:(UIControlStateNormal)];
    [middleButton setTintColor:[UIColor purpleColor]];
    middleButton.tag = 0;
    [self addSubview:middleButton];
    self.middleItem = middleButton;
    [middleButton addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    

//    周围按钮
    for (int i = 0; i < self.imageNames.count; i++) {
        NSString* name = self.imageNames[i];
        UIButton* button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:(UIControlStateNormal)];
        button.frame = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
        
        button.center = self.middleItem.center;
        
        button.tag = i + 1;
        button.alpha = 0;
        button.hidden = YES;
        
        [self addSubview:button];
        [self.items addObject:button];

        [button addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    [self bringSubviewToFront:self.middleItem];
}

-(void)clicked:(UIButton*)sender{
    NSLog(@"%ld", (long)sender.tag);
    
    self.isOpen = !self.isOpen;

    ZYCircleMenuBlock blcok = self.block;
    if (blcok) {
        blcok(sender.tag);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyCircleMenuButtonClickedAtIndex:)]) {
        [self.delegate zyCircleMenuButtonClickedAtIndex:sender.tag];
    }
    
    
}

#pragma mark -
#pragma mark - setter
-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    
    if (_isOpen) {
        CGFloat angle = self.items.count > 1 ? M_PI_2 / (self.items.count - 1) : M_PI;
        for (int i = 0; i < self.items.count; i++) {
            UIView* view = self.items[i];
            view.hidden = NO;
            view.alpha = 1;
            [UIView animateWithDuration:0.25 animations:^{
                view.center = CGPointMake(self.frame.size.width / 2.0 + (self.radius + 15) * cosf(angle * i) * _currentDirection.x, self.frame.size.height / 2.0 + (self.radius + 15) * sinf(angle * i) * _currentDirection.y);

            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.center = CGPointMake(self.frame.size.width / 2.0 + self.radius * cosf(angle * i) * _currentDirection.x, self.frame.size.height / 2.0 + self.radius * sinf(angle * i) * _currentDirection.y);
                }];
                
            }];
            
        }
    }else{
        for (UIView* view in self.items) {
            [UIView animateWithDuration:0.25 animations:^{
                view.alpha = 0;
                view.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
            } completion:^(BOOL finished) {
                view.hidden = YES;
            }];
        }
        
    }
    
}

-(void)setDirection:(ZYCircleMenuDirection)direction{
    _direction = direction;

    NSInteger xDirection = 1;
    NSInteger yDirection = 1;
    switch (direction) {
        case ZYCircleMenuDirectionTopLeft:
            xDirection = -1;
            yDirection = -1;
            
            break;
        case ZYCircleMenuDirectionTopRight:
            xDirection = 1;
            yDirection = -1;
            
            break;
        case ZYCircleMenuDirectionBottomLeft:
            xDirection = -1;
            yDirection = 1;
            
            break;
        case ZYCircleMenuDirectionBottomRight:
            xDirection = 1;
            yDirection = 1;
            
            break;
            
        default:
            break;
    }
    
    _currentDirection = CGPointMake(xDirection, yDirection);
 
}

/*
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
*/



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
