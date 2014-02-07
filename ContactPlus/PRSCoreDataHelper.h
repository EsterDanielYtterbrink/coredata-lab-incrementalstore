//
//  PRSCoreDataHelper.h
//  IncrementalStore
//
//  Created by Ester Ytterbrink on 04/11/2013.
//  Copyright (c) 2013 Prisjakt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRSCoreDataHelper : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
