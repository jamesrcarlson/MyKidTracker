//
//  PrimaryUserController.m
//  MyKidTracker
//
//  Created by James Carlson on 8/20/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import "UserController.h"
#import "Stack.h"

@implementation UserController

+ (UserController *)sharedInstance {
    static UserController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [UserController new];
    });
    return sharedInstance;
}

- (User *)createUserWithFamilyName:(NSString *)family firstname:(NSString *)firstname lastName:(NSString *)lastName emailAddress:(NSString *)email phoneNumber:(NSNumber *)number userRole:(Boolean *)role {
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    user.familyName = family;
    user.userFirstName = firstname;
    user.userLastName = lastName;
    user.userEmail = email;
    user.userPhoneNumber = number;
    user.userRole = [NSNumber numberWithBool:role];
    
    return user;
}

#pragma mark - Read

- (NSArray *)user {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSArray *fetchedObjects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects;
}

#pragma mark - Update

- (void)save {
    [self saveToPersistentStorage];
}

- (void)saveToPersistentStorage {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

#pragma mark - Delete

- (void)removeEntry:(User *)user {
    [user.managedObjectContext deleteObject:user];
}
@end
