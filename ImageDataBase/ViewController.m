//
//  ViewController.m
//  ImageDataBase
//
//  Created by rs_macbook on 15/11/11.
//  Copyright (c) 2015年 rs_macbook. All rights reserved.
//

#import "ViewController.h"
#import "TilingViewForImage.h"
#import "DataBase.h"
#import "NumberCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) IBOutlet TilingViewForImage *tiledImageView;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIView *containerView;
@property (nonatomic,weak) IBOutlet UICollectionView *cv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView.contentSize = CGSizeMake(6000, 4000);
    
    NSArray *imageArray = [Utility flyImages];
    
//    for (NSString *imageName in imageArray) {
//        [self.tiledImageView setUp:[UIImage imageNamed:imageName] name:imageName];
//    }
    [self.tiledImageView setUp:[UIImage imageNamed:@"3-5-DSC04648.JPG"] name:@"3-5-DSC04648.JPG"];

}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.containerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titile.text = [NSString stringWithFormat:@"%d",indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempName = [[Utility flyImages] objectAtIndex:indexPath.item];
    [self.tiledImageView setUp:[UIImage imageNamed:tempName] name:tempName];
    [self.tiledImageView setNeedsDisplay];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
