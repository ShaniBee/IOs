//
//  DefaultModel.swift
//  pinkwalljmg
//
//  Created by apple on 26/04/21.
//

import Foundation



struct DefaultModel: Codable {
    
    var status : Int?
    var message : String?
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}





struct LoginModel: Codable {
    
    var status : Int?
    var message : String?
 //   var code : Int?
    var data : LoginDataModel?
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
       // case code
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
       // code = try values.decodeIfPresent(Int.self, forKey: .code) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(LoginDataModel.self, forKey: .data)
    }
}



struct LoginDataModel: Codable {
    
    var id : String?
    var name : String?
    var email : String?
    var image :  String?
    var countryCode : String?
    var phone : String?
    var address : String?
    var token : String?
    var display_name : String?
    enum CodingKeys: String, CodingKey {
        case name = "user_login"
        case id = "ID"
        case email = "user_email"
        case image
        case countryCode
        case phone
        case address
        case token = "Authorization"
        case display_name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        phone = try values.decodeIfPresent(String.self, forKey: .phone) ?? ""
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? ""
        display_name = try values.decodeIfPresent(String.self, forKey: .display_name) ?? ""
    }
}
