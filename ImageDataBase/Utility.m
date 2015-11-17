//
//  Utility.m
//  ImageDataBase
//
//  Created by rs_macbook on 15/11/11.
//  Copyright (c) 2015年 rs_macbook. All rights reserved.
//

#import "Utility.h"
static FMDatabase *fmdb;
@interface Utility ()
{
    FMDatabase *database;
}
@end
@implementation Utility

+ (NSArray *)flyImages
{
    NSArray *images = @[@"3-5-DSC04648.JPG",@"3-5-DSC04649.JPG",@"3-5-DSC04650.JPG",@"3-5-DSC04600.JPG",@"3-5-DSC04601.JPG",@"3-5-DSC04602.JPG",@"3-5-DSC04366.JPG",@"3-5-DSC04367.JPG",@"3-5-DSC04368.JPG"];

    return images;
}

+ (FMDatabase *)shareInstanceFMDB
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    if (fmdb == nil) {
        fmdb = [[FMDatabase alloc] initWithPath:[doc stringByAppendingString:@"/imageData.db"]];
    }
    return fmdb;
}





@end
