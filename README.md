[![Open Source at IFTTT](http://ifttt.github.io/images/open-source-ifttt.svg)](http://ifttt.github.io)

![jot Logo](./Docs/jotbanner.jpg)

[![CocoaPods Version](https://img.shields.io/cocoapods/v/jot.svg)](http://cocoadocs.org/docsets/jot) [![Build Status](https://travis-ci.org/IFTTT/jot.svg?branch=master)](https://travis-ci.org/IFTTT/jot) [![Coverage Status](https://coveralls.io/repos/IFTTT/jot/badge.svg?branch=master)](https://coveralls.io/r/IFTTT/jot?branch=master)

`jot` is an easy way to add touch-controlled drawings and text to images in your iOS app.

![FastttCamera](./Docs/jot-demo.gif)

## What's `jot` for?
### Annotating Images
`jot` is the easiest way to add annotations to images with a touch interface. You can draw arrows or circle important things, as well as add resizable, rotatable text captions, and easily save the notes on top of a image using `drawOnImage:`.

### Whiteboard or Drawing Apps
`jot` is perfect for quick sketches and notes in your whiteboard or drawing app. It's easy to change the drawing color or stroke width, and when you're done, you can call `renderImageOnColor:` to save the sketch.

### Signatures
`jot` is a great solution if you need to collect user signatures through a touch interface. Set the `drawingColor` to black, set the state to `JotViewStateDrawing`, and save the signature when the user is done by calling `renderImageOnColor:`.

## Installation

`jot` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```
pod "jot"
```

## Example Project

To run the example project, clone the repo, and run `pod install` from the `Example` directory.

## Usage

Add an instance of `JotView` as a child of your view controller. Adjust the size and layout of `JotView `'s view however you'd like.

```objc
#import "ExampleViewController.h"
#import <jot/jot.h>

@interface ExampleViewController ()
@property (nonatomic, strong) JotView *jotView;
@end

@implementation ExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _jotView = [JotView new];
    self.jotView.delegate = self;
    
    [self addChildViewController:self.jotView];
    [self.view addSubview:self.jotView];
    [self.jotView didMoveToParentViewController:self];
    self.jotView.frame = self.view.frame;
}
```
Switch between drawing, text manipulation, and text edit mode.

```objc
- (void)switchToDrawMode
{
	self.jotView.state = JotViewStateDrawing;
}

- (void)switchToTextMode
{
	self.jotView.state = JotViewStateText;
}

- (void)switchToTextEditMode
{
	self.jotView.state = JotViewStateEditingText;
}
```
Clear the drawing.

```objc
// Clears text and drawing
[self.jotView clearAll];

// Clears only text
[self.jotView clearText];

// Clears only drawing
[self.jotView clearDrawing];
```

### Image Output

Draw on a background image.

```objc
- (UIImage *)imageWithDrawing
{
	UIImage *myImage = self.imageView.image;
	return [self.jotView drawOnImage:myImage];
}
```

Draw on a color.

```objc
- (UIImage *)imageOnColorWithDrawing
{
	UIColor *backgroundColor = self.view.backgroundColor;
	return [self.jotView renderImageOnColor:backgroundColor];
}
```

Draw on a transparent background.

```objc
- (UIImage *)imageOnColorWithDrawing
{
	UIColor *backgroundColor = self.view.backgroundColor;
	return [self.jotView renderImage];
}
```

### Basic Configuration

#### Text Settings

Change the font.

```objc
self.jotView.font = [UIFont boldSystemFontOfSize:64.f];
```
Change the font size.

```objc
self.jotView.fontSize = 64.f;
```
Change the text color.

```objc
self.jotView.textColor = [UIColor redColor];
```
Set the initial text string.

```objc
self.jotView.textString = @"Hello World";
```

#### Drawing Settings

Change the drawing stroke color.

```objc
self.jotView.drawingColor = [UIColor magentaColor];
```
Change the drawing stroke width.

```objc
self.jotView.drawingStrokeWidth = 10.f;
```
Make the drawing stroke a constant width, instead of the default dynamically variable width.

```objc
self.jotView.drawingConstantStrokeWidth = YES;
```

### Advanced Configuration

#### Text Settings

Set the text to wrap to the width of the view.

```objc
self.jotView.fitOriginalFontSizeToViewWidth = YES;
```
Set the text alignment (only applies if text is set to wrap).

```objc
self.jotView.textAlignment = NSTextAlignmentRight;
```
Set the text insets (only applies if text is set to wrap).

```objc
self.jotView.initialTextInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
```
Set the text editing insets.

```objc
self.jotView.textEditingInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
```
Set the text edit view to clip text to the text editing insets (instead of fading out with a gradient).

```objc
self.jotView.clipBoundsToEditingInsets = YES;
```

## Contributors

* [Laura Skelton](https://github.com/lauraskelton), creator.

## License

`jot` is available under the MIT license. See the LICENSE file for more info.

Copyright 2015 IFTTT Inc.
