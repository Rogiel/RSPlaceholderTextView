//
//  RSPlaceholderTextView.m
//  RSPlaceholderTextView
//
//  Created by Rogiel Sulzbach on 12/23/13.
//  Copyright (c) 2013 Rogiel Sulzbach. All rights reserved.
//

#import "RSPlaceholderTextView.h"

@implementation RSPlaceholderTextView

-(id)init {
    self = [super init];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        // Initialization code
        [self doInit];
    }
    return self;
}

-(void)awakeFromNib {
    [self doInit];
}

/**
 * Inits the view, sets the default placeholder text color and register for UITextViewTextDidChangeNotification notifications
 */
-(void)doInit {
    self.placeholderTextColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    // redraw view
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    // redraw view
    [self setNeedsDisplay];
}

-(void)textViewDidChange:(NSNotification*)notification {
    // redraw view
    [self setNeedsDisplay];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    // Inset the rect
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (self.typingAttributes) {
        NSParagraphStyle *style = self.typingAttributes[NSParagraphStyleAttributeName];
        if (style) {
            rect.origin.x += style.headIndent;
            rect.origin.y += style.firstLineHeadIndent;
        }
    }
    
    return rect;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // Drawing code
    if (self.text.length == 0 && self.placeholder) {
        NSDictionary* attributes = @{NSFontAttributeName: self.font,
                                     NSForegroundColorAttributeName: self.placeholderTextColor};
        
        rect = self.textInputView.frame;
        CGSize size = [self.placeholder sizeWithAttributes:attributes];
        
        float yOffset = (rect.size.height - size.height) /2;
        
        // Draw the text
        [self.placeholderTextColor set];
        [self.placeholder drawInRect:CGRectMake(rect.origin.x+5,  rect.origin.y + yOffset, size.width, size.height) withAttributes:attributes];
    }
}

-(void)dealloc {
    // unregister from all notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
