//
//  Child.h
//  MyKidTracker
//
//  Created by James Carlson on 8/27/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CheckIn, Family, Parent, ToDoItem, User;

@interface Child : NSManagedObject

@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * familyName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * phoneNumber;
@property (nonatomic, retain) NSData * profilePhoto;
@property (nonatomic, retain) NSSet *checkIns;
@property (nonatomic, retain) Family *family;
@property (nonatomic, retain) NSSet *parents;
@property (nonatomic, retain) User *primaryUser;
@property (nonatomic, retain) ToDoItem *toDoList;
@end

@interface Child (CoreDataGeneratedAccessors)

- (void)addCheckInsObject:(CheckIn *)value;
- (void)removeCheckInsObject:(CheckIn *)value;
- (void)addCheckIns:(NSSet *)values;
- (void)removeCheckIns:(NSSet *)values;

- (void)addParentsObject:(Parent *)value;
- (void)removeParentsObject:(Parent *)value;
- (void)addParents:(NSSet *)values;
- (void)removeParents:(NSSet *)values;

@end
