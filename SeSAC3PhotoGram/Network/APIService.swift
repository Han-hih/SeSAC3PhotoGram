//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by 황인호 on 2023/08/30.
//

import UIKit

class APIService {
    
     private init() { }
    
    static let shared = APIService() // 인스턴스 생성 방지
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        guard let url = URL(string: ImageApi.requestURL + "\(query)" + ImageApi.clientParam + APIKey.unsplashKey) else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(nil)

                    print(error)
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)

                    print(error) //Alert 또는 Do try Catch 등
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                    
                }
                //
                do {
                    //문제가 생기면 catch문을 타게 된다.
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                    //서버쪽에서 잘못된 것인지 내가 잘못한 것인지 알 수 있다.
                    print(error)  //디코딩 오류 키
                }
            }
        }.resume() //꼭 작성해야한다
    }
    
}


struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
