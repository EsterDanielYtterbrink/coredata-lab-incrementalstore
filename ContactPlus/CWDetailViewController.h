//
//  CWDetailViewController.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWPerson.h"
@interface CWDetailViewController : UITableViewController

@property (strong, nonatomic) CWPerson* person;
@property(strong, nonatomic) NSManagedObjectContext* context;
@end
