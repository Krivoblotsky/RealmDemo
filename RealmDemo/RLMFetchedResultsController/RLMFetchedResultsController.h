//
//  RLMFetchedResultsController.h
//  RealmvsCoreData
//
//  Created by Sergii Kryvoblotskyi on 7/16/14.
//  Copyright (c) 2014 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class RLMRealm, RLMObject, RLMArray;

@protocol RLMFetchedResultsControllerDelegate;
@interface RLMFetchedResultsController : NSObject

/**
 Represents the realm
 */

@property (nonatomic, strong, readonly) RLMRealm *realm;

/**
 Represents the predicate
 */

@property (nonatomic, strong, readonly) NSPredicate *predicate;

/**
 FRC delegate
 */
@property (nonatomic, weak) id <RLMFetchedResultsControllerDelegate> delegate;

/**
 Initializer
 */

- (id)initWithObjectClass:(Class)class realm:(RLMRealm *)realm predicate:(NSPredicate *)predicate;

/**
 Returns object at indexPath (actually index)
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns all fetched objects;
 */
- (RLMArray *)fetchedObjects;

@end

@protocol RLMFetchedResultsControllerDelegate <NSObject>
@optional

- (void)controllerDidChangeContent:(RLMFetchedResultsController *)controller;

@end
