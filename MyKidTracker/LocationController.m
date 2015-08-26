//
//  LocationController.m
//  MyKidTracker
//
//  Created by James Carlson on 8/20/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import "LocationController.h"
#import "Stack.h"

@implementation LocationController

+ (LocationController *)sharedInstance {
    static LocationController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [LocationController new];
    });
    return sharedInstance;
}

- (Location *)createLocationWithFamily: (NSString *)family title:(NSString *)title infoSnippet:(NSString *)snippet lattitude:(NSString *)lattitude longitude:(NSString *)longitude radius:(NSNumber *)radius {
    
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    location.locationTitle = title;
    location.locationSnippet = snippet;
    location.latitude = lattitude;
    location.longitude = longitude;
    
    [self saveToPersistentStorage];
    
    return location;
}

#pragma mark - Read

- (NSArray *)locations {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    
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

- (void)removeEntry:(Location *)location {
    [location.managedObjectContext deleteObject:location];
}


@end
