//
//  completionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/29.
//

import UIKit

class CompletionViewController: BaseViewController {
    
    let textField = {
        let field = UITextField()
        field.text = "값을 입력해주세요"
        return field
    }()
    
    var completionHandler: ((String) -> Void)?
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //함수가 들어있다면 실행을 해라
        // 클로저 2.
        completionHandler?(textField.text!)
        
        
    }
    
}
