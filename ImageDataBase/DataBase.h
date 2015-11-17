//
//  DataBase.h
//  ImageDataBase
//
//  Created by rs_macbook on 15/11/11.
//  Copyright (c) 2015年 rs_macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject


- (void)createImageDataTable;

- (void)addRecordImageData:(NSData *)imageData x:(CGFloat)x y:(CGFloat)y cutterImageName:(NSString *)name;
- (NSData *)getRecordImageData:(NSString *)imageName x:(CGFloat)x y:(CGFloat)y;

- (NSInteger)getTotalCutterNumber:(NSString *)imageName;

@end
