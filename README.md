# XMLTree

If you're like me and  are the unfortunate recipient of some XML data, XMLTree could help you parse through it in an easier manner. 
XMLTree is a lightweight set of classes that will parse XML and populate it into a native tree object.
XMLTree isn't heavily tested against, so make sure to write in some tests if you decide to use it.

## API

#### Passing an NSString
	
	
    [XMLParserHelper parseAsyncXMLString:xmlAsAString
                           withCallback:^(NSError *err, XMLTree *tree) {
                                           if (err) {
                                              NSLog(@"Error parsing XML:%@", [err localizedDescription]);
                                           } else {
                                              NSLog(@"%@", [tree treeAsString])
                                           }
                                       }];
					

#### Passing NSData (essentially the same method call)

    [XMLParserHelper parseAsyncXMLData:xmlAsData
                         withCallback:^(NSError *err, XMLTree *tree) {
                                         if (err) {
                                            NSLog(@"Error parsing XML:%@", [err localizedDescription]);
                                         } else {
                                            NSLog(@"%@", [tree treeAsString])
                                         }
                                     }];

#### Notes
All parsing is done asynchronously on a separate thread. When parsing is completed, the callback will fire from the Main Thread.

XMLTree relies on Grand Central Dispatch and uses the method `dispatch_async(dispatch_get_main_queue(), ...)`. This method
doesn't work unless you have a `UIApplication` or `NSApplication` because there is no `dispatch_get_main_queue()`.
