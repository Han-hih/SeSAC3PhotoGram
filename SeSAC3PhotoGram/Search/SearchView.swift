//
//  SearchView.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit
import SnapKit
//22 클래스를 만들어주고 서치뷰컨에 있던 것들을 가져와준다.
class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    //26
    //28 register
    //30 Cannot use instance member 'collectionViewLayout' within property initializer; property initializers run before 'self' is available -> lazy var 
    lazy var collectionView = {
        //31 collectionview()를 바꿔야 하는것을 자동으로 알려주지 않는다.
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        //29 Thread 1: "UICollectionView must be initialized with a non-nil layout parameter" -> flowlayout이 없었다
        view.collectionViewLayout = collectionViewLayout()
        return view
    }()
    
    //29
   private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        //33 Negative or zero item sizes are not supported by flow layout. Make a symbolic breakpoint at UICollectionViewFlowLayoutAlertForInvalidItemSize to catch this in the debugger. Invalid size: {-10, -10}; collection view: (null)
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
    override func configureView() {
        addSubview(searchBar)
        //28
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        //28
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
}

