//
//  Emoticon.m
//  DragDropDemo
//
//  Created by amao on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Emoticon.h"

NSString *kNotificationSelectEmoticon   = @"select_emoticon";
NSString *kEmoticonID                   = @"emoticon_id";
NSString *kSelectEmoticonByDragDrop     = @"select_emoticon_by_drag_drop";

@implementation Emoticon
@synthesize iconIndex;
@synthesize parentView;
@synthesize scrollView;
@synthesize clone;

- (void)dealloc
{
    [self cleanClone];
    [super dealloc];
}

- (void)cleanClone
{
    isDraging = NO;
    scrollView.scrollEnabled = YES;
    [clone removeFromSuperview];
    self.clone = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    scrollView.scrollEnabled = NO;
    isDraging = NO;
    
    //生成自己的clone
    self.clone = [Emoticon getEmoticonFromIndex:iconIndex];
    CGPoint newLocation = [[touches anyObject] locationInView:parentView];
    CGFloat startX = newLocation.x - 128 / 2;
    CGFloat startY = newLocation.y - 128 / 2;
    CGRect rect = CGRectMake(startX, startY, 128, 128);
    [clone setFrame:rect];
    
    [parentView addSubview:clone];
    clone.center = newLocation;
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    isDraging = YES;
    CGPoint newLocation = [[touches anyObject] locationInView:parentView];
    clone.center = newLocation;
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint newLocation  = [[touches anyObject] locationInView:parentView];
    //如果不在当前ScrollView内就认为已经选了
    CGRect scrollViewRect = scrollView.frame;
    if (!CGRectContainsPoint(scrollViewRect, newLocation)) 
    {
		[UIView beginAnimations:@"xxx" context:nil];
		[UIView setAnimationDelay:0.0f];
		[UIView setAnimationDuration:0.2f];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        
		clone.center = CGPointMake(511, 226);
		[UIView commitAnimations];
    }
	else
	{
		[self cleanClone];
	}
}

-(void)animationFinished:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
//    if([animationID isEqualToString:@"adjust_lyric2"])
    {
		[self postNotification:YES];
//        [self performSelector:@selector(cleanClone) withObject:nil afterDelay:0.2f];
		[self cleanClone];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cleanClone];    
    [super touchesCancelled:touches withEvent:event];
}

- (void)onEmotionPressed: (id)sender
{
    if (!isDraging) 
    {
        [self postNotification:NO];
    }

}

- (void)postNotification: (BOOL)drag
{
    NSNumber *emoticonIndex = [[[NSNumber alloc]initWithInt:iconIndex]autorelease];
    NSNumber *isSelectedByDragDrop = [[[NSNumber alloc]initWithBool:drag]autorelease];
    NSDictionary *data = [[[NSDictionary alloc]initWithObjectsAndKeys:emoticonIndex,kEmoticonID,
                            isSelectedByDragDrop,kSelectEmoticonByDragDrop,nil] autorelease];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationSelectEmoticon object:nil userInfo:data];
}

+ (Emoticon *)getEmoticonFromIndex: (int)index
{
    Emoticon *emoticon = [Emoticon buttonWithType:UIButtonTypeCustom];
    NSString *filename = [[NSString alloc]initWithFormat:@"%d.png",index];
    [emoticon setImage:[UIImage imageNamed:filename] forState:UIControlStateNormal];
    emoticon.iconIndex = index;
    [emoticon addTarget:emoticon action:@selector(onEmotionPressed:) forControlEvents:UIControlEventTouchUpInside];
    [filename release];
    return emoticon;
}

@end
