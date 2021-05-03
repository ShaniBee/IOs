//
//  Parser.swift
//  MaidFinder
//
//  Created by Apple on 19/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//


import Foundation
import Moya

extension TargetType {
   
    func parseModel(data: Data) -> Any? {
        
        print(data)
        switch self {
        case is SignupEP:
            let endpoint = self as! SignupEP
            
            switch endpoint {
            case .login(_) :
                return JSONHelper<LoginModel>().getCodableModel(data: data)
            case .forgetpassword(user_email: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .signup(_):
                return JSONHelper<LoginModel>().getCodableModel(data: data)
            }
            
            
            
            default:
                return nil
        }
    }
}
