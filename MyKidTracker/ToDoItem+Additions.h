//
//  ToDoItem+Additions.h
//  MyKidTracker
//
//  Created by James Carlson on 8/29/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import "ToDoItem.h"

@interface ToDoItem (Additions)

@property (nonatomic, assign) BOOL itemIsCompleted;
@property (nonatomic, assign) BOOL wasSyncedAlready;

@end
