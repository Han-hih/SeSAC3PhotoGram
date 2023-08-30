//
//  BaseView.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit
import SnapKit

//13
class BaseView: UIView {
    
    //14
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //15
    func configureView() {
        
    }
    
    func setConstraints() {
        
    }
    
    
}
