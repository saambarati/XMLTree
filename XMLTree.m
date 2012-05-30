//
//  XMLTree.m
//  XMLTree
//
//  Created by Saam Barati on 4/18/12.
//  Copyright (c) 2012 Saam Barati Inc. All rights reserved.
//

#import "XMLTree.h"

@implementation XMLTree

@synthesize root = _root;

-(id)init
{
	if ((self = [super init])) {
		_root = [[XMLNode alloc] init];
		_root.nextSibling = nil;
		_root.tag = @"****XMLTree Root****";
	}

	return self;
}

-(NSString *)treeAsString
{
	return [self.root nodeAsString];
}

#pragma mark Search
-(NSArray *)getNodesWithTag:(NSString *)tag
{
	return [self.root getChildNodesWithTag:tag];
}
-(NSDictionary *)getNodesWithTags:(NSArray *)tags //a dictionary with arrays for each tag
{
	return [self.root getChildNodesWithTags:tags];
}

#pragma mark - Cleanup
-(void)dealloc
{
	[_root release];
	
	[super dealloc];
}

@end
