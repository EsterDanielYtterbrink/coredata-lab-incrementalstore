//
//  CWPhoneNumber.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CWPersonProperty.h"

@class CWPerson;

@interface CWPhoneNumber : CWPersonProperty

@property (nonatomic, retain) CWPerson *person;

@end
