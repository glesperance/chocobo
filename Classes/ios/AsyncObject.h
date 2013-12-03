//
//  AsyncObject.h
//  PetroFeedApp
//
//  Created by Mark on 11/22/2013.
//  Copyright (c) 2013 PetroFeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AsyncObject : NSObject

-(void) fetchFromEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void) getFromEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(NSString*) endPoint;

@end
