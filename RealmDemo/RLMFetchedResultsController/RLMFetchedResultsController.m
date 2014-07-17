//
//  RLMFetchedResultsController.m
//  RealmvsCoreData
//
//  Created by Sergii Kryvoblotskyi on 7/16/14.
//  Copyright (c) 2014 Alterplay. All rights reserved.
//

#import "RLMFetchedResultsController.h"

@interface RLMFetchedResultsController ()

/**
 Fetched results container
 */

@property (nonatomic, strong, readonly) RLMArray *fetchedResults;

/**
 Update notification token
 */

@property (nonatomic, strong, readonly) RLMNotificationToken *notificationToken;

@end

@implementation RLMFetchedResultsController

- (id)initWithObjectClass:(Class)class realm:(RLMRealm *)realm predicate:(NSPredicate *)predicate
{
    self = [super init];
    if (self) {
        _realm = realm;
        _predicate = predicate;
        
        //@TODO: Maybe refactor it somehow?
        _fetchedResults = [(id)class performSelector:@selector(objectsInRealm:withPredicate:)
                                          withObject:realm
                                          withObject:predicate];
        
        /*Save token for handling furhter updates
         and cleanup*/
        __weak RLMFetchedResultsController *weakSelf = self;
        _notificationToken = [_realm addNotificationBlock:^(NSString *notification, RLMRealm *realm)
        {
            [weakSelf notifyContentChanged];
        }];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [self.realm removeNotification:self.notificationToken];
}

#pragma mark - Private

- (void)notifyContentChanged
{
    if ([self.delegate respondsToSelector:@selector(controllerDidChangeContent:)]) {
        [self.delegate controllerDidChangeContent:self];
    }
}

#pragma mark - Public

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResults objectAtIndex:indexPath.row];
}

- (RLMArray *)fetchedObjects
{
    return self.fetchedResults;
}

@end
