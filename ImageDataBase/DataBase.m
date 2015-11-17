//
//  DataBase.m
//  ImageDataBase
//
//  Created by rs_macbook on 15/11/11.
//  Copyright (c) 2015年 rs_macbook. All rights reserved.
//

#import "DataBase.h"

@interface DataBase ()
{
    FMDatabase *db;
}
@end

@implementation DataBase

- (instancetype)init
{
    if (self = [super init]) {
        db = [Utility shareInstanceFMDB];
    }
    return self;
}

- (void)createImageDataTable
{
    NSString *sql = @"create table if not exists imageData (id integer primary key autoincrement, nameid integer, dataimage blob,x text,y text);"
    "create table if not exists imageName (id integer primary key autoincrement, name text);"
    "create table if not exists tempData (id integer, imagedata blob);"
    "insert into imageName (name) values ('3-5-DSC04648.JPG');"
    "insert into imageName (name) values ('3-5-DSC04649.JPG');"
    "insert into imageName (name) values ('3-5-DSC04650.JPG');"
    "insert into imageName (name) values ('3-5-DSC04600.JPG');"
    "insert into imageName (name) values ('3-5-DSC04601.JPG');"
    "insert into imageName (name) values ('3-5-DSC04602.JPG');"
    "insert into imageName (name) values ('3-5-DSC04366.JPG');"
    "insert into imageName (name) values ('3-5-DSC04367.JPG');"
    "insert into imageName (name) values ('3-5-DSC04368.JPG');";
    
    if ([db open]) {
        BOOL success = [db executeStatements:sql];
        success ? NSLog(@"successs") : NSLog(@"faliure");
        [db close];
    }
    
}
- (void)addRecordImageData:(NSData *)imageData x:(CGFloat)x y:(CGFloat)y cutterImageName:(NSString *)name
{
    NSInteger imageID = 0;
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"select id from imageName where name = '%@'",name];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            imageID = [result intForColumn:@"id"];
        }
        [db close];
    }
    if ([db open]) {
        BOOL success = [db executeUpdate:@"insert into imageData (nameid,dataimage,x,y) values (?,?,?,?)",[NSNumber numberWithFloat:imageID],imageData,[NSNumber numberWithFloat:x],[NSNumber numberWithFloat:y]];
        success ? NSLog(@"insert success") : NSLog(@"insert faulire");
        [db close];
    }
}
- (NSData *)getRecordImageData:(NSString *)imageName x:(CGFloat)x y:(CGFloat)y
{
    NSData *imageData;
    NSInteger imageID = 0;
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from imageName where name = '%@'",imageName];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            imageID = [result intForColumn:@"id"];
        }
        [db close];
    }
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from imageData where nameid = %d and x = %.1f and y = %.1f",imageID,x,y];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            imageData = [result dataForColumn:@"dataimage"];
        }
        [db close];
    }
    return imageData;
}
- (NSInteger)getTotalCutterNumber:(NSString *)imageName
{
    NSInteger imageID = 0;
    NSInteger imageCount;
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from imageName where name = '%@'",imageName];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            imageID = [result intForColumn:@"id"];
        }
        [db close];
    }
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"select count(*) as namecount from imageData where nameid = %ld",(long)imageID];
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            imageCount = [result intForColumn:@"namecount"];
        }
        [db close];
    }
    return imageCount;
}

@end
