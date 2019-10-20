import UIKit
import YMDatePicker

class KeyboardViewController: UIViewController, YMDatePickerDelegate {
    
    let picker = YMDatePicker()
    @IBOutlet weak private var dateLabel: UITextField! {
        didSet {
            dateLabel.inputView = picker
            picker.delegate = self
            picker.addTarget(self, action: #selector(dateSelected(sender:)), for: .valueChanged)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        picker.frame.size.height = picker.controlHeight + view.safeAreaInsets.bottom
    }
    
    func ymDatePicker(_ datePicker: YMDatePicker, didChange height: CGFloat){
        datePicker.frame.size.height = height + view.safeAreaInsets.bottom
        datePicker.intrinsicHeight = height + view.safeAreaInsets.bottom
    }
    
    @objc func dateSelected(sender: YMDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        dateLabel.text =  formatter.string(from: sender.selectedDate)
        dateLabel.resignFirstResponder()
    }
}
