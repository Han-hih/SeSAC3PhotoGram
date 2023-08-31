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
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let greenView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    deinit {
        print("deinit", self)
    }
    
    func setAnimation() {
        sampleView.alpha = 0
        greenView.alpha = 0
        UIView.animate(withDuration: 1, delay: 2, options: [.curveLinear]) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .blue
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.greenView.alpha = 1
            }
        }
    }
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        view.addSubview(sampleView)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        greenView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view).offset(150)
        }
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
//    override func (_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        //함수가 들어있다면 실행을 해라viewDidDisappear
//        // 클로저 2.
//        completionHandler?(textField.text!)
//
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 1.0
            }
        }
    }

    
}
