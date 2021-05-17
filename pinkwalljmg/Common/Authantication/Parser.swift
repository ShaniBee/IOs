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
            case .editProfile(_):
                return JSONHelper<LoginModel>().getCodableModel(data: data)
            case .forgetpassword(user_email: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .signup(_):
                return JSONHelper<LoginModel>().getCodableModel(data: data)
            case .termsAndConditions, .privacyPolicy:
                return JSONHelper<TermsModel>().getCodableModel(data: data)
            case .changePassword(oldPassword: _, newPassword: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .logout:
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .contactAdmin(requestFor: _, descriptionAboutRequest: _, image: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .blogsListing(page: _, limit: _):
                return JSONHelper<BlogModel>().getCodableModel(data: data)
            case .likeDislikeBlog(blogId: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .reportBlog(blogId: _, reportText: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .blogDetail(id: _):
                return JSONHelper<BlogDetailModel>().getCodableModel(data: data)
            case .addBlogComment(blogId: _, comment: _):
                return JSONHelper<DefaultModel>().getCodableModel(data: data)
            case .blogsearch(page: _, limit: _, title: _):
                return JSONHelper<BlogModel>().getCodableModel(data: data)
            }
            
            
            
            default:
                return nil
        }
    }
}
