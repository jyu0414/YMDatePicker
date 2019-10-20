//
//  YMDatePickerDelegate.swift
//  YMDatePicker
//
//  Created by Yuji Sasaki on 2019/10/21.
//
import UIKit

@objc
public protocol YMDatePickerDelegate {
    func ymDatePicker(_ datePicker: YMDatePicker, didChange height: CGFloat)
}
