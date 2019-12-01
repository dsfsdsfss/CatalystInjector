//
//  main.m
//  CatalystInjector
//
//  Created by henry on 11/26/19.
//  Copyright © 2019 machport. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (!(argv[1] == NULL)) {
                
            if (strcmp( argv[1], "-h") == 0) {
                printf("OPTIONAL USAGE: catalyst <<bundle id>> <<dylib>\n");
                exit(0);
            } else if (strcmp( argv[1], " ") == 0) {
                
            } else {
                if(!(argv[2] == NULL)) {
                    NSLog(@"Using Manual Mode");
                    NSString *command = [[[[@"(/Users/Shared/Catalyst/Mject " stringByAppendingString:[NSString stringWithUTF8String:argv[1]] ] stringByAppendingString:@" " ] stringByAppendingString:[NSString stringWithUTF8String:argv[2]] ] stringByAppendingString:@") &"];
                    system([command UTF8String]);
                    NSLog(@"Done Injecting 🥳");
                    exit(0);
                }
            }
        }
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:@"/Users/Shared/Catalyst"]) {
            system("mkdir /Users/Shared/Catalyst; curl https://hlmoore.github.io/utils/Mject > /Users/Shared/Catalyst/Mject 2>/dev/null; chmod +x /Users/Shared/Catalyst/Mject");
            NSLog(@"Done With Setup");
            exit(0);
        }
        NSArray *contents = [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:@"/Users/Shared/Catalyst/"] includingPropertiesForKeys:NULL options:NSDirectoryEnumerationSkipsHiddenFiles error:NULL];
        for (NSURL* injdir in contents) {
            NSString *filename = [injdir lastPathComponent];
            if (![[injdir absoluteString ] containsString:@".dylib"]) {
                if ([[injdir pathExtension]  isEqual: @"bun"]) {
                    
                } else {
                    
                }
            } else if ([[injdir absoluteString ] containsString:@".dylib"]) {
                NSString *filewex = [[[[[injdir.relativePath stringByDeletingLastPathComponent] stringByAppendingString:@"/"] stringByAppendingString:filename ] stringByDeletingPathExtension]  stringByAppendingString:@".bun"];
                NSString *bundleid = [NSString stringWithContentsOfFile:filewex encoding:NSUTF8StringEncoding error:NULL];
                if ([fileManager fileExistsAtPath:filewex]) {
                    NSString *command = [[[[@"(/Users/Shared/Catalyst/Mject " stringByAppendingString:bundleid ] stringByAppendingString:@" "] stringByAppendingString:injdir.relativePath ] stringByAppendingString:@") &"];
                    if (!(argv[1] == NULL)) {
                        if (strcmp( argv[1], "-l") == 0) {
                            NSLog(@"Bundle ID: %@", bundleid);
                        }
                    }
                    if (argv[1] == NULL) {
                        system([command UTF8String]);
                        NSLog(@"Done Injecting 🥳");
                    }
                }
            
            }
        }
    }
    return 0;
}
