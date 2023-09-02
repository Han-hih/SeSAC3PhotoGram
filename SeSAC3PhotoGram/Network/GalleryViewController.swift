//
//  GalleryViewController.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/31.
//

import UIKit
import Photos

// MARK: - PHPicker로 바꿔보기

class GalleryViewController: UIViewController {
    
    var delegate: PassGalleryImageDelegate?
    
    let imagePicker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
        //            print("갤러리 사용 불가, 사용자에게 토스트/ 얼럿")
//                    return
                
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)

    }
  
        
}
extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            delegate?.receiveGalleryImage(image: image)
            dismiss(animated: true)
            
        }
        
    }
    
    // 취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}
