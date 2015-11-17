//
//  TilingViewForImage.m
//  ImageDataBase
//
//  Created by rs_macbook on 15/11/11.
//  Copyright (c) 2015年 rs_macbook. All rights reserved.
//

#import "TilingViewForImage.h"
#import "DataBase.h"
@interface TilingViewForImage()
{
    NSInteger totalColumns;
    NSInteger totalRows;
    NSString *imageName;
}
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)DataBase *dataBase;
@end

@implementation TilingViewForImage

+ (Class)layerClass
{
    return [CATiledLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CATiledLayer *tiledLayer = (CATiledLayer *)self.layer;
        tiledLayer.contentsScale = [[UIScreen mainScreen]scale];
        tiledLayer.tileSize = CGSizeMake(CUTWIDTH, CUTHEIGHT);
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (DataBase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [[DataBase alloc]init];
    }
    return _dataBase;
}

- (void)setUp:(UIImage*)cutterImage name:(NSString *)name
{
    [self.dataArray removeAllObjects];
    CGImageRef imageRef = cutterImage.CGImage;
    totalColumns = ceilf(cutterImage.size.width / CUTWIDTH *1.0);
    totalRows = ceilf(cutterImage.size.height / CUTHEIGHT *1.0);
    imageName = name;
    NSInteger x=0,y=0;
    for (y = 0; y<totalRows; y++) {
        NSMutableArray *row = [NSMutableArray array];
        for (x = 0; x < totalColumns; x++) {
            CGFloat xOffset = x * CUTWIDTH;
            CGFloat yOffset = y * CUTHEIGHT;
            
//            CGImageRef tileImageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(xOffset, yOffset, CUTWIDTH, CUTHEIGHT));
//            NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:tileImageRef], 0);  // return image as JPEG. May return nil if image has no CGImageRef or invalid bitmap format. compression is 0(most)..1(least)
//
//            [self.dataBase addRecordImageData:imageData x:xOffset y:yOffset cutterImageName:name];
            
            
            NSData *tempData = [self.dataBase getRecordImageData:name x:xOffset y:yOffset];
            [row addObject:tempData];
        }
        [self.dataArray addObject:row];
    }

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    for (NSInteger row = 0; row< totalRows; row++) {
        NSMutableArray *rows = [self.dataArray objectAtIndex:row];
        for (NSInteger column = 0; column < totalColumns; column++) {
            
            CGFloat x = CUTWIDTH * column;
            CGFloat y = CUTHEIGHT *row;
            CGRect tileRect = CGRectMake(x, y, CUTWIDTH, CUTHEIGHT);
            
            UIImage *tileImage = [UIImage imageWithData:[rows objectAtIndex:column]];
            if (tileImage != nil) {
                tileRect = CGRectIntersection(self.bounds, tileRect);
                [tileImage drawInRect:tileRect];
            }
        }
    }
    
}


@end
