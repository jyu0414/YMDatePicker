//
//  YMDatePicker.swift
//  YMDatePicker
//
//  Created by Yuji Sasaki on 2019/10/20.
//

import UIKit

@IBDesignable
open class YMDatePicker: UIControl {
    
    //MARK: Properties
    private var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var toggleButton: UIButton!
    
    var selectedDate: Date = Calendar.current.startOfDay(for: Date()) {
        didSet {
            sendActions(for: UIControl.Event.valueChanged)
        }
    }
    
    @IBInspectable var isMinimum: Bool = true {
        didSet {
            calendarHeight.constant = isMinimum ? 70 : 216
            calendar.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.calendar.layoutIfNeeded()
            })
            scroll(to: selectedDate)
        }
    }
    
    var rowCount: Int {
        get {
            isMinimum ? 2 : 6
        }
    }

    //MARK: Make from storyboard.
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        instatinateFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instatinateFromNib()
    }
    
    func instatinateFromNib() {
        //Load view from nib.
        guard let view = Bundle(for: type(of: self)).loadNibNamed("YMDatePicker", owner: self, options: nil)?.first as? UIView else {
            fatalError("")
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
        formatter.dateFormat = "yyyy年MM月"
        titleLabel.text = formatter.string(from: selectedDate)
    }
    
    @IBAction func toggleCalendarMode() {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            if let imageView = self.toggleButton.imageView {
                imageView.transform = imageView.transform.rotated(by: CGFloat.pi)
            }
        })
        isMinimum.toggle()
        sendActions(for: UIControl.Event.touchUpInside)
    }

}
