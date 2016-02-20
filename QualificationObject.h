//
//  QualificationObject.h
//  QaulificationLoader
//
//  Created by kim on 17-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QualificationObject : NSObject

@property (strong, nonatomic) NSDictionary *country;

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *subjects;
@property (strong, nonatomic) NSArray *default_products;

@property (strong, nonatomic) NSString *link;


@end
