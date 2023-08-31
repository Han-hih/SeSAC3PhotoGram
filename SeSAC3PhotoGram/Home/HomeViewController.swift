//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/31.
//

import UIKit

protocol A: AnyObject { //class에서만 프로토콜을 사용할 수 있도록 anyobject를 붙여준다.
    func a()
}

//struct B: A {
//    func a() {
//        
//    }
//}

class C: A {
    func a() {
        
    }
}

protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath) 
}


class HomeViewController: BaseViewController {
    
    
    override func loadView() {
        let view = HomeView()
        self.view = view
        view.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
    
}
extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
