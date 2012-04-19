//
//  XMLNode.m
//  XMLTree
//
//  Created by Saam Barati on 4/18/12.
//  Copyright (c) 2012 Saam Barati Inc. All rights reserved.
//

#import "XMLNode.h"

@interface XMLNode ()
{
	NSMutableArray *_children;
	NSMutableString *_contents;
}
@end

@implementation XMLNode

@synthesize nextSibling = _nextSibling;
@synthesize tag = _tag;
@synthesize attributes = _attributes;

-(id)init
{
	if ((self = [super init])) {
		_tag = nil;
		_children = [[NSMutableArray alloc] init];
		_nextSibling = nil;
		_attributes = nil;
		_contents = [[NSMutableString alloc] init];
	}
	
	return self;
}



-(void)addChild:(XMLNode *)node
{
	NSInteger count = [_children count];
	if (count) {
		XMLNode *prev = [_children objectAtIndex:(count - 1)];
		prev.nextSibling = node;
	}
	[_children addObject:node];
}

-(NSArray *)children
{
	return [[_children copy] autorelease];
}

-(NSString *)contents
{
	return [[_contents copy] autorelease];
}

//used when xml is being parsed
-(void)addIncomingCharacters:(NSString *)s
{
	[_contents appendString:s];
}

-(void) dealloc
{
	[_tag release];
	[_children release];
	[_attributes release];
	[_contents release];
	
	[super dealloc];
}

@end
