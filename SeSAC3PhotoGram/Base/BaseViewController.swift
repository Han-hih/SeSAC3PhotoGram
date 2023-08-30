//
//  BaseViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit
import SnapKit

//9 import도 옮겨준다. snapkit처럼 모든 뷰컨트롤러에서 사용되는거면 옮겨주면 좋다.
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        
    }
    
//3.
    func configureView() {
        view.backgroundColor = .white
        print("Base ConfigureView")
    }
              
    func setConstraints() {
        print("Base setConstraints")
    }
   

}
