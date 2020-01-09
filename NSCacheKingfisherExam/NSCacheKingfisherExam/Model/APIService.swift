//
//  APIService.swift
//  NSCacheKingfisherExam
//
//  Created by youngjun goo on 2019/10/10.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct APIService {
    
    private init() {}
    
    enum APIServiceError: Error {
        case noData
    }
    
    static func fetchData(with path: String, completion: @escaping (Data?, Error?) -> ()) {
        
        let url = URL(string: path)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let unwrapData = data else {
                completion(nil, APIServiceError.noData)
                return
            }
            
            completion(unwrapData, nil)
        
        }.resume()
    }
}
