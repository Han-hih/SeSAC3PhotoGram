//
//  UnsplashAPIManager.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/30.
//

import UIKit

class UnsplashAPIManager {
    
    
    static let shared = UnsplashAPIManager()
    
    private init() { }
    
  
    
    func requestImage(searchBarText: String, completion: @escaping (Image) -> Void) {
        guard let imageURL = URL(string: ImageApi.requestURL + "\(searchBarText)" + ImageApi.clientParam + APIKey.unsplashKey) else { return }
        print(imageURL)
        let successRange = 200...500
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard error == nil else { return print("Error") }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else { return }
            if let data = data, let imageData = try? JSONDecoder().decode(Image.self, from: data) {
                completion(imageData)
                return
            }
            print("ERRRRRROR")
        }.resume()
        
        
    
    }
    
   
}
