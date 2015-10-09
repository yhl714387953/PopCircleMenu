//
//  ZYCircleMenu.h
//  PopCircleMenu
//
//  Created by Hailong Yu on 15/9/30.
//  Copyright © 2015年 zhongkeyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYActionView.h"

//回掉
typedef void(^ZYCircleMenuBlock)(NSInteger);

//位置
typedef enum {
    ZYCircleMenuDirectionTopLeft = 0,
    ZYCircleMenuDirectionTopRight,
    ZYCircleMenuDirectionBottomLeft,
    ZYCircleMenuDirectionBottomRight
    
}ZYCircleMenuDirection;

@class ZYCircleMenu;
@protocol ZYCircleMenuDelegate <NSObject>

-(void)zyCircleMenuButtonClickedAtIndex:(NSInteger)buttonIndex;

@end

/*!
 @brief 圆形菜单
 */
@interface ZYCircleMenu : ZYActionView
{
    CGPoint _currentDirection;//所有控件的位置
}
@property (nonatomic, weak)id<ZYCircleMenuDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString*> *imageNames;
@property (nonatomic, strong) NSMutableArray<UIView*> *items;

/*!
 @brief 事件回调，同协议
 */
@property (nonatomic, copy) ZYCircleMenuBlock block;

/*!
 @brief 中间的按钮
 */
@property (nonatomic, strong) UIButton* middleItem;

/*!
 @brief 图标的大小
 */
@property (nonatomic) CGSize itemSize;

/*!
 @brief 展开的半径
 */
@property (nonatomic) CGFloat radius;

/*!
 @brief 是否展开
 */
@property (nonatomic) BOOL isOpen;

/*!
 @brief 位置
 */
@property (nonatomic) ZYCircleMenuDirection direction;

/**
 *	@brief	<#Description#>
 *
 *	@param 	frame 	<#frame description#>
 *	@param 	imageNames 	<#imageNames description#>
 *	@param 	itemSize 	<#itemSize description#>
 *	@param 	radius 	<#radius description#>
 *
 *	@return	<#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray<NSString*> *)imageNames itemSize:(CGSize)itemSize radius:(CGFloat)radius
;

/**
 *	@brief	<#Description#>
 *
 *	@param 	frame 	<#frame description#>
 *	@param 	customViews 	<#customViews description#>
 *	@param 	radius 	<#radius description#>
 *
 *	@return	<#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame customViews:(NSArray<UIView*> *)customViews radius:(CGFloat)radius
;

@end
