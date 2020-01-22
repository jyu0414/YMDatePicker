import UIKit

class YMCalendarCell: UICollectionViewCell {
    @IBOutlet weak var number: UILabel!
    var type: DateType = .AvailableDate {
        didSet {
            bgView.isHidden = true
            switch type {
            case .Holiday:
                number.textColor = UIColor.systemRed
                break
            case .Weekday:
                number.textColor = UIColor.label
                break
            case .UnavailableDate:
                number.textColor = UIColor.systemGray3
                break
            case .AvailableDate:
                number.textColor = UIColor.label
                break
            case .SelectedDate:
                number.textColor = UIColor.systemBackground
                bgView.backgroundColor = self.tintColor
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
