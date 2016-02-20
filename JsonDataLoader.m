//
//  JsonDataLoader.m
//  QaulificationLoader
//
//  Created by kim on 18-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//

#import "JsonDataLoader.h"
#import "QualificationsSingleton.h"


@implementation JsonDataLoader


-(void)startDownloadWithURL: (NSString *)jsonDataURL
{
    NSLog(@"Download should start");

    NSURL *downloadURL = [[NSURL alloc]initWithString:jsonDataURL];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]   dataTaskWithURL:downloadURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (!error)
                                              {
                                                  [self saveData:data];

                                              }
                                              
                                              
       
                                          }];
    
    if (downloadTask.response)
    {
        [self saveLastDownloadDateFromServer:downloadTask];

    }
    
    [downloadTask resume];
    
}



-(void)saveLastDownloadDateFromServer:(NSURLSessionDataTask *)downloadTask
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse* )downloadTask.response;
    
    if ([response respondsToSelector:@selector(allHeaderFields)])
    {
        NSString *lastModifiedString = [[response allHeaderFields] objectForKey:@"Last-Modified"];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        
        NSDate *lastModifiedServerDate = [df dateFromString:lastModifiedString];
        
        //saving Last Download date in UserDefault
        [[NSUserDefaults standardUserDefaults] setObject:lastModifiedServerDate forKey:@"Last-Modified"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


-(void)saveData:(NSData *)data
{
    QualificationsSingleton *qSingleton = [QualificationsSingleton sharedInstance];
    
    NSLog(@"Save Data called");
    NSString *cachedPath = [qSingleton filePath:qSingleton.jasonFileName];
    
    [data writeToFile:cachedPath atomically:YES];

    
    
    
}

@end
