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

-(NSString *)contentsOfChildWithTag:(NSString *)tag
{
  for (XMLNode *child in _children) {
    if ([child.tag caseInsensitiveCompare:tag] == NSOrderedSame) {
      return child.contents;
    }
  }
  return nil;
}

#pragma mark - Search

-(void)tagRecursiveHelper:(NSMutableArray *)arr tag:(NSString *)atag node:(XMLNode *)node 
{
	if (node != nil) {
		if ([node.tag isEqualToString:atag]) {
			[arr addObject:node];
		}
		NSArray *children = [node children];
		for (XMLNode *child in children) {
			[self tagRecursiveHelper:arr tag:atag node:child];
		}
  }
}
-(NSArray *)getChildNodesWithTag:(NSString *)tag
{
	NSMutableArray *tagsArr = [NSMutableArray array];
	[self tagRecursiveHelper:tagsArr tag:tag node:self];
	
	return (NSArray *)tagsArr;
}


//O(n), n = number of tags in tree
-(void)tagsRecursiveHelper:(NSMutableDictionary *)dict node:(XMLNode *)node
{
	if (node != nil) {
		NSMutableArray *tags = [dict objectForKey:node.tag];
		if (tags) {
			[tags addObject:node];
		}
		NSArray *children = [node children];
		for (XMLNode *child in children) {
			[self tagsRecursiveHelper:dict node:child];
		}
	}
}

-(NSDictionary *)getChildNodesWithTags:(NSArray *)tags //a dictionary with arrays for each tag
{
	NSMutableDictionary *allTags = [NSMutableDictionary dictionary];
	for (NSString *tag in tags) {
		[allTags setObject:[NSMutableArray array] forKey:tag];
	}
	
	[self tagsRecursiveHelper:allTags node:self];
	
	return (NSDictionary *)allTags;
}

#pragma mark - Pretty Print

#define TAB_SIZE 2
-(void)printInOrderHelper:(XMLNode *)currNode treeString:(NSMutableString *)tree numOfTabs:(int)tabs
{
	//tabs represents depth into tree
	if (currNode != nil) {
		[tree appendString:@"\n"];
		for (int i = 0; i < tabs * TAB_SIZE; i+=1) {
			[tree appendString:@" "];
		}
		[tree appendString:[NSString stringWithFormat:@"<%@> ",currNode.tag]]; 
		if ([currNode contents]) { [tree appendString:[currNode contents]]; }
		
		if ([currNode.children count]) {
			for (XMLNode *aChild = [currNode.children objectAtIndex:0]; aChild != nil; aChild = aChild.nextSibling) { //in order, depth first
				[self printInOrderHelper:aChild treeString:tree numOfTabs:tabs + 1];
			}
			//once all children are printed, print closing tag
			[tree appendString:@"\n"];
			for (int i = 0; i < tabs * TAB_SIZE; i+=1) {
				[tree appendString:@" "];
			}
			[tree appendString:[NSString stringWithFormat:@"</%@> ",currNode.tag]];
		} else {
			//if no children, print end tag
			[tree appendString:[NSString stringWithFormat:@" </%@> ",currNode.tag]]; 
		}
	}
}

-(NSString *)nodeAsString
{
	NSMutableString *string = [NSMutableString string];
	
	[self printInOrderHelper:self treeString:string numOfTabs:0];
	
	return string;
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
