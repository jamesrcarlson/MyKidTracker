//
//  KidDetailsViewController.m
//  KidTracker
//
//  Created by James Carlson on 8/18/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import "ChildCheckInViewController.h"
#import "UserController.h"
#import "CheckInController.h"
#import "CheckinDetailsTableViewController.h"
#import "CheckOutController.h"

typedef NS_ENUM(NSUInteger, TableViewsection){
    TableViewsectionCheckIn,
    TableViewsectionCheckOut
};

@interface ChildCheckInViewController () <UISplitViewControllerDelegate>

@property NSMutableArray *theCheckins;
@property NSMutableArray *theCheckOuts;

@end

@implementation ChildCheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = self.anotherUser;
    self.theCheckins =[NSMutableArray new];
    for (CheckIn *chekin in currentUser.checkIns) {
        [self.theCheckins addObject:chekin];
    }
    self.theCheckOuts =[NSMutableArray new];
    for (CheckOut *chekout in currentUser.checkIns) {
        [self.theCheckOuts addObject:chekout];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TableViewsection tableViewsection = section;

    switch (tableViewsection) {
        case TableViewsectionCheckIn:
            return self.theCheckins.count;
            
        case TableViewsectionCheckOut:
            return self.theCheckOuts.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TableViewsection tableViewsection = section;
    switch (tableViewsection) {
        case TableViewsectionCheckIn:
            return @"The Check-ins";
            break;
        case TableViewsectionCheckOut:
            return @"Check-outs";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kidDetailCell" forIndexPath:indexPath];
    
    if (indexPath.section == TableViewsectionCheckIn) {
        cell.textLabel.text = [self.theCheckins[indexPath.row]locationName];
        if (![self.theCheckins[indexPath.row]checkout]) {
            cell.detailTextLabel.text = @"still checked in";
        } else {
            cell.detailTextLabel.text = @"has already checked out";
        }
    }
    if (indexPath.section == TableViewsectionCheckOut) {
        cell.textLabel.text = [self.theCheckOuts[indexPath.row]locationName];
        if (![self.theCheckOuts[indexPath.row]checkout]) {
            cell.detailTextLabel.text = @"still checked in";
        } else {
            cell.detailTextLabel.text = @"has already checked out";
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TableViewsectionCheckIn) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            CheckIn *checkin = [CheckInController sharedInstance].checkins[indexPath.row];
            [[CheckInController sharedInstance]removeCheckinItem:checkin];
            if ([self.theCheckins[indexPath.row]checkout]) {
                [self.theCheckOuts removeObjectAtIndex:indexPath.row];
            }
            [self.theCheckins removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView reloadData];
    }
    if (indexPath.section == TableViewsectionCheckOut) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            CheckOut *checkOut = [CheckOutController sharedInstance].checkouts[indexPath.row];
            [[CheckOutController sharedInstance]removeCheckOutItem:checkOut];
            [self.theCheckins removeObjectAtIndex:indexPath.row];
            [self.theCheckOuts removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }
        [tableView reloadData];
    }
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CheckinDetailsTableViewController *details = segue.destinationViewController;
        User *user = self.anotherUser;
        details.userDetail = user;
        details.theCheckIn = [CheckInController sharedInstance].checkins[indexPath.row];
        
    }
}

@end
