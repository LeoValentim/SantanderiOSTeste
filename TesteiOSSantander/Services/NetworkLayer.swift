//
//  NetworkLayer.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    func getCells(onSuccess: @escaping (Form?) -> Void, onFailure: @escaping (Error) -> Void)
    func getFund(onSuccess: @escaping (Fund?) -> Void, onFailure: @escaping (Error) -> Void)
}
