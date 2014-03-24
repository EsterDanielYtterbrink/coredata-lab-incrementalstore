//
//  PRSCacheIncrementalStore.m
//  IncrementalStore
//
//  Created by Ester Ytterbrink on 04/11/2013.
//  Copyright (c) 2013 Prisjakt. All rights reserved.
//

#import "CWAddressBookIncrementalStore.h"
#import "CWPerson.h"
@import AddressBook;

@interface CWAddressBookIncrementalStore()

@end
@implementation CWAddressBookIncrementalStore

#pragma mark - setup
+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}
+ (NSString *)type {
    return [NSStringFromClass(self) stringByAppendingString:@"Type"];
}

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
    NSDictionary * metadata = @{ NSStoreUUIDKey: [[NSProcessInfo processInfo] globallyUniqueString], NSStoreTypeKey: [[self class]type]};
    self.metadata = metadata;
    return YES;
}

#pragma mark - Main methods
-(id)executeRequest:(NSPersistentStoreRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    CFErrorRef* errorRef = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, errorRef);
    if ([request requestType] == NSFetchRequestType) {
        return [self executeFetchRequest:(NSFetchRequest*)request withContext:context error:error];
    }else if ([request requestType] == NSSaveRequestType){
        return [self executeSaveRequest:(NSSaveChangesRequest*)request withContext:context error:error];
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
    NSIncrementalStoreNode* node;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if ([objectID.entity.name isEqualToString:@"Person"]) {
        NSNumber* idAsNumber = [self referenceObjectForObjectID:objectID];
        ABRecordID recordID = idAsNumber.integerValue;
        ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
       NSString* firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
       NSString* lastName  = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSMutableDictionary* values = [NSMutableDictionary dictionary];
        if (firstName) {
            [values setObject:firstName forKey:@"firstName"];
        }
        if (lastName) {
            [values setObject:lastName forKey:@"lastName"];
        }
        if (!(firstName || lastName)) {
            NSLog(@"names are both nil");

        }

        //NSLog(@"newValuesForObjectWithEntityName %@, firstName %@, lastName %@", objectID.entity.name, firstName, lastName);

       //TODO! Add emails etc. [values setObject:[self newObjectIDForEntity:[NSEntityDescription entityForName:@"PRSCategory" inManagedObjectContext:context] referenceObject:@"Aircrafts"] forKey:@"category"];
        //Should be incremented when record is saved!!
        uint64_t version = 1;
     node = [[NSIncrementalStoreNode alloc] initWithObjectID:objectID withValues:values version:version];
        return node;
    }/*else if ([objectID.entity.name isEqualToString:@"PRSCategory"]){
       node  =[[ NSIncrementalStoreNode alloc]initWithObjectID:objectID withValues:@{@"name":@"Aircrafts",@"identifier":@"543",@"lowestPrice":@42}     version:1];
    }
      */
    return node;
}

// Called before a save request
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
 
    return nil;
}
#pragma mark - Helper methods

-(NSArray*)executeFetchRequest:(NSFetchRequest *)fetchRequest withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    NSFetchRequestResultType resultType = fetchRequest.resultType;
    
    switch (resultType) {
        case NSManagedObjectResultType:
            return [self objectsForFetchRequest:fetchRequest withContext:context error:error];
            break;
        case NSManagedObjectIDResultType:
            return [self objectsIDsForFetchRequest:fetchRequest withContext:context error:error];
            break;
        case NSDictionaryResultType:
            [self dictionariesForFetchRequest:fetchRequest withContext:context error:error];
            break;
        case NSCountResultType:
            [self countForFetchRequest:fetchRequest withContext:context error:error];
            break;
        default:
            break;
    }
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSEntityDescription* entity = [fetchRequest entity];
    NSMutableArray* fetchedObjects = [NSMutableArray array];
    if ([entity.managedObjectClassName isEqualToString:@"CWPerson"]) {
        NSArray* allPeople = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople (addressBook));
        for (int i = 0; i< [allPeople count]; i++){
            ABRecordRef person = (__bridge ABRecordRef)([allPeople objectAtIndex:i]);
            ABRecordID recordId = ABRecordGetRecordID(person);
            NSString* lastName  = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
            NSLog(@"lastName %@", lastName);
            NSManagedObjectID* objectID = [self newObjectIDForEntity:entity referenceObject:@(recordId)];
            CWPerson* p = (CWPerson*)[context objectWithID:objectID];
            //               p.lastName = lastName;
            [fetchedObjects addObject:p];
        }
        [fetchedObjects sortUsingDescriptors:fetchRequest.sortDescriptors];
        return fetchedObjects;
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
     
     }*/
     return fetchedObjects;
}

-(NSArray*)executeSaveRequest:(NSSaveChangesRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    return @[];
}

-(NSArray*)countForFetchRequest:(NSFetchRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    return @[];
}
-(NSArray*)objectsForFetchRequest:(NSFetchRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    return @[];
}
-(NSArray*)objectsIDsForFetchRequest:(NSFetchRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    return @[];
}
-(NSArray*)dictionariesForFetchRequest:(NSFetchRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error;
{
    return @[];
}

@end
