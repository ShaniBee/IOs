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
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? "[]"
    }
}



struct LoginModel: Codable {
    
    var status : Int?
    var message : String?
    var data : LoginDataModel?
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(LoginDataModel.self, forKey: .data)
    }
}

struct LoginDataModel: Codable {
    
    var uid : Int?
    var Authorization : String?
    enum CodingKeys: String, CodingKey {
        
        case uid
        case Authorization
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        uid = try values.decodeIfPresent(Int.self, forKey: .uid) ?? 0
        Authorization = try values.decodeIfPresent(String.self, forKey: .Authorization) ?? ""
    }
}
