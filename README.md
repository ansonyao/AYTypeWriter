# AYTypeWriter

[![CI Status](https://img.shields.io/travis/anson/AYTypeWriter.svg?style=flat)](https://travis-ci.org/anson/AYTypeWriter)
[![Version](https://img.shields.io/cocoapods/v/AYTypeWriter.svg?style=flat)](https://cocoapods.org/pods/AYTypeWriter)
[![License](https://img.shields.io/cocoapods/l/AYTypeWriter.svg?style=flat)](https://cocoapods.org/pods/AYTypeWriter)
[![Platform](https://img.shields.io/cocoapods/p/AYTypeWriter.svg?style=flat)](https://cocoapods.org/pods/AYTypeWriter)

## Demo
![Alt Text](https://github.com/ansonyao/AYTypeWriter/blob/master/demo.gif)

## How to use
You can use the AYTypeWriterView class either in code or in IB. 

Pass your text and start the animation:

```swift
typewriterView.label.text = "Hello, AYTypeWriterView 📝"
typewriterView.startAnimation()
typewriterView.delegate = self
```

Customize the appearance of text by using label properies or attributtedString
```swift
/*
Customization 1
*/
typewriterView.label.textColor = primaryColor
typewriterView.label.font = primaryFont

/*
Customization 2
*/
typewriterView.label.attributedText = getAttributedText()
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

AYTypeWriter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AYTypeWriter'
```



## Author

anson, yaoenxin@gmail.com

## License

AYTypeWriter is available under the MIT license. See the LICENSE file for more info.


