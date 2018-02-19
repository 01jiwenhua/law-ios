//
//  UIView+KeyboardAnimation.h
//  WSTextDemo
//
//  Created by kinidchen on 16/1/3.
//  Copyright © 2016年 kinidchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyboardAnimation)

/**
 *  Block which contains user defined animations
 *
 *  @param keyboardRect Finish keyboard frame
 *  @param duration     Duration for keyboard showing animation
 *  @param isShowing    If isShowing is YES we handle keyboard showing, if NO we process keyboard dismissing
 */
typedef void(^WSAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);

/**
 *  Block to handle a start point of animation, could be used for simultaneous animations OR for setting some flags for internal usage.
 *
 *  @param keyboardRect Finish keyboard frame
 *  @param duration     Duration for keyboard showing animation
 *  @param isShowing    If isShowing is YES we handle keyboard showing, if NO we process keyboard dismissing
 */
typedef void(^WSBeforeAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);

/**
 *  Block to handle completion of keyboard animation
 *
 *  @param finished If NO animation was canceled during performing
 */
typedef void(^WSCompletionKeyboardAnimations)(BOOL finished);

/**
 *  Animation block will be called inside [UIView animateWithDuration:::::]
 *
 *  @tip viewWillAppear is the best place to subscribe to keyboard events
 *
 *  @param animations User defined animations. If using auto layout don't forget to call layoutIfNeeded
 *  @param completion User defined completion block, will be called when animation ends
 *
 *  @warning These blocks will he holding inside UIViewController which calls it, so as with any block-style API avoid a retain cycle
 */
- (void)ws_subscribeKeyboardWithAnimations:(WSAnimationsWithKeyboardBlock)animations
                                completion:(WSCompletionKeyboardAnimations)completion;

/**
 *  Animation block will be called inside [UIView animateWithDuration:::::]
 *
 *  @tip viewWillAppear is the best place to subscribe to keyboard events
 *
 *  @param beforeAnimations Preanimation actions should be performed inside this block
 *  @param animations       User defined animations. If using auto layout don't forget to call layoutIfNeeded
 *  @param completion       User defined completion block, will be called when animation ends
 *
 *  @warning These blocks will he holding inside UIViewController which calls it, so as with any block-style API avoid a retain cycle
 */
- (void)ws_subscribeKeyboardWithBeforeAnimations:(WSBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                      animations:(WSAnimationsWithKeyboardBlock)animations
                                      completion:(WSCompletionKeyboardAnimations)completion;

/**
 *
 *  Call it to unsubscribe from keyboard events and clean all animations and completion blocks
 *
 *  @tip viewWillDisappear is the best place to call it
 *
 *  @warning If you will not call it when current view disappeared, subscribed view controller will handle keyboard events on other screens
 */
- (void)ws_unsubscribeKeyboard;

@end
