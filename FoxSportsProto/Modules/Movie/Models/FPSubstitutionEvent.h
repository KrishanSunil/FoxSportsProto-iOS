//
//  FPSubstitutionEvent.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPEvent.h"

@interface FPSubstitutionEvent : FPEvent

@property (nonatomic, copy) NSString *playerInName;
@property (nonatomic, copy) NSString *playerOutName;

@end
