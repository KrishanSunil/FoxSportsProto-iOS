//
//  FPSimpleDataSource.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

@import UIKit;

typedef void (^FPCellConfigureBlock)(id cell, id item);

@interface FPSimpleDataSource : NSObject <UICollectionViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) FPCellConfigureBlock cellConfigureBlock;

@end
