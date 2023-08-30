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
    
    func callRequest() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
            let value = String(data: data!, encoding: .utf8)
//            print(value)
//            print(response)
//            print(error)
        }.resume() //꼭 작성해야한다
    }
    
}
