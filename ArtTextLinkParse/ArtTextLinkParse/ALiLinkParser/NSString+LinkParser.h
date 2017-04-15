//
//  NSString+LinkParser.h
//  ArtTextLinkParse
//
//  Created by LeeWong on 2017/4/15.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 这个分类主要是用于链接的正则匹配 默认去掉汉字
 
 */

@interface NSString (LinkParser)

- (NSAttributedString *)parser;

- (NSAttributedString *)parserTextWithFont:(UIFont *)aFont textColor:(UIColor *)aColor;


- (NSAttributedString *)parserTextWithFont:(UIFont *)aFont textColor:(UIColor *)aColor linkColor:(UIColor *)aLinkColor;

@end
