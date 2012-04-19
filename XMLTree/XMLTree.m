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
		_root.tag = @"XMLTree Root";
	}
	
	return self;
}

-(void)dealloc
{
	[_root release];
	
	[super dealloc];
}

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

-(NSString *)treeAsString
{
	NSMutableString *string = [NSMutableString string];
	
	[self printInOrderHelper:self.root treeString:string numOfTabs:0];
	
	return string;
}


@end
