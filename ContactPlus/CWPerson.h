//
//  CWPerson.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CWEmail, CWPhoneNumber;

@interface CWPerson : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSOrderedSet *numbers;
@property (nonatomic, retain) NSOrderedSet *emails;
@end

@interface CWPerson (CoreDataGeneratedAccessors)

- (void)insertObject:(CWPhoneNumber *)value inNumbersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromNumbersAtIndex:(NSUInteger)idx;
- (void)insertNumbers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeNumbersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInNumbersAtIndex:(NSUInteger)idx withObject:(CWPhoneNumber *)value;
- (void)replaceNumbersAtIndexes:(NSIndexSet *)indexes withNumbers:(NSArray *)values;
- (void)addNumbersObject:(CWPhoneNumber *)value;
- (void)removeNumbersObject:(CWPhoneNumber *)value;
- (void)addNumbers:(NSOrderedSet *)values;
- (void)removeNumbers:(NSOrderedSet *)values;
- (void)insertObject:(CWEmail *)value inEmailsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEmailsAtIndex:(NSUInteger)idx;
- (void)insertEmails:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEmailsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEmailsAtIndex:(NSUInteger)idx withObject:(CWEmail *)value;
- (void)replaceEmailsAtIndexes:(NSIndexSet *)indexes withEmails:(NSArray *)values;
- (void)addEmailsObject:(CWEmail *)value;
- (void)removeEmailsObject:(CWEmail *)value;
- (void)addEmails:(NSOrderedSet *)values;
- (void)removeEmails:(NSOrderedSet *)values;
@end
