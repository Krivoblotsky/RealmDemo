//
//  APViewController.m
//  RealmDemo
//
//  Created by Sergii Kryvoblotskyi on 7/17/14.
//  Copyright (c) 2014 Alterplay. All rights reserved.
//

#import "APViewController.h"
#import "RLMFetchedResultsController.h"
#import "APPerson.h"

@interface APViewController () <UITableViewDataSource, UITableViewDelegate, RLMFetchedResultsControllerDelegate>

/*UI*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*Data*/
@property (nonatomic, strong) RLMFetchedResultsController *fetchedResultsController;

@end

@implementation APViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFetchedResultsController];
}

#pragma mark - FRC

- (void)setupFetchedResultsController
{
    self.fetchedResultsController = [[RLMFetchedResultsController alloc] initWithObjectClass:[APPerson class]
                                                                                       realm:[RLMRealm defaultRealm]
                                                                                   predicate:nil];
    self.fetchedResultsController.delegate = self;
}

#pragma mark - Actions
- (IBAction)addButtonClicked:(id)sender
{
    APPerson *person = [APPerson new];
    
    person.firstName = @"John";
    person.lastName = @"Doe";
    person.position = [NSString stringWithFormat:@"Developer"];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:person];
    [realm commitWriteTransaction];
}

#pragma mark - UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    APPerson *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm deleteObject:person];
    [realm commitWriteTransaction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"APPersonCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:reuseIdentifier];
    
    APPerson *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    cell.detailTextLabel.text = person.position;
    return cell;
}

#pragma mark - RLMFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(RLMFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
