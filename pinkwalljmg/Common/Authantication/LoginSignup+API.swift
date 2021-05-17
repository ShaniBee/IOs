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
    case termsAndConditions
    case privacyPolicy
    case changePassword(oldPassword:String,newPassword:String)
    case signup(user_email:String,user_pass:String,display_name:String,phone:String,username:String,address:String, image : Data)
    case logout
    case contactAdmin(requestFor:String,descriptionAboutRequest:String,image:Data)
    case editProfile(name:String,email:String,countryCode:String,phone:String,address:String,image:Data)
    case blogsListing(page:String,limit:String)
    case likeDislikeBlog(blogId:String)
    case reportBlog(blogId:String,reportText:String)
    case blogDetail(id:String)
    case addBlogComment(blogId:String,comment:String)
    case blogsearch(page:String,limit:String,title:String)
}

extension SignupEP: TargetType {
    var method: Moya.Method {
        switch self {
        case .termsAndConditions, .privacyPolicy, .blogsListing(page: _, limit: _), .blogsearch(page: _, limit: _, title: _):
            return .get
        case  .logout, .blogDetail(id: _):
            return .get
        case .editProfile(name: _, email: _, countryCode: _, phone: _, address: _, image: _):
            return .put
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data("No Data found".utf8)
    }
    
    var task: Task {
        switch self {
        case .signup(_), .contactAdmin(_):
            return .uploadMultipart(multipartBody ?? [])
        case .termsAndConditions, .privacyPolicy, .blogsListing(page: _, limit: _), .logout, .blogDetail(id: _), .blogsearch(page: _, limit: _, title: _):
            return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: self.parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .termsAndConditions, .privacyPolicy, .forgetpassword(user_email: _), .signup(_), .login(_):
            return ["securitykey":ApiConstants.securityKey]
        case .changePassword(oldPassword: _, newPassword: _), .logout, .editProfile(_), .contactAdmin(_), .blogsListing(_), .likeDislikeBlog(blogId: _), .reportBlog(_), .blogDetail(id: _), .addBlogComment(_), .blogsearch(page: _, limit: _, title: _):
            return ["securitykey":ApiConstants.securityKey,"Authorization": "\(UserPreference.shared.data?.token ?? "")"]
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
        case .termsAndConditions: return ApiConstants.termsAndConditions
        case .privacyPolicy: return ApiConstants.privacyPolicy
        case .changePassword: return ApiConstants.changePassword
        case .logout : return ApiConstants.logout
        case .editProfile(_): return ApiConstants.editProfile
        case .contactAdmin(_): return ApiConstants.contactAdmin
        case .blogsListing(page: _, limit: _): return ApiConstants.blogsListing
        case .likeDislikeBlog(blogId: _): return ApiConstants.likeDislikeBlog
        case .reportBlog(blogId: _, reportText: _): return ApiConstants.reportBlog
        case .blogDetail(id: _): return ApiConstants.blogDetail
        case .addBlogComment(_): return ApiConstants.addBlogComment
        case .blogsearch(_): return ApiConstants.blogsearch
        }
    }
    var parameters: [String : Any] {
        switch self {
        
        case .login(let user_email, let user_pass):
            return ["user_email":user_email, "user_pass":user_pass,"deviceType":"1","deviceToken":""]
        case .forgetpassword(let user_email):
            return ["user_email":user_email]
        case .signup(let user_email,let user_pass,let display_name,let phone,let username,let address, _):
            return ["user_email":user_email,"user_pass":user_pass,"display_name":display_name,"phone":phone,"username":display_name,"address":address,"deviceType":"1","deviceToken":"deviceToken"]
        case .termsAndConditions:
            return [:]
        case .privacyPolicy:
            return [:]
        case .changePassword(let oldPassword,let newPassword):
            return ["old_password":oldPassword,"new_password":newPassword]
        case .logout:
            return [:]
        case .editProfile(let name,let email,let countryCode,let phone,let address,_):
            return ["display_name":name,"email":email,"countryCode":countryCode,"phone":phone,"address":address]
        case .contactAdmin(let requestFor,let descriptionAboutRequest, _):
            return ["requestFor":requestFor,"descriptionAboutRequest":descriptionAboutRequest]
        case .blogsListing(let page,let limit):
            return ["page":page,"limit":limit]
        case .likeDislikeBlog(let blogId):
            return ["post_id":blogId]
        case .reportBlog(let blogId,let reportText):
            return ["post_ID":blogId,"comment":reportText]
        case .blogDetail(let id):
            return ["postId":id]
        case .addBlogComment(let blogId,let comment):
            return ["comment_post_ID":blogId,"comment_content":comment]
        case .blogsearch(let page,let limit,let title):
            return ["page":page,"limit":limit,"title":title]
        
        }
    }
    
    
    var multipartBody: [MultipartFormData]? {
        
        switch self {
        case .signup(_, _, _, _, _, _,let image):
            var multipartData = [MultipartFormData]()
            let str = "\(Date().timeIntervalSince1970).jpeg"
            let data = image
            if data.count > 0{
                multipartData.append(MultipartFormData.init(provider: .data(data) , name: "image", fileName: str, mimeType: "image/jpeg"))
            }
            
            
            parameters.forEach( { (key, value) in
                let tempvalue = "\(value)"
                let data = tempvalue.data(using: String.Encoding.utf8) ?? Data()
                multipartData.append(MultipartFormData.init(provider: .data(data), name: key))
                
            })
            return multipartData
            
        case .contactAdmin(_, _, let image):
            var multipartData = [MultipartFormData]()
            let str = "\(Date().timeIntervalSince1970).jpeg"
            let data = image
            if data.count > 0{
                multipartData.append(MultipartFormData.init(provider: .data(data) , name: "image", fileName: str, mimeType: "image/jpeg"))
            }
            
            
            parameters.forEach( { (key, value) in
                let tempvalue = "\(value)"
                let data = tempvalue.data(using: String.Encoding.utf8) ?? Data()
                multipartData.append(MultipartFormData.init(provider: .data(data), name: key))
                
            })
            return multipartData
        
        case .editProfile(_, _, _, _, _,let image):
            var multipartData = [MultipartFormData]()
            let str = "\(Date().timeIntervalSince1970).jpeg"
            let data = image
            if data.count > 0{
                multipartData.append(MultipartFormData.init(provider: .data(data) , name: "image", fileName: str, mimeType: "image/jpeg"))
            }
            
            parameters.forEach( { (key, value) in
                let tempvalue = "\(value)"
                let data = tempvalue.data(using: String.Encoding.utf8) ?? Data()
                multipartData.append(MultipartFormData.init(provider: .data(data), name: key))
                
            })
            return multipartData
        
        default:
            return nil
        }
    }

}

//(user_id: String, req_type : String, year:String, make:String, model:String,vehicle_usage:String,ownership:String,vin:String,miles_covered:String,lic_plate:String,vehicle_id:String)
//email, password
