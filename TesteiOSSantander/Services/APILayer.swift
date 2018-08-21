//
//  APILayer.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation
import Alamofire

class APILayer {
    fileprivate static func get<T: Codable>(_ url: String, model: T.Type, onSuccess: @escaping (T?) -> Void, onFailure: ((Error) -> Void)? = nil) {
        guard let _url = URL(string: url) else {
            return
        }
        
        request(_url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    return
                }
                
                do {
                    let resultObjc = try JSONDecoder().decode(model, from: data)
                    onSuccess(resultObjc)
                } catch {
                    onFailure?(error)
                }
            case .failure(let error):
                onFailure?(error)
            }
        }
    }
}

extension APILayer: NetworkLayer {
    func getCells(onSuccess: @escaping (Form?) -> Void, onFailure: @escaping (Error) -> Void) {
        APILayer.get("\(Constants.Url.API.rawValue)/cells.json", model: Form.self, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getFund(onSuccess: @escaping (Fund?) -> Void, onFailure: @escaping (Error) -> Void) {
        APILayer.get("\(Constants.Url.API.rawValue)/fund.json", model: Fund.self, onSuccess: onSuccess, onFailure: onFailure)
    }
}
