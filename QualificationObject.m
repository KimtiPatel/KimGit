//
//  QualificationObject.m
//  QaulificationLoader
//
//  Created by kim on 17-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//

#import "QualificationObject.h"

@implementation QualificationObject

-(id)init
{
    if (self = [super init]) {
        self.subjects = [[NSArray alloc] init];
        self.country = [[NSDictionary alloc] init];
        self.default_products = [[NSArray alloc] init];
    }
    return self;

}

@end
