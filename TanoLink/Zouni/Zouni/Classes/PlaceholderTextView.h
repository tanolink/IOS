//
//  PlaceholderTextView.h
//  JuranClient
//
//  Created by huchu on 14-10-15.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PlaceholderTextView : UITextView
{
    UIColor *_contentColor;
    BOOL _editing;
}

@property(strong, nonatomic) NSString *placeholder;
@property(strong, nonatomic) UIColor *placeholderColor;

@end
