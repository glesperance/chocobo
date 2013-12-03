//
//  Model.h
//  PetroFeedApp
//
//  Created by Mark on 11/15/2013.
//  Copyright (c) 2013 PetroFeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncObject.h"

@interface Model : AsyncObject

-(id) initWithJson:(NSDictionary*)json;
-(void)updateModelWithJson:(NSDictionary *)json;
-(void) addDetailsWithJson:(NSDictionary*)json;

@end
