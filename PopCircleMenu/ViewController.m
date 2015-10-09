//
//  ViewController.m
//  PopCircleMenu
//
//  Created by Hailong Yu on 15/9/30.
//  Copyright © 2015年 zhongkeyun. All rights reserved.
//

#import "ViewController.h"
#import "ZYCircleMenu.h"

#import "PopCircleMenu-swift.h"

@interface ViewController ()
@property (nonatomic, strong) ZYCircleMenu* menu;
@property (nonatomic, strong) ZYCircleMenu* cmenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
//    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
//    [self.view addSubview:tableView];
    
    NSArray* imageNames = @[@"KYICircleMenuButton01", @"KYICircleMenuButton02", @"KYICircleMenuButton03", @"KYICircleMenuButton04"/*, @"KYICircleMenuButton05"*/];
    ZYCircleMenu* menu = [[ZYCircleMenu alloc] initWithFrame:CGRectMake(30, 30, 50, 50) imageNames: imageNames itemSize:CGSizeMake(40, 40) radius:100];
    menu.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0 - 100);
    self.menu = menu;
    menu.direction = ZYCircleMenuDirectionTopLeft;
    [self.view addSubview:menu];
    
    
    NSMutableArray* array = [NSMutableArray array];
    for (NSString* name in imageNames) {
        UIButton* iv = [UIButton buttonWithType:(UIButtonTypeSystem)];// initWithFrame:CGRectMake(0, 0, 40, 40)];
        iv.frame = CGRectMake(0, 0, 40, 40);
        iv.tag = [imageNames indexOfObject:name];
        [iv setBackgroundImage:[UIImage imageNamed:name] forState:(UIControlStateNormal)];
        [array addObject:iv];
        
        [iv addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    ZYCircleMenu* cmenu = [[ZYCircleMenu alloc] initWithFrame:CGRectMake(30, 380, 50, 50) customViews:array radius:100];
    self.cmenu = cmenu;
//    cmenu.position = ZYCircleMenuPositionBottomRight;
    cmenu.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self.view addSubview:cmenu];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
    [cmenu addGestureRecognizer:tap];
    


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tapMenu:(UITapGestureRecognizer*)tap{
    ZYCircleMenu* menu = (ZYCircleMenu*)tap.view;
    menu.isOpen = !menu.isOpen;
    
    
//    YYInfoLabel* label = [[YYInfoLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [label show:@"春春死米不搞基"];
}

-(void)clicked:(UIButton*)sender{
    NSLog(@"%ld", (long)sender.tag);
    
}

- (IBAction)segmentChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.menu.direction = ZYCircleMenuDirectionTopLeft;
            self.cmenu.direction = ZYCircleMenuDirectionTopLeft;
            break;
            
        case 1:
            self.menu.direction = ZYCircleMenuDirectionTopRight;
            self.cmenu.direction = ZYCircleMenuDirectionTopRight;
            break;
            
        case 2:
            self.menu.direction = ZYCircleMenuDirectionBottomLeft;
            self.cmenu.direction = ZYCircleMenuDirectionBottomLeft;
            break;
            
        case 3:
            self.menu.direction = ZYCircleMenuDirectionBottomRight;
            self.cmenu.direction = ZYCircleMenuDirectionBottomRight;
            break;

        default:
            break;
    }
    
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    
    YYInfoLabel* label = [[YYInfoLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [label show:@"这个是嘴爷设计的啊"];
    
}


@end
