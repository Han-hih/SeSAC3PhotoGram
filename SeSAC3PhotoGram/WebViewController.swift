//
//  WebViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //네비게이션 컨트롤러가 처음에 투명, 스크롤 하면 불투명
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        
        //scrollEdge로 쓰면 처음에는 나오지만 스크롤하면 없어짐
        //standard를 쓰면 처음에 안나오고 스크롤하면 생김
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        title = "이건 웹뷰입니다"
        
        
    }
    
    func reloadButtonClicked() {
        webView.reload() //새로고침에 관한 기능
    }
    
    func goBackButtonClicked() {
        //뒤로 갈 수 있는 상황인지 확인
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
