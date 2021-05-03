//
//  LoginSignup+API.swift
//  InsureTika
//
//  Created by keshav kumar on 31/01/20.
//  Copyright © 2020 keshav kumar. All rights reserved.
//

import Foundation
import Moya

enum SignupEP {
    case login(user_email : String,user_pass : String)
    case forgetpassword(user_email:String)
    case signup(user_email:String,user_pass:String,display_name:String,phone:String,username:String,address:String)
}

extension SignupEP: TargetType {
    var method: Moya.Method {
        switch self {
            default:
                return .post
        }
    }
    
    var sampleData: Data {
        return Data("No Data found".utf8)
    }
    
    var task: Task {
        switch self {
       
        default:
            return .requestParameters(parameters: self.parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        
        default:
            return nil
        }
    }
    
    var baseURL : URL{
        return URL(string: ApiConstants.baseURL)!
    }
    ////email, phone_number, country_code
    var path: String{
        switch self {
        
        case .login(_): return ApiConstants.login
        case .forgetpassword(user_email: _): return ApiConstants.forgetpassword
        case .signup(_): return ApiConstants.signup
        }
    }
    var parameters: [String : Any] {
        switch self {
        
        case .login(let user_email, let user_pass):
            return ["user_email":user_email, "user_pass":user_pass]
        case .forgetpassword(let user_email):
            return ["user_email":user_email]
        case .signup(let user_email,let user_pass,let display_name,let phone,let username,let address):
            return ["user_email":user_email,"user_pass":user_pass,"display_name":display_name,"phone":phone,"username":username,"address":address]
        
        }
    }
    

}

//(user_id: String, req_type : String, year:String, make:String, model:String,vehicle_usage:String,ownership:String,vin:String,miles_covered:String,lic_plate:String,vehicle_id:String)
//email, password
