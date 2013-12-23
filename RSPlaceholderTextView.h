//
//  RSPlaceholderTextView.h
//  RSPlaceholderTextView
//
//  Created by Rogiel Sulzbach on 12/23/13.
//  Copyright (c) 2013 Rogiel Sulzbach. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This is a drop-in replacement for a UITextView that allows placeholders just like a UITextField does. The view only removes the placeholder when a text has been entered.
 *
 * This class can be used with Inteface Builder, here as the steps to do so:
 *
 *      - Add a UITextView
 *
 *      - Go to "Identity Inspector"
 *
 *      - Change the class type to RSPlaceholderTextView
 *
 *      - To set the placeholder and placeholder text color, create a new "User defined runtime attribute" as "placeholder" or "placeholderTextColor"
 *
 * You can set the delegate as usual and everything works like it should!
 *
 * @author Rogiel Sulzbach <http://www.rogiel.com/>
 *
 */
@interface RSPlaceholderTextView : UITextView<UITextViewDelegate>

/**
 * The placeholder to be used
 */
@property (strong, nonatomic) NSString* placeholder;

/**
 * The placeholder text color
 */
@property (strong, nonatomic) UIColor*  placeholderTextColor;

@end