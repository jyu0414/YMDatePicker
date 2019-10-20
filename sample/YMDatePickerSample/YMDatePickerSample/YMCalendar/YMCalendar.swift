import UIKit

@IBDesignable class YMCalendar: UIControl {
    
    @IBOutlet var calendarCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet var toggleButton: UIButton!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var title: UILabel!
    
    @IBInspectable var isMinimum: Bool = true {
        didSet {
            if isMinimum {
                calendarCollectionViewHeight.constant = 70
            }
            else {
                calendarCollectionViewHeight.constant = 216
            }
            calendarCollectionView.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.calendarCollectionView.layoutIfNeeded()
            })
            scrollTo(date: selectedDate)
        }
    }
    
    var rowCount: Int {
        get {
            if isMinimum {
                return 2
            }
            else {
                return 6
            }
        }
    }
    
    var view: UIView!
    
    var selectedDate: Date = Calendar.current.startOfDay(for: Date()) {
        didSet {
            sendActions(for: UIControl.Event.valueChanged)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        instatinateFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instatinateFromNib()
    }
    
    @IBAction func toggleCalendarSize() {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.toggleButton.imageView?.transform = (self.toggleButton.imageView?.transform.rotated(by: CGFloat.pi))!
        })
        self.isMinimum.toggle()
        sendActions(for: UIControl.Event.touchUpInside)
    }
    
    func instatinateFromNib() {
        view = Bundle(for: type(of: self)).loadNibNamed("YMCalendar", owner: self, options: nil)!.first as? UIView
        addSubview(view!)
        view!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view!.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view!.leadingAnchor.constraint(equalTo: leadingAnchor),
            view!.trailingAnchor.constraint(equalTo: trailingAnchor),
            view!.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        title.text = formatter.string(from: selectedDate)
        calendarCollectionView.register(UINib(nibName: "YMCalendarCollectionViewCell", bundle: Bundle(for: type(of: self))),forCellWithReuseIdentifier: "cell")
        calendarCollectionView.allowsSelection = true
    }
}
