//
//  APPerson.h
//  RealmDemo
//
//  Created by Sergii Kryvoblotskyi on 7/17/14.
//  Copyright (c) 2014 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface APPerson : RLMObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *position;

@end
