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
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    //23
    let mainView = SearchView()
    //34
    var imageList: [String] = []

    
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
    
    func imageRequest(searchText: String) {
        UnsplashAPIManager.shared.requestImage(searchBarText: searchText) { response in
//            print(response.results)
            self.imageList.removeAll()
            for item in response.results {
                let url = item.urls.regular
                self.imageList.append(url)
                print(self.imageList,"2222222222 ")
//                self.imageList.append()
            }
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
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
        guard let searchText = searchBar.text else { return}
        imageRequest(searchText: searchText)
        mainView.searchBar.resignFirstResponder() // 사용자의 포커스가 서치바에 없다.
    }
}

//32
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageList.count,"ddddddd")
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let url = URL(string: imageList[indexPath.item])
            
        cell.imageView.load(url: url!)
        
        return cell
    }
    
    
    //35
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(imageList[indexPath.item])
        
        //protocol
//        delegate?.receiveImage.(image: )
        
        //36 notification을 통한 값전달
      //  NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item],"sample": "고래밥"])
        
        dismiss(animated: true)
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
