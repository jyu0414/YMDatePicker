//
//  ViewController.swift
//  YMDatePickerSample
//
//  Created by Masakaz Ozaki on 2019/10/20.
//  Copyright © 2019 Masakaz Ozaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var ymDatePicker: YMCalendar!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ymDatePicker.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ymDatePicker.layer.cornerRadius = 24
        ymDatePicker.layer.shadowColor = UIColor.black.cgColor
        ymDatePicker.layer.shadowOpacity = 0.1
        ymDatePicker.layer.shadowRadius = 20
        ymDatePicker.layer.shadowOffset = CGSize(width: 0, height: 20)
    }
}
