//
//  PRSCacheIncrementalStore.m
//  IncrementalStore
//
//  Created by Ester Ytterbrink on 04/11/2013.
//  Copyright (c) 2013 Prisjakt. All rights reserved.
//

#import "CWAddressBookIncrementalStore.h"
@import AddressBook;

@interface CWAddressBookIncrementalStore()

@end
@implementation CWAddressBookIncrementalStore
-(id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)root configurationName:(NSString *)name URL:(NSURL *)url options:(NSDictionary *)options;
{
    self  = [super initWithPersistentStoreCoordinator:root configurationName:name URL:url options:options];
    if (!self) {
        return self;
    }
    return self;
}

-(BOOL)loadMetadata:(NSError *__autoreleasing *)error;
{
    NSDictionary * metadata = @{ NSStoreUUIDKey: @"CWAddressBookIncrementalStoreUDID", NSStoreTypeKey: @"CWAddressBookIncrementalStore"};
    self.metadata = metadata;
    return YES;
}

-(id)executeRequest:(NSPersistentStoreRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    //TODO Find the right parameters
    CFErrorRef* errorRef = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, errorRef);
    if ([request requestType] == NSFetchRequestType) {

        NSFetchRequest* fetchRequest = (NSFetchRequest*)request;
        NSEntityDescription* entity = [fetchRequest entity];
        NSMutableArray* fetchedObjects = [NSMutableArray array];
        if ([entity.managedObjectClassName isEqualToString:@"CWPerson"]) {
            NSArray* allPeople = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople (addressBook));
            for (int i = 0; i< [allPeople count]; i++){
                ABRecordRef person = (__bridge ABRecordRef)([allPeople objectAtIndex:i]);
                ABRecordID recordId = ABRecordGetRecordID(person);
                NSManagedObjectID* objectID = [self newObjectIDForEntity:entity referenceObject:@(recordId)];
                [fetchedObjects addObject:[context objectWithID:objectID]];
            }
            [fetchedObjects sortUsingDescriptors:fetchRequest.sortDescriptors];
        }
        /* if([entity.managedObjectClassName isEqualToString:@"CWPersonProperty"])
        {
            fetchedObjects = [NSMutableArray arrayWithObject:[context objectWithID:[self newObjectIDForEntity:entity referenceObject:@"Aircrafts"]]];
        }else if ([entity.managedObjectClassName isEqualToString:@"CWPhoneNumber"])
        {
            fetchedObjects = [NSMutableArray arrayWithObject:[context objectWithID:[self newObjectIDForEntity:entity referenceObject:@"Aircrafts"]]];

        }else if ([entity.managedObjectClassName isEqualToString:@"CWEmail"])
        {
            fetchedObjects = [NSMutableArray arrayWithObject:[context objectWithID:[self newObjectIDForEntity:entity referenceObject:@"Aircrafts"]]];

        }
        return fetchedObjects;
    }else if ([request requestType] == NSSaveRequestType){
        NSSaveChangesRequest* saveRequest = (NSSaveChangesRequest*)request;
        NSSet* deletedObjects = [saveRequest deletedObjects ];
        //The save request has sets for inserted, updated, deleted and locked objects.
        //Use these to perform the actual update.
        
        return @[];*/
    }
        CFRelease(addressBook);
    return  nil;
}


// Returns an NSIncrementalStoreNode encapsulating the persistent external values for the object for an objectID.
// It should include all attributes values and may include to-one relationship values as NSManagedObjectIDs.
// Should return nil and set the error if the object cannot be found.

- (NSIncrementalStoreNode *)newValuesForObjectWithID:(NSManagedObjectID*)objectID withContext:(NSManagedObjectContext*)context error:
    (NSError**)error;
{
   /* NSIncrementalStoreNode* node;
    if ([objectID.entity.name isEqualToString:@"CW"]) {
        NSString* name = [self referenceObjectForObjectID:objectID];
        NSMutableDictionary* values = [NSMutableDictionary dictionaryWithDictionary:self.objects[name]];
        [values setObject:[self newObjectIDForEntity:[NSEntityDescription entityForName:@"PRSCategory" inManagedObjectContext:context] referenceObject:@"Aircrafts"] forKey:@"category"];
        //Should be incremented when record is saved!!
        uint64_t version = 1;
     node = [[NSIncrementalStoreNode alloc] initWithObjectID:objectID withValues:values version:version];
        return node;
    }else if ([objectID.entity.name isEqualToString:@"PRSCategory"]){
       node  =[[ NSIncrementalStoreNode alloc]initWithObjectID:objectID withValues:@{@"name":@"Aircrafts",@"identifier":@"543",@"lowestPrice":@42}     version:1];
    }
    return node;*/
    return [[ NSIncrementalStoreNode alloc]initWithObjectID:objectID withValues:@{@"lastName":@"Bar",@"firstName":@"Foo"}     version:1];;
}

-(NSArray *)obtainPermanentIDsForObjects:(NSArray *)array error:(NSError *__autoreleasing *)error;
{
    NSMutableArray* objectIDs = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSManagedObject* managedObject in array){
        NSManagedObjectID* managedObjectID;
        if ([managedObject respondsToSelector:@selector(name)]) {
            managedObjectID = [self newObjectIDForEntity:managedObject.entity referenceObject:[managedObject valueForKey:@"name"] ];
        }else{
        
        }
        if (managedObjectID) {
            [objectIDs addObject:managedObjectID];
        }
    }
    return objectIDs;
}
// Returns the relationship for the given relationship on the object with ID objectID. If the relationship
// is a to-one it should return an NSManagedObjectID corresponding to the destination or NSNull if the relationship value is nil.
// If the relationship is a to-many, should return an NSSet or NSArray containing the NSManagedObjectIDs of the related objects.
// Should return nil and set the error if the source object cannot be found.
- (id)newValueForRelationship:(NSRelationshipDescription*)relationship forObjectWithID:(NSManagedObjectID*)objectID withContext:(NSManagedObjectContext *)context error:(NSError **)error;
{
   /* //Assume only products have relationships
    NSString* name = (NSString*)[self referenceObjectForObjectID:objectID ];
    NSLog(@"newValueForRelationship Name is: %@", name);

    NSDictionary* dict = self.objects[name];
    NSString* categoryIdentifier = dict[@"category"];
    return [self newObjectIDForEntity:relationship.entity referenceObject:categoryIdentifier];
    */
    return nil;
}


@end
