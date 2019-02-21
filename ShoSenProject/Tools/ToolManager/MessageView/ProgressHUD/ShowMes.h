//
//  ShowMes.h
//  Smile
//
//  Created by wei on 2017/6/27.
//  Copyright © 2017年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowMes : NSObject
+ (void)show:(NSString*)mes;
+ (void)stop;
@end

@interface ShowMesView : UIView
@property (nonatomic,strong)UILabel*label;
- (void)settext:(NSString*)text;
@end


