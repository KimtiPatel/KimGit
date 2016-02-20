//
//  QualificationTableVC.m
//  QaulificationLoader
//
//  Created by kim on 17-02-16.
//  Copyright © 2016 SkyeApps. All rights reserved.
//

#import "QualificationTableVC.h"
#import "QualificationsSingleton.h"
#import "CustomTableCell.h"
#import "QualificationObject.h"
#import "SubjectDetailVC.h"


@interface QualificationTableVC ()
{
    QualificationsSingleton *qSingleton;
    
    NSArray *qualifications;
}

@end

@implementation QualificationTableVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    qSingleton =  [QualificationsSingleton sharedInstance];
   
    
    [self getQualificationArrayFromFile];
}

-(void)getQualificationArrayFromFile
{
    qualifications = [[NSArray alloc] init];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[qSingleton filePath:qSingleton.jasonFileName]])
    {
        
        NSData *fileData = [[NSData alloc] initWithContentsOfFile:[qSingleton filePath:qSingleton.jasonFileName]];
        
        NSError *error= nil;
        
        qualifications = [qSingleton qualificationJSONDetails:fileData error:&error];
        
        
    }
    else
    {
        NSLog(@"JSON file does not exist at path");
    }
    
    NSLog(@"Array:%lu",qualifications.count);

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return qualifications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    QualificationObject *qualificationObject = qualifications[indexPath.row];
    
    NSLog(@"Cell for row:%@ and Index:%lu",qualificationObject.name, indexPath.row);
    
    if (qualificationObject )
    {
        
    
    
            if (qualificationObject.name)
            {
                [cell.qualificationTitle setText: qualificationObject.name];
                NSLog(@" Name:%@",qualificationObject.name);

            }
            else
            {
                NSLog(@"No Name");
            }
        
        
        if ([self checkIfNull:qualificationObject.country ] )
        {
            // NSLog(@"Key exist:%@",[qualificationObject.country allKeys]);
        
            if ([qualificationObject.country allKeys].count > 0 && [[qualificationObject.country allKeys] containsObject:@"name"])
            {
                NSLog(@"key contains Name");
            
                if ([self checkIfNull:[qualificationObject.country objectForKey:@"name"]] == true)
                {
                    NSLog(@"Country : %@",[qualificationObject.country objectForKey:@"name"]);
                    [cell.country setText:[qualificationObject.country objectForKey:@"name"]];
                
                }
            

            }
        }
        else
        {
            NSLog(@"country name is NULL");
            [cell.country setText:@"Not Available"];
        
        }
        
        if (qualificationObject.subjects.count == 0)
        {
            cell.showDetail.hidden = YES;
        }
    }
    
    return cell;
}
-(BOOL)checkIfNull:(id)object
{
    if (object == [NSNull null] || object == nil)
    {
        return false;
    }
    else
    {
        return true;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QualificationObject *qualificationObject = qualifications[indexPath.row];

    if ([self checkIfNull:qualificationObject.subjects] == true)
    {
        NSLog(@"subjects");
    }
    
   SubjectDetailVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectDetailVC"];
    
    detailViewController.subjects = [[NSArray alloc] initWithArray:qualificationObject.subjects];
    
    [self.navigationController pushViewController:detailViewController animated:YES];

    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
