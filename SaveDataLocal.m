//
//  SaveDataLocal.m
//  QaulificationLoader
//
//  Created by kim on 18-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//

#import "SaveDataLocal.h"
#import "QualificationsSingleton.h"


@implementation SaveDataLocal
{
    QualificationsSingleton *qualificationSingleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        qualificationSingleton = [QualificationsSingleton sharedInstance];

    }
    return self;
}
@end
