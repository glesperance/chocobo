//
//  CollectionTests.m
//  PetroFeedApp
//
//  Created by Mark on 12/23/2013.
//  Copyright (c) 2013 PetroFeed. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "Collection.h"
#import "Model.h"

SpecBegin(Collection)

describe(@"count:", ^{
    __block Collection *collection;
    __block Model *model1;
    
    beforeEach(^{
        collection = [[Collection alloc] init];
        model1 = [[Model alloc] init];
    });
    
    it(@"count is 0 when first initialized", ^{
        expect([collection modelCount]).to.equal(0);
    });
    
    it(@"count is updated after adding a model", ^{
        [collection addModel:model1];
        expect([collection modelCount]).to.equal(1);
    });
});

describe(@"addModel:", ^{
    __block Collection *collection;
    __block Model *model1;
    
    beforeEach(^{
        collection = [[Collection alloc] init];
        model1 = [[Model alloc] init];
    });
    
    it(@"count is 1 when first initialized", ^{
        [collection addModel:model1];
        expect([collection modelCount]).to.equal(1);
    });
    
    it(@"has the correct model after adding", ^{
        [collection addModel:model1];
        expect([[collection models] objectAtIndex:0]).to.equal(model1);
    });
});

describe(@"clearModels", ^{
    __block Collection *collection;
    __block Model *model1;
    
    beforeEach(^{
        collection = [[Collection alloc] init];
        model1 = [[Model alloc] init];
        
        [collection addModel:model1];
    });
    
    it(@"clears all the models in the collection", ^{
        [collection clearModels];
        expect([collection modelCount]).to.equal(0);
    });
});

SpecEnd
