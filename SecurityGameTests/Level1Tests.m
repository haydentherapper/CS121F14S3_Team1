//
//  SecurityGameTests.m
//  SecurityGameTests
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BGKVLevel1PasswordViewController.h"

@interface Level1Tests : XCTestCase {
    BGKVLevel1PasswordViewController* controller;
}

@end

@implementation Level1Tests

- (void)setUp
{
    [super setUp];
    controller = [BGKVLevel1PasswordViewController alloc];
}

- (void)tearDown
{
    [super tearDown];
}

// Tests checkPassword method for correct password
- (void)testCheckPassword
{
    XCTAssertFalse([controller checkPassword:@"dog"]);
    XCTAssertFalse([controller checkPassword:@"hog"]);
    XCTAssertTrue([controller checkPassword:@"frog"]);
}

@end