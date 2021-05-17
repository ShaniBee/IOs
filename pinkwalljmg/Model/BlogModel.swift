//
//  BlogModel.swift
//  pinkwalljmg
//
//  Created by apple on 08/05/21.
//

import Foundation

struct BlogModel: Codable {
    
    var status : Int?
    var code : Int?
    var message : String?
    var body : [BlogDataModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case status
        case code
        case message
        case body = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
        code = try values.decodeIfPresent(Int.self, forKey: .code) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        body = try values.decodeIfPresent([BlogDataModel].self, forKey: .body) ?? []
    }
}

struct BlogDetailModel: Codable {
    
    var status : Int?
    
    var message : String?
    var body : BlogDataModel?
    
    enum CodingKeys: String, CodingKey {
        
        case status
       
        case message
        case body = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        if let value = try values.decodeIfPresent(BlogDataModel.self, forKey: .body){
            body = value
        }
    }
}

struct BlogDataModel: Codable {
    
    var id : Int?
    var isLiked : Bool?
    var likes :  String?
    var comment_count : String?
    var title : String?
    var post_content : String?
    var blogsMedia : [String]?
    var allMedia : [[String : Any]] = []
    var blogComments : [BlogCommentModel]?
    var video : String?
    var video_url : String?
    var app_content : String?
    var post_date : String?
    enum CodingKeys: String, CodingKey {
        
        case id = "ID"
        case isLiked = "is_like"
        case comment_count
        case likes = "like_count"
        case title = "post_title"
        case blogsMedia = "images"
        case blogComments = "comments"
        case post_content
        case video
        case video_url
        case app_content
        case post_date
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            comment_count = try values.decodeIfPresent(String.self, forKey: .comment_count) ?? ""
            isLiked = try values.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
            title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
            video = try values.decodeIfPresent(String.self, forKey: .video) ?? ""
            video_url = try values.decodeIfPresent(String.self, forKey: .video_url) ?? ""
            
            app_content = try values.decodeIfPresent(String.self, forKey: .app_content) ?? ""
            post_content = try values.decodeIfPresent(String.self, forKey: .post_content) ?? ""
            
            post_date = try values.decodeIfPresent(String.self, forKey: .post_date) ?? ""
            
            likes = try values.decodeIfPresent(String.self, forKey: .likes) ?? ""
            blogsMedia = try values.decodeIfPresent([String].self, forKey: .blogsMedia) ?? []
            blogComments = try values.decodeIfPresent([BlogCommentModel].self, forKey: .blogComments) ?? []
            for i in blogsMedia ?? []{
                allMedia.append(["type":"1","media":i])
            }
            
            if video != ""{
                allMedia.append(["type":"2","media":video ?? ""])
            }
            
            if video_url != ""{
                allMedia.append(["type":"3","media":video_url ?? ""])
            }
            
            
        }catch{
            print(error)
        }
        
    }
}

struct BlogMediaModel: Codable {
    
    var id : Int?
    var mediaType : Int?
    var media : String?
    enum CodingKeys: String, CodingKey {
        
        case id
        case media
        case mediaType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        mediaType = try values.decodeIfPresent(Int.self, forKey: .mediaType) ?? 0
        media = try values.decodeIfPresent(String.self, forKey: .media) ?? ""
    }
}


struct BlogCommentModel: Codable {
    
    var id : String?
    var comment : String?
    var user : String?
    var comment_date :  String?
    enum CodingKeys: String, CodingKey {
        
        case id = "comment_ID"
        case comment = "comment_content"
        case user = "comment_author"
        case comment_date
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        comment = try values.decodeIfPresent(String.self, forKey: .comment) ?? ""
        user = try values.decodeIfPresent(String.self, forKey: .user)
        comment_date = try values.decodeIfPresent(String.self, forKey: .comment_date)
    }
}


struct BlogCommentUserModel: Codable {
    
    var id : Int?
    var name : String?
    var image :  String?
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}


