#line 1 "/OnGit/FeiIOS/kanpod/kanpod/kanpod.xm"





#include <substrate.h>
@class MPMediaLibrary; 
static id (*_logos_meta_orig$_ungrouped$MPMediaLibrary$defaultMediaLibrary)(Class, SEL); static id _logos_meta_method$_ungrouped$MPMediaLibrary$defaultMediaLibrary(Class, SEL); static id (*_logos_meta_orig$_ungrouped$MPMediaLibrary$deviceMediaLibrary)(Class, SEL); static id _logos_meta_method$_ungrouped$MPMediaLibrary$deviceMediaLibrary(Class, SEL); static void (*_logos_orig$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$)(MPMediaLibrary*, SEL, id); static void _logos_method$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$(MPMediaLibrary*, SEL, id); static BOOL (*_logos_orig$_ungrouped$MPMediaLibrary$removeItems$)(MPMediaLibrary*, SEL, id); static BOOL _logos_method$_ungrouped$MPMediaLibrary$removeItems$(MPMediaLibrary*, SEL, id); 

#line 6 "/OnGit/FeiIOS/kanpod/kanpod/kanpod.xm"



static id _logos_meta_method$_ungrouped$MPMediaLibrary$defaultMediaLibrary(Class self, SEL _cmd) {
	id gaga = _logos_meta_orig$_ungrouped$MPMediaLibrary$defaultMediaLibrary(self, _cmd);
	NSLog(@"qhk kanpod: defaultMediaLibrary %p", gaga);

	return gaga;
}


static id _logos_meta_method$_ungrouped$MPMediaLibrary$deviceMediaLibrary(Class self, SEL _cmd) {
	id gaga = _logos_meta_orig$_ungrouped$MPMediaLibrary$deviceMediaLibrary(self, _cmd);
	NSLog(@"qhk kanpod: deviceMediaLibrary %p", gaga);
	
	return gaga;
}


static void _logos_method$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$(MPMediaLibrary* self, SEL _cmd, id originalArgument) {
	NSLog(@"-[<MPMediaLibrary: %p> messageWithNoReturnAndOneArgument:%@]", self, originalArgument);

	_logos_orig$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$(self, _cmd, originalArgument);
	
	
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
	
	
	for (i = 0; i < size; i++)
	{
		
		[str appendFormat:@"%s\n", strings[i]];
	}
	
	free (strings);
	NSLog(@"%@", str);
}


static BOOL _logos_method$_ungrouped$MPMediaLibrary$removeItems$(MPMediaLibrary* self, SEL _cmd, id items) {
	print_trace();
	
	BOOL sucess = _logos_orig$_ungrouped$MPMediaLibrary$removeItems$(self, _cmd, items);
	
	NSMutableString* str = [NSMutableString stringWithFormat:@"qhk kanpod: removeItems: %d, %p,%@",sucess, self, NSStringFromClass([items class])];
	
	if ([items isKindOfClass:[NSArray class]])
	{
		NSArray* arr = (NSArray *)items;
		if ([arr count] > 0)
		{
			id anItem = [arr objectAtIndex:0];
			[str appendFormat:@" firstItem %@", NSStringFromClass([anItem class])];




		}
	}
	
	NSLog(@"%@", str);


	return sucess;
}



static __attribute__((constructor)) void _logosLocalCtor_7647966b()
{
	NSLog(@"qhk kanpod: init begin.");
	{{Class _logos_class$_ungrouped$MPMediaLibrary = objc_getClass("MPMediaLibrary"); Class _logos_metaclass$_ungrouped$MPMediaLibrary = object_getClass(_logos_class$_ungrouped$MPMediaLibrary); MSHookMessageEx(_logos_metaclass$_ungrouped$MPMediaLibrary, @selector(defaultMediaLibrary), (IMP)&_logos_meta_method$_ungrouped$MPMediaLibrary$defaultMediaLibrary, (IMP*)&_logos_meta_orig$_ungrouped$MPMediaLibrary$defaultMediaLibrary);MSHookMessageEx(_logos_metaclass$_ungrouped$MPMediaLibrary, @selector(deviceMediaLibrary), (IMP)&_logos_meta_method$_ungrouped$MPMediaLibrary$deviceMediaLibrary, (IMP*)&_logos_meta_orig$_ungrouped$MPMediaLibrary$deviceMediaLibrary);MSHookMessageEx(_logos_class$_ungrouped$MPMediaLibrary, @selector(messageWithNoReturnAndOneArgument:), (IMP)&_logos_method$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$, (IMP*)&_logos_orig$_ungrouped$MPMediaLibrary$messageWithNoReturnAndOneArgument$);MSHookMessageEx(_logos_class$_ungrouped$MPMediaLibrary, @selector(removeItems:), (IMP)&_logos_method$_ungrouped$MPMediaLibrary$removeItems$, (IMP*)&_logos_orig$_ungrouped$MPMediaLibrary$removeItems$);}}





}



