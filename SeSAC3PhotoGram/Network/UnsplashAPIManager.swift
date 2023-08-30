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
        
        let successRange = 200...299
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard error == nil else { return print("Error") }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else { return }
            print(statusCode)
            
            guard let imageData = data else { return }
            print(imageData)
            do {
                let response = try JSONDecoder().decode(Image.self, from: imageData)
                completion(response)
                
            } catch let error {
                print(error)
            }
            
            print("ERRRRRROR")
        }.resume()
        
        
    
    }
    
   
}
