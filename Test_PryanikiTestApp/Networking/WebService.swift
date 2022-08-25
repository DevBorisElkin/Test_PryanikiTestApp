//
//  WebService.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation
import Alamofire

class WebService{
    
    static func executeUrl<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (T?, Error?) -> Void) -> Void {
        
        guard let url = URL(string: urlString) else {
            completion(nil, NetworkingErrors.badUrl(urlString: urlString))
            return
        }
        
        Alamofire.request(url).validate().response { response in
            if let error = response.error{
                completion(nil, error)
            }else if let data = response.data{
                do{
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(data, nil)
                }catch{
                    completion(nil, error)
                }
            }
        }
    }
}

enum NetworkingErrors: Error {
    case badUrl(urlString: String)
}
