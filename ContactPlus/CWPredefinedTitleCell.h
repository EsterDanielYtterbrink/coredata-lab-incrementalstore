//
//  CWPredefinedTitleCell.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWPerson.h"
@interface CWPredefinedTitleCell : UITableViewCell
@property(nonatomic, strong) NSString* key;
@property(nonatomic, strong) CWPerson* person;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
