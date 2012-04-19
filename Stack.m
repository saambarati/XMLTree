//
//  Stack.m
//  BarcodeScannerPearson
//
//  Created by Saam Barati on 4/16/12.
//  Copyright (c) 2012 Santa Monica College. All rights reserved.
//

#import "Stack.h"

@interface Stack ()

@property (nonatomic, retain) NSMutableArray *stack;

@end

@implementation Stack

@synthesize stack = _stack;

-(id)init
{
	self = [super init];
	
	if (self) {
		self.stack = [NSMutableArray array];
	}
	
	return self;
}

-(NSInteger)count
{
	return [self.stack count];
}

-(void)push:(id)obj
{
	[self.stack addObject:obj];
}

-(id)pop
{
	NSInteger count = [self count];
	if (count) {
		id obj = [[[self.stack objectAtIndex:count - 1] retain] autorelease]; 
		[self.stack removeObjectAtIndex:count - 1];
		return obj;
	} else {
		return nil;
	}
}

-(id)peek
{
	return ([self count] > 0 ? [self.stack objectAtIndex:[self count] - 1] : nil);
}

-(void)applyBlockToAllInStack:(void (^)(id obj))block
{
	for (id obj in _stack) {
		block(obj);
	}
}

-(void)dealloc
{
	[_stack release];
	
	[super dealloc];
}


@end
