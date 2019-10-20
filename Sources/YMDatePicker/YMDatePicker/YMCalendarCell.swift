//
//  YMCalendarCell.swift
//  YMDatePicker
//
//  Created by Yuji Sasaki on 2019/10/21.
//

import UIKit

class YMCalendarCell: UICollectionViewCell {
    @IBOutlet weak var number: UILabel!
    var type: DateType = .AvailableDate {
        didSet {
            bgView.isHidden = true
            switch type {
            case .Holiday:
                number.textColor = UIColor(red: 1, green: 70/255, blue: 70/255, alpha: 1)
                break
            case .Weekday:
                number.textColor = UIColor(red: 45/255, green: 45/255, blue: 44/255, alpha: 1)
                break
            case .UnavailableDate:
                number.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1)
                break
            case .AvailableDate:
                number.textColor = UIColor(red: 77/255, green: 77/255, blue: 96/255, alpha: 1)
                break
            case .SelectedDate:
                number.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                bgView.isHidden = false
                bgView.layer.cornerRadius = frame.height / 2
                bgView.clipsToBounds = true
                break
            }
        }
    }
    @IBOutlet weak private var bgView: UIView!
    
}

enum DateType {
    case Holiday
    case Weekday
    case UnavailableDate
    case AvailableDate
    case SelectedDate
}