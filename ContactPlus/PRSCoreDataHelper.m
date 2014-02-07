//
//  PRSCoreDataHelper.m
//  IncrementalStore
//
//  Created by Ester Ytterbrink on 04/11/2013.
//  Copyright (c) 2013 Prisjakt. All rights reserved.
//

#import "PRSCoreDataHelper.h"
@interface PRSCoreDataHelper ()
@property(nonatomic, strong) NSManagedObjectContext* backgroundContext;
@end
@implementation PRSCoreDataHelper
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        self.backgroundContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
       
     /*  [self.backgroundContext performBlockAndWait:^{
           NSURL* url = [[NSBundle mainBundle] URLForResource:@"products" withExtension:@"json"];
           NSData* jsonData = [NSData dataWithContentsOfURL:url];
           NSError* error;
           NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
           NSArray* items = dictionary[@"items"];
           for (NSDictionary* product in items){
               NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PRSProduct"];
               fetchRequest.predicate = [NSPredicate predicateWithFormat: @"name like %@", product[@"name"]];
             //  if ([self.backgroundContext countForFetchRequest:fetchRequest error:nil]  == 0) {
               PRSProduct* managedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"PRSProduct" inManagedObjectContext:self.backgroundContext];
               managedProduct.name = product[@"name"];
               managedProduct.stockStatus = product[@"stock_status"];
                   
           //    }
           }
           if ([self.backgroundContext hasChanges]) {
               NSError* error;
               [self.backgroundContext save:&error];
               if (error) {
                   NSLog(@"Error: %@ ", error);
               }
           }
        }];*/
    }
    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"IncrementalStore" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"IncrementalStore.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:@"CWAddressBookIncrementalStore" configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
