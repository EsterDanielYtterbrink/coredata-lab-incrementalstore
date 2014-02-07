//
//  CWPersonProperty.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CWPersonProperty : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * value;

@end
