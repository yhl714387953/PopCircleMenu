//
//  BaseView.swift
//  PopCircleMenu
//
//  Created by Hailong Yu on 15/10/9.
//  Copyright © 2015年 zhongkeyun. All rights reserved.
//

import UIKit

class BaseView: NSObject {

}

/*！
@brief 模仿YY的提示框
*/
class YYInfoLabel: UILabel {
    
    var timer: NSTimer?
    let screenSize = UIScreen.mainScreen().bounds.size
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.textAlignment = NSTextAlignment.Center
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(14)
        
        //        定义label的最大宽度
        
        self.frame = CGRect(x: 20, y: screenSize.height, width: screenSize.width - 2 * 20, height: 20)
        
        //        设置阴影
        self.layer.shadowOffset = CGSizeMake(0, 3);  // 设置阴影的偏移量
        self.layer.shadowRadius = 3.0;  // 设置阴影的半径
        self.layer.shadowColor = UIColor.blackColor().CGColor; // 设置阴影的颜色为黑色
        self.layer.shadowOpacity = 0.7; // 设置阴影的不透明度
        
        //设置圆角
        self.layer.cornerRadius = 6
//        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(text: String){
        //        定义一下label的大小
        self.text = text
        self.sizeToFit()
        self.frame = CGRect(x: 0, y:screenSize.height - self.frame.size.height - 50 , width: self.frame.size.width + 20, height: self.frame.size.height + 20)
        self.center = CGPoint(x: screenSize.width / 2.0, y: self.center.y)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(self)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) / 20.0, target: self, selector: "timerBegin", userInfo: nil, repeats: false)
    }
    
    func timerBegin(){
        self.timerEnd()
    }
    
    func timerEnd(){
        self.timer?.invalidate()
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.alpha = 0
            }) { (isFinish: Bool) -> Void in
                self.removeFromSuperview()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        
    }
    
}
