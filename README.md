# YMDatePicker
The calendar-style date picker with weekly and monthly mode.

The calendar is weekly mode usually and arranged top of the view. When the user taps the checkmark button, the calendar will expand and change to a monthly mode.

<img src="https://github.com/jyu0414/YMDatePicker/blob/master/sample1.gif?raw=true" alt="demo" width="20%">

## Features
- Provide date picker in calendar style.
- Show calendar weekly or monthly.
- Show in the inputView like UIPickerView.
<img src="https://github.com/jyu0414/YMDatePicker/blob/master/sample2.gif?raw=true" alt="demo" width="20%">

## Installation
Use [CocoaPods](http://cocoapods.org/)...

```
pod 'YMDatePicker', '~> 0.3'
```

You can also add YMDatePicker.xcproj to your project manually.

## Usage

### Storyboard
1. Arrange UIView using a storyboard.
1. Inherit YMDatePicker and also specify it for 'module.'
1. After a while calendar will be displayed on the view.
1. You can connect IBAction to ValueChanged. This event will fire when the date is selected. 

## Contact

- [Yuji Sasaki](https://sasaki.dev) yuji@sasaki.dev
- [Masakaz Ozaki](https://masakaz.com) masakaz@ieee.org

## License

This project is licensed under the mit license.
