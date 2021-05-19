//
//  TermsModel.swift
//  pinkwalljmg
//
//  Created by apple on 07/05/21.
//

import Foundation


struct TermsModel: Codable {
    
    var status : Bool?
    var code : Int?
    
    var message : String?
    var body : TermsDataModel?
    enum CodingKeys: String, CodingKey {
        
        case status
        case code
        case message
        case body
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Bool.self, forKey: .status) ?? false
        code = try values.decodeIfPresent(Int.self, forKey: .code) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        body = try values.decodeIfPresent(TermsDataModel.self, forKey: .body)
    }
}

struct TermsDataModel: Codable {
    
    var title : String?
    var content : String?
    enum CodingKeys: String, CodingKey {
        
        case title
        case content
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}
