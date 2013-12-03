//
//  Collection.h
//  PetroFeedApp
//
//  Created by Mark on 11/22/2013.
//  Copyright (c) 2013 PetroFeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncObject.h"

@interface Collection : AsyncObject

@property (nonatomic, retain) NSMutableArray *models;

-(id)model;
-(NSString *) collectionEndpoint;
-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void)clearModels;

@end
