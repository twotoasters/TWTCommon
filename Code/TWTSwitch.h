//
//  TWTSwitch.h
//
//  Created by Duane Homick
//  Homick Enterprises - www.homick.com
//
//  The TWTSwitch can be used the same way a UISwitch can, but using the PSD attached, you can create your own color scheme.

#import <UIKit/UIKit.h>

@protocol TWTSwitchDelegate;

@interface TWTSwitch : UIControl 
{
	id<TWTSwitchDelegate> _delegate;
	BOOL _on;

	NSInteger _hitCount;
	UIImageView* _backgroundImage;
	UIImageView* _switchImage;
}

@property (nonatomic, assign, readwrite) id delegate;
@property (nonatomic, getter=isOn) BOOL on;

- (id)initWithFrame:(CGRect)frame;              // This class enforces a size appropriate for the control. The frame size is ignored.

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end

@protocol TWTSwitchDelegate

@optional
- (void)valueChangedInView:(TWTSwitch*)view;

@end

