
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


%hook MPMediaLibrary

//+ (id)defaultMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: defaultMediaLibrary %p", gaga);
//
//	return gaga;
//}
//
//+ (id)deviceMediaLibrary
//{
//	id gaga = %orig;
//	NSLog(@"qhk kanpod: deviceMediaLibrary %p", gaga);
//	
//	return gaga;
//}

- (void)messageWithNoReturnAndOneArgument:(id)originalArgument
{
	%log;

	%orig(originalArgument);
	
	// or, for exmaple, you could use a custom value instead of the original argument: %orig(customValue);
}

#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

void print_trace (void)
{
	void *array[20];
	size_t size;
	char **strings;
	size_t i;
	
	size = backtrace (array, 20);
	strings = backtrace_symbols (array, size);
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: Obtained %zd stack frames.\n", size];
	//	printf ("Obtained %zd stack frames.\n", size);
	
	for (i = 0; i < size; i++)
	{
		//		printf ("%s\n", strings[i]);
		[str appendFormat:@"%s\n", strings[i]];
	}
	
	free (strings);
	NSLog(@"%@", str);
}

-(BOOL)removeItems:(id)items
{
	print_trace();
	
	BOOL sucess = %orig;
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: removeItems: %d, %p,%@",sucess, self, NSStringFromClass([items class])];
	
	if ([items isKindOfClass:[NSArray class]])
	{
		NSArray* arr = (NSArray *)items;
		if ([arr count] > 0)
		{
			id anItem = [arr objectAtIndex:0];
			[str appendFormat:@" firstItem %@", NSStringFromClass([anItem class])];
//			if ([anItem isKindOfClass:[MPConcreteMediaItem class]])
//			{
//				MPConcreteMediaItem* mediaItem = (MPConcreteMediaItem *)anItem;
//			}
		}
	}
	
	NSLog(@"%@", str);


	return sucess;
}

%end

%hook IUMediaListDataSource

- (BOOL)deleteIndex:(unsigned)index
{
	BOOL sucess = %orig;
	NSLog(@"qhk kanpod: result=%d deleteIndex:%u", sucess, index);
}

%end

%ctor
{
	NSLog(@"qhk kanpod: init begin.");
	%init;
//	currentTransform = CATransform3DIdentity;
//	icons = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
//	notify_register_check("com.apple.springboard.rawOrientation", &notify_token);
//	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, OrientationChangedCallback, CFSTR("com.apple.springboard.rawOrientation"), NULL, CFNotificationSuspensionBehaviorCoalesce);
//	NSLog(@"qhk: IconRotator init end.");
}



