//
//  CommentView.swift
//  pinkwalljmg
//
//  Created by apple on 10/05/21.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit
import WebKit

struct CommentView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var typingMessage: String = ""
    var blogId : Int?
    
    @ObservedObject var fetcher = MovieFetcher()
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    //    init() {
    //            UITableView.appearance().separatorStyle = .none
    //            UITableView.appearance().tableFooterView = UIView()
    //        }
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    
                    Text("Comments").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(.white)
                    
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                ScrollView( showsIndicators: false) {
                    HStack(){
                        
                        
                        Image("blogiconstwo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.all, 4.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        Text(fetcher.blogs[blogId ?? 0].title ?? "")
                        Spacer()
                        //ellipsis
                        
                    }
                    
                    let count  = fetcher.blogs[blogId ?? 0].allMedia.count
                    let screenWidth = UIScreen.main.bounds.width - 40
                  //  let totalWidth = count * screenWidth
                    
                    
                    ScrollView {
                        List {
                            HStack {
                                
                                ForEach(0 ..< count, id: \.self) { item in
                                    
                                    
                                    if fetcher.blogs[blogId ?? 0].allMedia[item]["type"] as! String == "1"{
                                        WebImage(url: URL(string: fetcher.blogs[blogId ?? 0].allMedia[item]["media"] as! String ))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width:screenWidth , height: 450)
                                    }else if fetcher.blogs[blogId ?? 0].allMedia[item]["type"] as! String == "2"{
                                        
                                        let  player = AVPlayer(url: URL(string: fetcher.blogs[blogId ?? 0].allMedia[item]["media"] as! String )!)
                                        
                                        VideoPlayer(player: player)
                                            .onDisappear(){
                                                player.pause()
                                            }
                                            .onAppear() {
                                                player.play()
                                            }
                                            .frame(width: screenWidth , height: 450)
                                    }else if fetcher.blogs[blogId ?? 0].allMedia[item]["type"] as! String == "3"{
                                        
                                        Part3View(urlString : fetcher.blogs[blogId ?? 0].allMedia[item]["media"] as! String)
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                        }.frame(  height : count == 0 ? 0 :  490)
                        
                    }.frame( height : count == 0 ? 0 :  490)
                    
                    Text(fetcher.blogs[blogId ?? 0].post_content ?? "")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    ForEach(fetcher.blogDetail?.blogComments ?? []  , id: \.id) { message in
                        
                        MessageView(currentMessage: "\(message.user ?? ""): \(message.comment ?? "")", image: "", time: "\(message.comment_date ?? "")")
                        //MessageView(currentMessage: msg)
                    }
                    
                    Text("DISCLAIMER The views or opinions appearing on this blog are solely those of their respective authors. In no way do such posts represent the views, opinions or beliefs of Met, or Jamaicanmateyangroupie.com. Met and jamaicangroupiemet.com will not assume liability for the opinions or statements, nor the accuracy of such statements, posted by users utilizing this blog to express themselves. Users are advised that false statements which are defamatory in nature may be subject to legal action, for which the user posting such statements will be personally liable for any damages or other liability, of any nature, arising out of the posting of such statements. Comments submitted to this blog may be edited to meet our format and space requirements. We also reserve the right to edit vulgar language and/or comments involving topics we may deem inappropriate for this web site. *RULES* 1. Debates and rebuttals are allowed but disrespectful curse-outs will prompt immediate BAN 2. Children are never to be discussed in a negative way 3. Personal information eg. workplace, status, home address are never to be posted in comments. 4. All are welcome but please exercise discretion when posting your comments , do not say anything about someone you wouldnt like to be said about you. 5. Do not deliberately LIE on someone here or send in any information based on your own personal vendetta. 6. If your picture was taken from a prior site eg. fimiyaad etc and posted on JMG, you cannot request its removal. 7. If you dont like this forum, please do not whine and wear us out, do yourself the favor of closing the screen- Thanks! . To send in a story send your email to \n:- likeacopcar.78@gmail.com\n\n")
                        .padding(20)
                        .foregroundColor(Color.black )
                        .background( Color.white)
                        .cornerRadius(0 ).frame(minWidth: 0, maxWidth: .infinity,minHeight : 200, maxHeight: .infinity ,alignment: .leading)
                }.padding(.horizontal, 20.0)
                
                
                
                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
                
               
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true)).onAppear(perform: {
                self.fetcher.BlogDetail(blogId: (fetcher.blogs[blogId ?? 0].id ?? 0), indx: blogId ?? 0)
            })
        
        
    }
    
    func sendMessage() {
        if typingMessage == ""{
            Toast.shared.showAlert(type: .validationFailure, message: "Please enter comment")
        }else{
            fetcher.addBlogComment(blogId: (fetcher.blogs[blogId ?? 0].id ?? 0), indx: blogId ?? 0, comment: typingMessage)
            typingMessage = ""
        }
        
    }
}




struct CommentView_Previews: PreviewProvider {
    
    static var previews: some View {
        CommentView(blogId : 0)
        
        //MessageView(currentMessage: Message(content: "There are a lot of premium iOS templates on iosapptemplates.com", user: DataSource.secondUser))
    }
    
}


extension CommentView {
    struct Part3View: View {
        var urlString : String = ""
        var body: some View {
            HStack {
                let youTubeID = urlString.youtubeID ?? ""
                WebView(request:URLRequest(url: URL(string: "https://www.youtube.com/embed/\(youTubeID)?playsinline=1" )!))
                    .onDisappear(){
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 40 , height: 450)
            }
        }
    }
}


//extension CommentView {
//    struct Part4View: View {
//        var urlString : String = ""
//        var body: some View {
//            HStack {
//                ForEach(fetcher.blogDetail?.blogComments ?? []  , id: \.id) { message in
//                    
//                    MessageView(currentMessage: "\(message.user ?? ""): \(message.comment ?? "")", image: "", time: "\(message.comment_date ?? "")")
//                    //MessageView(currentMessage: msg)
//                }
//            }
//        }
//    }
//}
