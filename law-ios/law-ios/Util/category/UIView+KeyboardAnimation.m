//
//  UIView+KeyboardAnimation.m
//  WSTextDemo
//
//  Created by kinidchen on 16/1/3.
//  Copyright © 2016年 kinidchen. All rights reserved.
//

#import "UIView+KeyboardAnimation.h"
#import <objc/runtime.h>

static void *WSAnimationsBlockAssociationKey = &WSAnimationsBlockAssociationKey;
static void *WSBeforeAnimationsBlockAssociationKey = &WSBeforeAnimationsBlockAssociationKey;
static void *WSAnimationsCompletionBlockAssociationKey = &WSAnimationsCompletionBlockAssociationKey;

@implementation UIView (KeyboardAnimation)


#pragma mark public

- (void)ws_subscribeKeyboardWithAnimations:(WSAnimationsWithKeyboardBlock)animations
                                completion:(WSCompletionKeyboardAnimations)completion {
    [self ws_subscribeKeyboardWithBeforeAnimations:nil animations:animations completion:completion];
}

- (void)ws_subscribeKeyboardWithBeforeAnimations:(WSBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                      animations:(WSAnimationsWithKeyboardBlock)animations
                                      completion:(WSCompletionKeyboardAnimations)completion {
    // we shouldn't check for nil because it does nothing with nil
    objc_setAssociatedObject(self, WSBeforeAnimationsBlockAssociationKey, beforeAnimations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, WSAnimationsBlockAssociationKey, animations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, WSAnimationsCompletionBlockAssociationKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // subscribe to keyboard animations
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ws_handleWillShowKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ws_handleWillHideKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)ws_unsubscribeKeyboard {
    // remove assotiated blocks
    objc_setAssociatedObject(self, WSAnimationsBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, WSAnimationsCompletionBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // unsubscribe from keyboard animations
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark private

// ----------------------------------------------------------------
- (void)ws_handleWillShowKeyboardNotification:(NSNotification *)notification {
    [self ws_keyboardWillShowHide:notification isShowing:YES];
}

// ----------------------------------------------------------------
- (void)ws_handleWillHideKeyboardNotification:(NSNotification *)notification {
    [self ws_keyboardWillShowHide:notification isShowing:NO];
}

- (void)ws_keyboardWillShowHide:(NSNotification *)notification isShowing:(BOOL)isShowing {
    // getting keyboard animation attributes
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // getting passed blocks
    WSAnimationsWithKeyboardBlock animationsBlock = objc_getAssociatedObject(self, WSAnimationsBlockAssociationKey);
    WSBeforeAnimationsWithKeyboardBlock beforeAnimationsBlock = objc_getAssociatedObject(self,WSBeforeAnimationsBlockAssociationKey);
    WSCompletionKeyboardAnimations completionBlock = objc_getAssociatedObject(self, WSAnimationsCompletionBlockAssociationKey);
    
    if (beforeAnimationsBlock) beforeAnimationsBlock(keyboardRect, duration, isShowing);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [UIView setAnimationCurve:curve];
                         if (animationsBlock) animationsBlock(keyboardRect, duration, isShowing);
                     }
                     completion:completionBlock];
}

@end
