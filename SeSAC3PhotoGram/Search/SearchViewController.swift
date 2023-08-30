//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit

//10
class SearchViewController: BaseViewController {
//11
//    let searchBar = {
//        let view = UISearchBar()
//        view.placeholder = "검색어를 입력해주세요"
//        return view
//    }()
    //23
    let mainView = SearchView()
    
    //34
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]

    
    var delegate: PassImageDelegate?
    //24
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addObservier보다 post가 먼저 신호를 보내면 addObserver가 신호를 받지 못한다.
        // post와 addobserver 순서
        //39
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver(notification:)), name: NSNotification.Name("RecommandKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder() // 처음 들어갈 때부터 키보드가 떠서 커서가 깜빡인다.
        mainView.searchBar.delegate = self
        
        
    }
    
    
    //39
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print("recommandKeywordNotificationObserver")
    }

    
    //10
    override func configureView() {
        super.configureView()
//        view.addSubview(searchBar)
        
        //32
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    
    
//    override func setConstraints() {
//        super.setConstraints()
//        searchBar.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview()
//        }
//    }

}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder() // 사용자의 포커스가 서치바에 없다.
    }
}

//32
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    
    //35
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageList[indexPath.item])
        
        //protocol
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.row])!)
        
        //36 notification을 통한 값전달
      //  NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item],"sample": "고래밥"])
        
        dismiss(animated: true)
    }
    
}



