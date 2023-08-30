//
//  DateView.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/29.
//

import UIKit

class DateView: BaseView {
    let picker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
    return picker
    }()
    
    override func configureView() {
        super.configureView()
        
        backgroundColor = .white
        addSubview(picker)
    }
    
    override func setConstraints() {
        super.setConstraints()
        picker.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}

