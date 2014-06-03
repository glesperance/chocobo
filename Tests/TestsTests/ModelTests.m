//
//  ModelTests.m
//  Tests
//
//  Created by Gabriel Lesperance on 2014-06-03.
//  Copyright (c) 2014 Gabriel Lesperance. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "Collection.h"
#import "Model.h"

SpecBegin(Model)

describe(@"general:", ^{
    __block Model *model;
    
    beforeEach(^{
        Collection * collection = [[Collection alloc] init];
        model = [[Model alloc] init];
        [collection addModel:model];
    });
    
    it(@"should have a valid pointer to its collection even when collection is no longer referenced", ^{
        expect(model.collection).notTo.beNil();
    });
});

SpecEnd

