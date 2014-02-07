//
//  CWDetailViewController.m
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import "CWDetailViewController.h"
#import "CWPerson+TableViewHelpers.h"
#import "CWPredefinedTitleCell.h"
#import "CWEditPropertyCell.h"

@interface CWDetailViewController ()
- (IBAction)done:(id)sender;
@end

@implementation CWDetailViewController

#pragma mark - Managing the detail item
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  [self.person numberOfSections];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 1) {
        return @"Phone numbers";
    }if (section == 2) {
        return @"Email addresses";
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 1 && indexPath.row == [self.person.numbers count]) {
      
        //Create a phone object
        [self.person insertObject:phoneNumber inNumbersAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }else if (indexPath.section == 2 && indexPath.row == [self.person.emails count]) {
        //Create an Email object
        [self.person insertObject:email inEmailsAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }

}
-(void)save;
{
    NSError* error = nil;
   //Save context
}

-(NSInteger)tableView:tableView numberOfRowsInSection:(NSInteger)section;
{
   return [self.person numberOfRowsInSection:section];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.section == 0) {
        CWPredefinedTitleCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"predefined" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"First name";
            cell.key = @"firstName";
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"Last name";
            cell.key = @"lastName";
        }
        cell.person = self.person;
        return cell;
    }else if (indexPath.row == [self.person numberOfRowsInSection:indexPath.section]-1){
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Add" forIndexPath:indexPath];
        cell.textLabel.text = @"Add";
        return cell;
    }else{
        CWEditPropertyCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"keyValue" forIndexPath:indexPath];
        cell.property = [self.person personPropertyForIndexPath:indexPath];
        return cell;
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
