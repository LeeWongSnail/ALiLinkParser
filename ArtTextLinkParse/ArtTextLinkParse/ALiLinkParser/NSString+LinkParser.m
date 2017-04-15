//
//  NSString+LinkParser.m
//  ArtTextLinkParse
//
//  Created by LeeWong on 2017/4/15.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

#import "NSString+LinkParser.h"

#define kDefaultFont  [UIFont systemFontOfSize:15]
#define kDefaultColor [UIColor blackColor]
#define kDefaultLinkColor  [UIColor blueColor]

@implementation NSString (LinkParser)

- (NSAttributedString *)parser
{
    return [self parserTextWithFont:kDefaultFont textColor:kDefaultColor];
}

- (NSAttributedString *)parserTextWithFont:(UIFont *)aFont textColor:(UIColor *)aColor
{
    return [self parserTextWithFont:aFont textColor:aColor linkColor:kDefaultLinkColor];
}


- (NSAttributedString *)parserTextWithFont:(UIFont *)aFont textColor:(UIColor *)aColor linkColor:(UIColor *)aLinkColor
{
    NSError *error;
    //先去掉汉字
    NSString *regexStr = @"[^\u4e00-\u9fa5]+";
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    
    //matches 中都是非汉字的部分
    NSArray *matches = [regex1 matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self];
    [text addAttribute:NSFontAttributeName value:aFont range:NSMakeRange(0, text.length)];
    [text addAttribute:NSForegroundColorAttributeName value:aColor range:NSMakeRange(0, text.length)];
    
    //针对非汉字部分做匹配
    for (NSTextCheckingResult *match in matches)
    {
        NSString *matchText1 = [text attributedSubstringFromRange:match.range].string;
        //链接的正则匹配表达式
        NSString *regulaStr = @"((ftp|https?)://[-\\w]+(\\.\\w[-\\w]*)+|(?i:[a-z0-9](?:[-a-z0-9]*[a-z0-9])?\\.)+(?-i:com\\b|edu\\b|biz\\b|gov\\b|in(?:t|fo)\\b|mil\\b|net\\b|org\\b|[a-z][a-z]\\b))(:\\d+)?(/[^.!,?;\"\'<>()\\[\\]{}\\s\\x7F-\\xFF]*(?:[.!,?]+[^.!,?;\"\'<>()\\[\\]{}\\s\\x7F-\\xFF]+)*)?";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        //所有符合的匹配项
        NSArray *arrayOfAllMatches = [regex matchesInString:matchText1 options:0 range:NSMakeRange(0, [matchText1 length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            NSString *matchText = [matchText1 substringWithRange:match.range];
            if ([NSURL URLWithString:matchText]) {
                NSRange range = [self rangeOfString:matchText];
                [text addAttribute:NSLinkAttributeName value:[NSURL URLWithString:matchText] range:range];
                [text addAttribute:NSForegroundColorAttributeName value:aLinkColor range:range];
            }
        }
        
    }
    return text;

}

@end
