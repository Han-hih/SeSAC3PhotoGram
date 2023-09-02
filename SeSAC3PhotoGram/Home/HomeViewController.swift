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
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    
    let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
//        view.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        APIService.shared.callRequest(query: "sky") { photo in
            guard let photo = photo else {
                print("ALERT ERROR")
                return
            }
            print("API END")
            self.list = photo //네트워크 전후로 데이터가 변경됨.
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()// urlSession에 작성되어 있으면 여기에는 작성해줄 필요가 없다
            }
        }
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


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemBlue
        
        let thumb = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다? >>>>> 네트워크 통신임!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!) // 동기 코드
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         // 뷰에서는 뷰컨트롤러를 띄워줄 수 없다.
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
}
