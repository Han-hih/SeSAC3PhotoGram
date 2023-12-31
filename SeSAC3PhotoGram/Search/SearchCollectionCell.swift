//
//  SearchCollectionCell.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/28.
//

import UIKit

//27
class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    
    
    
}
