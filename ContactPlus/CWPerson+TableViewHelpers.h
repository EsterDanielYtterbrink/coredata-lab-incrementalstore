//
//  CWPerson+TableViewHelpers.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import "CWPerson.h"
#import "CWPersonProperty.h"
@interface CWPerson (TableViewHelpers)
-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(CWPersonProperty*)personPropertyForIndexPath:(NSIndexPath*)indexPath;
@end
