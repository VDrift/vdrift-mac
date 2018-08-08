/************************************************************************/
/*                                                                      */
/* This file is part of VDrift.                                         */
/*                                                                      */
/* VDrift is free software: you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation, either version 3 of the License, or    */
/* (at your option) any later version.                                  */
/*                                                                      */
/* VDrift is distributed in the hope that it will be useful,            */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of       */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        */
/* GNU General Public License for more details.                         */
/*                                                                      */
/* You should have received a copy of the GNU General Public License    */
/* along with VDrift.  If not, see <http://www.gnu.org/licenses/>.      */
/*                                                                      */
/************************************************************************/

#import <Cocoa/Cocoa.h>

template <typename T> T VD_CFReleaseIf(T objRef){
	if (NULL != objRef){
		CFRelease(objRef);
	}
	return NULL;
}

char* get_mac_data_dir()
{
    NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    
    NSString    *basePath = [[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
    NSString    *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString    *path;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[resourcePath stringByAppendingString:@"/data/settings/options.config"]])
    {
        path = [resourcePath stringByAppendingString:@"/data"];
    }
    else
    {
        path = [basePath stringByAppendingString:@"/data"];
    }
    
    CFStringRef resolvedPath = nil;
    CFURLRef url = CFURLCreateWithFileSystemPath(NULL, (CFStringRef)path, kCFURLPOSIXPathStyle, true);
    
    if (url != NULL)
    {
        FSRef fsRef;
        
        if (CFURLGetFSRef(url, &fsRef))
        {
            Boolean isFolder, isAlias;
            OSErr oserr = FSResolveAliasFile (&fsRef, true, &isFolder, &isAlias);
            
            if(oserr != noErr)
            {
                NSLog(@"FSResolveAliasFile failed: status = %d", oserr);
            }
            else
            {
                if(isAlias)
                {
                    CFURLRef resolved_url = CFURLCreateFromFSRef(NULL, &fsRef);
                    
                    if (resolved_url != NULL)
                    {
                        resolvedPath = CFURLCopyFileSystemPath(resolved_url, kCFURLPOSIXPathStyle);
                        CFRelease(resolved_url);
                    }
                }
            }
        }
        else // Failed to convert URL to a file or directory object.
        {
            NSApplication *myApplication;
            myApplication = [NSApplication sharedApplication];
            
            NSAlert *theAlert = [NSAlert alertWithMessageText: @"Can't find data"
                                                defaultButton: @"Quit"
                                              alternateButton: nil
                                                  otherButton: nil
                                    informativeTextWithFormat: @"Please make sure a folder named \"data\" is in:\n - the same folder as VDrift.app; or\n - VDrift.app/Contents/Resources"];
            [theAlert runModal];
            
            [pool release];
            exit(1);
        }
    }
    url = VD_CFReleaseIf(url);
    if(resolvedPath != nil)
    {
        path = [NSString stringWithString:(NSString *)resolvedPath];
        CFRelease(resolvedPath);
    }
    
    if ([path canBeConvertedToEncoding:NSUTF8StringEncoding])
    {
        int len = [path lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        char* cpath = (char*) malloc(len + 2);
        
        [path getCString:cpath maxLength:len + 1 encoding:NSUTF8StringEncoding];
        cpath[len] = '\0';
        
        [pool release];
        
        return cpath;
    }
    else
    {
        NSApplication *myApplication;
        myApplication = [NSApplication sharedApplication];
        
        NSAlert *theAlert = [NSAlert alertWithMessageText: @"Can't find data"
                                            defaultButton: @"Quit"
                                          alternateButton: nil
                                              otherButton: nil
                                informativeTextWithFormat: @"Please move VDrift to a sane location on your computer, without weird characters in it's path!"];
        
        [theAlert runModal];
        
        [pool release];
        exit(1);
    }
}
