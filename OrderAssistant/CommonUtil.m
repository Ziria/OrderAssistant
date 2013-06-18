//
//  CommonUtil.m
//  OrderAssistant
//
//  Created by flybird on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://www.0519517.com" stringByAppendingString:fileURL]]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

@end
