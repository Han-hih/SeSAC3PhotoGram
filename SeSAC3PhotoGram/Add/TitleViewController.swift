//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    
    //1. 클로저로 값전달하기 첫번째 단계
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        
    }
    
    deinit {
        print("deinit", self)
    }
    
    @objc func doneButtonClicked() {
        completionHandler?(textField.text!, 77, false)
        navigationController?.popViewController(animated: true)
        
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
        completionHandler?(textField.text!, 100, true)
        
        
    }
    
    
}
