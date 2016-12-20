//
//  SearchViewController.m
//  decoration
//
//  Created by 林 建军 on 05/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "SearchViewController.h"
#import "City.h"
#import "UPDao+City.h"
#import "ImageCollectionViewCell.h"
#import "DaoDefines.h"
@interface SearchViewController ()

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong)  NSArray *datas;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [NSMutableArray array];
    _datas  = [[[UPDao alloc] init] getCitys:@""];
   
    for (int index = 0; index < [_datas count]; index++) {
        City *city = [_datas objectAtIndex:index];
        NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),city.name];
       
        [_imageArray addObject:aPath3];
    }
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (IBAction)goBack:(id)sender {
        [ self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell"
                                                                                 forIndexPath:indexPath];
    NSString *aPath3 = [_imageArray objectAtIndex:indexPath.row];
    
     UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
  UIImage *g  = [UIImage imageWithCGImage:imgFromUrl3.CGImage scale:2.0 orientation:UIImageOrientationRight];
    cell.cImageView.image = g;
    City *city = [_datas objectAtIndex:indexPath.row];
    cell.titleLabel.text = city.name;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth - 10, ScreenHight - 90);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
