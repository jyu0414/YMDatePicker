import UIKit

@IBDesignable
open class YMDatePicker: UIControl {
    
    //MARK: Properties
    private var view: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calendar: UICollectionView!
    @IBOutlet private weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var toggleButton: UIButton!
    @IBOutlet public var delegate: YMDatePickerDelegate?
    var isFirstLayout = true
    let numberOfDaysOfWeek = 7
    let minimumHeight: CGFloat = 70
    let maximumHeight: CGFloat = 216
    
    public var selectedDate: Date = Calendar.current.startOfDay(for: Date()) {
        didSet {
            sendActions(for: UIControl.Event.valueChanged)
        }
    }
    
    @IBInspectable public var isMinimum: Bool = true {
        didSet {
            calendarHeightConstraint.constant = calendarHeight
            
            calendar.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.intrinsicHeight = self.controlHeight
                self.layoutIfNeeded()
            }
            scroll(to: selectedDate)
            delegate?.ymDatePicker(self, didChange: controlHeight)
        }
    }
    
    var rowCount: Int {
        get {
            isMinimum ? 2 : 6
        }
    }
    
    var calendarHeight: CGFloat {
        isMinimum ? minimumHeight : maximumHeight
    }
    
    public var controlHeight: CGFloat {
        titleLabel.bounds.height + calendarHeight
    }
    
    public var intrinsicHeight: CGFloat = 70 {
        didSet {
            frame.size.height = intrinsicHeight
            invalidateIntrinsicContentSize()
        }
    }
    
    //MARK: Make from storyboard.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        instantiateFromNib()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    func instantiateFromNib() {
        //Load view from nib.
        guard let bundleFirst = Bundle(for: type(of: self)).loadNibNamed("YMDatePicker", owner: self, options: nil)?.first, let view = bundleFirst as? UIView else {
            assertionFailure("Error: Can't instantiate YMDatePicker")
            return
        }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        self.view = view

        calendar.register(
            UINib(nibName: "YMCalendarCell", bundle: Bundle(for: type(of: self))),
            forCellWithReuseIdentifier: "cell"
        )
        calendar.allowsSelection = true
        
        //TODO:Localization
        //Set initial date.
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMyyyy", options: 0, locale: Locale(identifier: Locale.preferredLanguages.first ?? "en_us"))
        titleLabel.text = formatter.string(from: selectedDate)
    }
    
    @IBAction func toggleCalendarMode() {
        UIView.animate(withDuration: 0.3) {
            self.toggleButton.imageView!.transform = self.toggleButton.imageView!.transform.rotated(by: CGFloat.pi)
        }
        isMinimum.toggle()
        sendActions(for: UIControl.Event.touchUpInside)
    }
    
    override open var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: intrinsicHeight)
    }
}

extension YMDatePicker: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        100
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfDaysOfWeek * rowCount
    }
    
    private func getDate(indexPath: IndexPath) -> Date {
        let line = indexPath.row % rowCount - 1
        let row = indexPath.row / rowCount
        let cal = Calendar.current
        
        let year = cal.component(.year, from: Date())
        var month = cal.component(.month, from: Date())
        if isMinimum {
            let startDay = cal.date(from: DateComponents(year: year, month: month, day: 1))!
            let startDayNumber = cal.component(.weekday, from: startDay) - 1
            return  cal.date(byAdding: .day, value: indexPath.section * numberOfDaysOfWeek + row - startDayNumber, to: startDay)!
        } else {
            month += indexPath.section
            let startDay = cal.date(from: DateComponents(year: year, month: month, day: 1))!
            let startDayNumber = cal.component(.weekday, from: startDay) - 1
            return  cal.date(byAdding: .day, value: line * numberOfDaysOfWeek + row - startDayNumber, to: startDay)!
        }
    }
    
    func scroll(to date: Date) {
        let firstDay = getDate(indexPath: IndexPath(row: 2, section: 0))
        if isMinimum {
           calendar.scrollToItem(at: IndexPath(row: 0, section: Calendar.current.dateComponents([.weekOfMonth], from: firstDay, to: date).weekOfMonth!), at: .left, animated: false)
        } else {
           calendar.scrollToItem(at: IndexPath(row: 0, section: Calendar.current.dateComponents([.month], from: firstDay, to: date).month!), at: .left, animated: false)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! YMCalendarCell
        
        if indexPath.row % rowCount == 0 {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_us")
            cell.number.text = formatter.shortWeekdaySymbols[indexPath.row / rowCount]
            cell.type = indexPath.row / rowCount == 0 ? .Holiday : .Weekday
        } else {
            let cal = Calendar.current
            let targetDate = getDate(indexPath: indexPath)
            cell.number.text = "\(cal.component(.day, from: targetDate))"
            if targetDate == selectedDate {
                cell.type = .SelectedDate
            } else if targetDate <= Date() {
                cell.type = .UnavailableDate
            } else {
                cell.type = .AvailableDate
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / CGFloat(numberOfDaysOfWeek), height: collectionView.frame.height / CGFloat(rowCount))
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = getDate(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMyyyy", options: 0, locale: Locale(identifier: Locale.preferredLanguages.first ?? "en_us"))
        let row = isMinimum ? 2 : 37
        titleLabel.text = formatter.string(from: getDate(indexPath: IndexPath(row: row, section: Int(scrollView.contentOffset.x / scrollView.frame.width))))
    }
}