public class MovieFetcher: ObservableObject {
    @Published var blogs = [BlogDataModel]()
    @Published var blogDetail : BlogDataModel?
    
    var nextApiCall : Bool = true
    var firstTimeCall : Bool = true
    var currretPageNumber : Int = 0
    init(){
        
    }
    
    func load(pageNumber: Int) {
        currretPageNumber = currretPageNumber + 1
        SignupEP.blogsListing(page: "\(currretPageNumber)", limit: "\(currretPageNumber * 10)").request(showSpinner: true) { (response) in
            if response != nil {
                guard let obj = response as? BlogModel else {
                    return
                }
                if obj.status == 200{
                    if obj.body?.count ==  (self.currretPageNumber * 10){
                        self.nextApiCall = true
                    }else{
                        self.nextApiCall = false
                    }
                    //if self.currretPageNumber == 1{
                        self.blogs = obj.body ?? []
//                    }else {
//                        self.blogs.append(contentsOf: obj.body ?? [])
//                    }
                    
                }
            }
        } error: { (error) in
            
        }
        
    }
    
    func loadSearch(pageNumber: Int, search : String) {
        currretPageNumber = currretPageNumber + 1
        SignupEP.blogsearch(page: "\(currretPageNumber)", limit: "10", title: search).request(showSpinner: true) { (response) in
            if response != nil {
                guard let obj = response as? BlogModel else {
                    return
                }
                if obj.status == 200{
                    if obj.body?.count ==  10{
                        self.nextApiCall = true
                    }else{
                        self.nextApiCall = false
                    }
                    if self.currretPageNumber == 1{
                        self.blogs = obj.body ?? []
                    }else {
                        self.blogs.append(contentsOf: obj.body ?? [])
                    }
                }
            }
        } error: { (error) in
            
        }
        
    }
    
    func favoriteApi(blogId: Int, indx : Int) {
        
        SignupEP.likeDislikeBlog(blogId: "\(blogId)").request(showSpinner: false) { (response) in
            if response != nil {
                guard let obj = response as? DefaultModel else {
                    return
                }
                let isLike = self.blogs[indx].isLiked
                let totalCount = self.blogs[indx].likes
                if isLike == true{
                    self.blogs[indx].isLiked = false
                    self.blogs[indx].likes = "\((Int(totalCount ?? "0")!) - 1)"
                }else{
                    self.blogs[indx].isLiked = true
                    self.blogs[indx].likes = "\((Int(totalCount ?? "0")!) + 1)"
                }
                
                Toast.shared.showAlert(type: .success, message: obj.message ?? "")
                
            }
        } error: { (error) in
            
        }
    }
    
    
    func BlogDetail(blogId: Int, indx : Int) {
        
        SignupEP.blogDetail(id: "\(blogId)").request(showSpinner: true) { (response) in
            if response != nil {
                guard let obj = response as? BlogDetailModel else {
                    return
                }
                if obj.status == 200{
                    self.blogDetail = obj.body
                    self.blogs[indx] = self.blogDetail!
                    self.blogDetail?.blogComments?.reverse()
                }
            }
        } error: { (error) in
            
        }
    }
    
    func addBlogComment(blogId: Int, indx : Int,comment:String) {
        
        SignupEP.addBlogComment(blogId: "\(blogId)", comment: comment).request(showSpinner: true) { (response) in
            if response != nil {
                guard let obj = response as? DefaultModel else {
                    return
                }
                if obj.status == 201{
                    self.BlogDetail(blogId: blogId, indx: indx)
                }
            }
        } error: { (error) in
            
        }
    }
    
    
    func reportBlogApi(blogId: Int, reportText : String) {
        SignupEP.reportBlog(blogId: "\(blogId)", reportText: reportText).request(showSpinner: false) { (response) in
            if response != nil {
                guard let obj = response as? DefaultModel else {
                    return
                }
               Toast.shared.showAlert(type: .success, message: obj.message ?? "")
                
            }
        } error: { (error) in
            
        }
    }
}
