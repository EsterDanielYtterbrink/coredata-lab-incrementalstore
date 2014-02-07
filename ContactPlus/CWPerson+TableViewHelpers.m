//
//  CWPerson+TableViewHelpers.m
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import "CWPerson+TableViewHelpers.h"

@implementation CWPerson (TableViewHelpers)

-(void)insertObject:(CWEmail *)value inEmailsAtIndex:(NSUInteger)idx;
{
    NSMutableOrderedSet* tempSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.emails];
    [tempSet insertObject:value atIndex:idx];
    self.emails = tempSet;
}
-(void)insertObject:(CWPhoneNumber *)value inNumbersAtIndex:(NSUInteger)idx;
{
    NSMutableOrderedSet* tempSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.numbers];
    [tempSet insertObject:value atIndex:idx];
    self.numbers = tempSet;
}

-(NSInteger)numberOfSections;
{
    return 3;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return [self.numbers count]+1;
    }else if (section == 2){
        return [self.emails count]+1;
    }
    return 0;
}
-(CWPersonProperty*)personPropertyForIndexPath:(NSIndexPath*)indexPath;
{
    if (indexPath.section == 1) {
        return [self.numbers objectAtIndex:indexPath.row];
    }else if(indexPath.section == 2){
        return [self.emails objectAtIndex:indexPath.row];
    }
    return nil;
}
@end
