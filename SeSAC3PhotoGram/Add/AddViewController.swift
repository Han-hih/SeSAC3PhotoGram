//
//  ViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework

//1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

//Main과 Detail은 지양하는게 좋다.(여러뷰컨이 생기면 복잡해진다)

//4. uiviewcontroller를 Baseviewcontroller로 바꿔준다.
class AddViewController: BaseViewController {
//19
    let mainView = AddView()
    //20 viewdidload보다 먼저 호출됨, super메소드 호출 x
    override func loadView() {
        self.view = mainView
    }
    
 //1.
//    let photoImageView = {
//        let view = UIImageView()
//        view.backgroundColor = .lightGray
//        view.contentMode = .scaleAspectFill
//        return view
//    }()
//    let searchButton = {
//        let view = UIButton()
//        view.backgroundColor = .systemGreen
//        return view
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
//        ClassInternalExample.internalExample()
        APIService.shared.callRequest()
        
        //37
        
     //2 configure와 constraints는 다른 뷰컨트롤러에서도 계속 반복된다.
        //6 baseViewcontroller에 있어서 자동으로 생성된다.
//        configureView()
//        setConstraints()
        
        //12
        
//        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    //여러번 띄우려면 화면을 띄우는 방식을 바꿔준다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
    }
    //37
    @objc func selectImageNotificationObserver(notification: NSNotification) {
//        print("selectImageNotificationObserver")
//        print(notification.userInfo?["name"])
//        print(notification.userInfo?["sample"])
//        print(#function)
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    
    //12
    @objc func searchButtonClicked() {
        getImageAlert()
        
        //38
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
//        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    //이미지 가져오기 얼럿
    func getImageAlert() {
        let alert = UIAlertController(title: "고르세요", message: nil, preferredStyle: .actionSheet)
        
        let webSearchButton = UIAlertAction(title: "웹에서 찾기", style: .default) { action in
            print("웹에서 찾기")
            UnsplashAPIManager.shared.requestImage(searchBarText: "sky") { image in
                print("_____")
            }
        }
        
        let galleryButton = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { action in
            print("갤러리")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(webSearchButton)
        alert.addAction(galleryButton)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    //5. override
//2 configure, setconstraints
    override func configureView() {
        // 7 super
        super.configureView()
        print("Add ConfigureView")
        //21 mainView에서 가져온다.
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
//        view.addSubview(photoImageView)
//        view.addSubview(searchButton)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.completionButton.addTarget(self, action: #selector(completionButtonClicked), for: .touchUpInside)
        
        
        APIService.shared.callRequest()
        
        
    }
    @objc func completionButtonClicked() {
        let vc = CompletionViewController()
        
        vc.completionHandler = { inho in
            self.mainView.titleButton.setTitle(inho, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        //3. 미리 정의가 되어있다.
        vc.completionHandler = { title, age, bool in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler", age, bool)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        //protocol값전달 5. delgate.self
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
//        photoImageView.snp.makeConstraints { make in
//            make.topMargin.leadingMargin.trailingMargin.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(view).multipliedBy(0.3)
//        }
//        searchButton.snp.makeConstraints { make in
//            make.size.equalTo(50)
//            make.bottom.trailing.equalTo(photoImageView)
//        }
    }
}
// protocol 값 전달 4.
extension AddViewController: PassDataDelegate {
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
