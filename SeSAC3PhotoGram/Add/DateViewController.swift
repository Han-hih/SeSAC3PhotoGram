//
//  DateViewViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/29.
//

import UIKit

class DateViewController: UIViewController {
    
    let mainView = DateView()
    
    // protocol값 전달2.
    var delegate: PassDataDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func loadView() {
        
        self.view = mainView
    }
    // protocol 값 전달 3.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.receiveDate(date: mainView.picker.date)
    }
}

    


