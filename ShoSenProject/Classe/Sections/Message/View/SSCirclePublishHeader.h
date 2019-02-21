//
//  SSCirclePublishHeader.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSCirclePublishHeaderBlock)(NSString *contentStr);

@interface SSCirclePublishHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UITextView *content_textview;

@property (nonatomic, copy) SSCirclePublishHeaderBlock  block;

@end
