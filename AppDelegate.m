//
//  AppDelegate.m
//  QaulificationLoader
//
//  Created by kim on 17-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//
#import "AppDelegate.h"
#import "JsonDataLoader.h"
#import "QualificationsSingleton.h"


@interface AppDelegate ()

@property (nonatomic,strong)   JsonDataLoader *jsonLoader;

@end


@implementation AppDelegate



#define JSON_Data_URL @"https://api.gojimo.net/api/v4/qualifications"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    
    QualificationsSingleton *qSingleton = [QualificationsSingleton sharedInstance];

    
    self.jsonLoader = [[JsonDataLoader alloc] init];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        NSLog(@"App launching first time");
        [self.jsonLoader startDownloadWithURL:qSingleton.jasonDataUrl];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    else
    {
        NSLog(@"lunched Before");
        [self downloadDataIfNeeded];

    }
    
    return YES;
}

-(void)downloadDataIfNeeded
{
    NSLog(@"Download if needed");
    
    QualificationsSingleton *qSingleton = [QualificationsSingleton sharedInstance];

    // Retriving Last Downloaded Date saved Or If Exist yet
    NSDate *lastModifiedServerDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"Last-Modified"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cachedPath = [qSingleton filePath:qSingleton.jasonFileName];
    
    NSDate *lastModifiedFileDate = nil;
    
    if ([fileManager fileExistsAtPath:cachedPath])
    {
        NSError *error = nil;
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:cachedPath error:&error];
        if (error)
        {
            NSLog(@"Error reading file attributes for: %@ - %@", cachedPath, [error localizedDescription]);
        }
        lastModifiedFileDate = [fileAttributes fileModificationDate];
        
        NSLog(@"lastModifiedLocal : %@", lastModifiedFileDate);
    }
    
    // Condition 1: If file not cached locally
    // Condition 1: If the server modified Date is later than the local modified Date

    if (!lastModifiedFileDate || [lastModifiedFileDate laterDate:lastModifiedServerDate] == lastModifiedServerDate)
    {
        NSLog(@"File not exist at path OR Last file modified date not matched");
        [self.jsonLoader startDownloadWithURL:qSingleton.jasonDataUrl];
    }
    
    
    
}



@end
