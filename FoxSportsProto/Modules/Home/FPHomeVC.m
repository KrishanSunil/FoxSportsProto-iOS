//
//  FPHomeVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPHomeVC.h"
#import "FPMedia.h"
#import "FPMediaCell.h"
#import "FPMediaNetworkClient.h"
#import "FPSimpleDataSource.h"
#import "NSObject+FPAdditions.h"
#import "FPMoviePlayerVC.h"
#import "UIViewController+FPAdditions.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface FPHomeVC () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) FPSimpleDataSource *dataSource;

@end

@implementation FPHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    [self getMediaList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupCollectionView
{
    self.dataSource = [[FPSimpleDataSource alloc] init];
    self.dataSource.cellIdentifier = [FPMediaCell fp_identifier];

    self.dataSource.cellConfigureBlock = ^(UICollectionViewCell *cell, FPMedia *media) {
        FPMediaCell *mediaCell = (id)cell;
        [mediaCell configureForModel:media];
    };

    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
}

#pragma mark - Data
- (void)getMediaList
{
    FPMediaNetworkClient *client = [[FPMediaNetworkClient alloc] init];

    [SVProgressHUD show];
    [client getMediaListWithSuccess:^(NSArray *array) {
        self.dataSource.items = array;
        [self.collectionView reloadData];
        [SVProgressHUD showSuccessWithStatus:nil];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:nil];
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FPMedia *media = self.dataSource.items[indexPath.item];
    FPMoviePlayerVC *playerVC = [FPMoviePlayerVC fp_instantiatedFromStoryboardNamed:@"MoviePlayer"];
    playerVC.media = media;

    [self.navigationController pushViewController:playerVC animated:YES];

}

@end
