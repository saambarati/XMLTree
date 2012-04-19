# XMLTree

If you're like me and  are the unfortunate recipient of some XML data, XMLTree could help you parse through it in an easier manner. 
XMLTree is a lightweight set of classes that will parse XML and populate it into a native tree object.
XMLTree isn't heavily tested against, so make sure to write in some tests if you decide to use it.

## API

#### Passing an NSString
	
	
    [XMLParserHelper parseSyncXMLString:xmlAsAString
                           withCallback:^(NSError *err, XMLTree *tree) {
                                           if (err) {
                                              NSLog(@"Error parsing XML:%@", [err localizedDescription]);
                                           } else {
                                              NSLog(@"%@", [tree treeAsString])
					   }
					}];
					
	
#### Passing NSData (essentially the same method call)

    [XMLParserHelper parseSyncXMLData:xmlAsData
                         withCallback:^(NSError *err, XMLTree *tree) {
                                         if (err) {
                                            NSLog(@"Error parsing XML:%@", [err localizedDescription]);
                                         } else {
                                            NSLog(@"%@", [tree treeAsString])
                                         }
                                      }];
