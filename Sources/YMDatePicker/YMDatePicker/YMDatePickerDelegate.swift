import UIKit

@objc
public protocol YMDatePickerDelegate {
    func ymDatePicker(_ datePicker: YMDatePicker, didChange height: CGFloat)
}
