import UIKit

@objc
public protocol YMDatePickerDelegate: AnyObject {
    func ymDatePicker(_ datePicker: YMDatePicker, didChange height: CGFloat)
}
