//
//  XMLParserHelper.m
//  BarcodeScannerPearson
//
//  Created by Saam Barati on 4/16/12.
//  Copyright (c) 2012 Santa Monica College. All rights reserved.
//

#import "XMLParserHelper.h"
#import "Stack.h"

//pseudo private properties
@interface XMLParserHelper ()
{
}

@property (nonatomic, copy) void (^callback)(NSError *err, NSDictionary *parsed);
@property (nonatomic, retain) NSError *parseError;
@property (nonatomic, retain) Stack *xmlStack;
@property (nonatomic, retain) XMLTree *xmlTree;

@end


@implementation XMLParserHelper

@synthesize callback = _callback;
@synthesize parseError = _parseError;
@synthesize xmlStack = _xmlStack;
@synthesize xmlTree = _xmlTree;

-(id)init
{
	[NSException raise:@"Private class, cannot initialize" format:@"Logic Error"];
	return nil; //uncreachable, but annoying warning
}
-(id)privateInit
{
	self = [super init];
	
	if (self) {
		_callback = nil;
		_parseError = nil;
		_xmlStack = [[Stack alloc] init];
		_xmlTree = [[XMLTree alloc] init];
		//add the root of the tree to the bottom of the stack, eveyrthing will be built on top of the root
		[_xmlStack push:_xmlTree.root];
	}
	
	return self;
}


/*
	XMLTree uses a stack to populate the data, as new tags are encountered, we pop them onto the stack, and we make 
	them the child of the item before them in the stack. When a tag ends, the stack pops the last item off.
   As incoming xml contents are coming in, we store them in the stacks top item's contents string
 */
+ (void)parseSyncXMLString:(NSString *)xml 
			 withCallback:(void (^)(NSError *err, XMLTree *tree)) cb
{
	[XMLParserHelper parseSyncXMLData:[xml dataUsingEncoding:NSUTF8StringEncoding] withCallback:cb];
}

+ (void)parseSyncXMLData:(NSData *)xml 
		  withCallback:(void (^)(NSError *err, XMLTree *tree)) cb
{
	XMLParserHelper *helper = [[[XMLParserHelper alloc] privateInit] autorelease];

	
	NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xml] autorelease];
	
	//parsing is synchronous
	parser.delegate = helper;
	[parser parse];
	
	cb(helper.parseError, helper.xmlTree);
}
								  



#pragma mark NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName 
   attributes:(NSDictionary *)attributeDict 
{	
	XMLNode *parent = [self.xmlStack peek];
	XMLNode *newNode = [[[XMLNode alloc] init] autorelease];
	newNode.tag = elementName;
	newNode.attributes = attributeDict;
	[parent addChild:newNode];
	[self.xmlStack push:newNode];
	
}

-(void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)string
{
	[((XMLNode *)[self.xmlStack peek]) addIncomingCharacters:string];
}

-(void)parser:(NSXMLParser *)parser 
didEndElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName
{		
//	XMLNode *removal = [self.xmlStack pop];
	[self.xmlStack pop];
	//if any work needs to happen ...
}

//Sent by a parser object to its delegate when it encounters a fatal error.
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)error
{
//	NSLog(@"Encountered fatal XML Parse Error");
	self.parseError = error;
}


+(void)parserTest
{
	NSString *xml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
																	@"<one> hello world"
																		@"<two>childOfOne</two>"
																		@"<two>childOfOne, sibling</two>"
																		@"<two>childOfOne, second sibling</two>"
																		@"<two>"
																			@"<three>child of two</three>"
																			@"<three>"
																				@"<four>child of three</four>"
																			@"</three>"
																			@"<three>child of two, sibling</three>"
																		@"</two>"
																	   @"<two>"
																			@"<three>child of two</three>"
																			@"<three> "
																				@"<four>child of three</four>"
																			@"</three>"
																			@"<three>child of two</three>"
																	  @"</two>"
																	  @"<two></two>"
																	@"</one>"
						  ];
														
	
	[XMLParserHelper parseSyncXMLString:xml
								  withCallback:^(NSError *err, XMLTree *tree) {
									  if (err) {
										  NSLog(@"Error parsing XML:%@", [err localizedDescription]);
									  } else {
										  NSLog(@"%@", [tree treeAsString]);
									  }
								  }];
	
	
}






-(void)dealloc
{
	[_callback release];
	[_xmlStack release];
	[_xmlTree release];
	[_parseError release];
	
	[super dealloc];
}


@end





