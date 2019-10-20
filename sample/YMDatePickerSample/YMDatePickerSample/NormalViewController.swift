import UIKit
import YMDatePicker

class NormalViewController: UIViewController {
    
    @IBOutlet private weak var datePicker: YMDatePicker! {
        didSet {
            datePicker.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            datePicker.layer.cornerRadius = 24
            datePicker.layer.shadowColor = UIColor.black.cgColor
            datePicker.layer.shadowOpacity = 0.1
            datePicker.layer.shadowRadius = 20
            datePicker.layer.shadowOffset = CGSize(width: 0, height: 20)
        }
    }
    @IBOutlet private weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func datePickerSelected(sender: YMDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        dateLabel.text =  formatter.string(from: sender.selectedDate) 
    }
}
