//
//  HomeView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit
import WebKit

struct HomeView: View {
    @State var menuOpen: Bool = false
    
    @State var CurrentIndex : Int = 0
    @ObservedObject var fetcher = MovieFetcher()
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                
                HStack(){
                    
                    Text("Blog").padding(.trailing, 0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search", text: $searchText,  onEditingChanged: { isEditing in
                            
                            self.showCancelButton = true
                        }, onCommit: {
                            
                            self.fetcher.nextApiCall = true
                            self.fetcher.currretPageNumber = 0
                            self.fetcher.loadSearch(pageNumber: 1, search: searchText)
                            
                            print("onCommit")
                        }).keyboardType(.webSearch)
                        .foregroundColor(.primary)
                        
                        
                        Button(action: {
                            self.fetcher.nextApiCall = true
                            self.fetcher.currretPageNumber = 0
                            self.fetcher.load(pageNumber: 1)
                            
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                            
                            self.fetcher.nextApiCall = true
                            self.fetcher.currretPageNumber = 0
                            self.fetcher.load(pageNumber: 1)
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                    .padding(.horizontal)
                    .navigationBarHidden(showCancelButton)
                
                
                ZStack {
                    VStack(alignment: .leading){
                        List(fetcher.blogs.indices, id: \.self) { index in
                            BlogCell(title: fetcher.blogs[index],showViewMore: true,currentPage: index,fetcher: fetcher)
                                
                                .onAppear {
                                    let s =  fetcher.blogs.last?.id
                                    let d = fetcher.blogs[index].id
                                    if s == d{
                                        if fetcher.nextApiCall{
                                            if searchText == ""{
                                                self.fetcher.load(pageNumber: 4)
                                            }else{
                                                self.fetcher.loadSearch(pageNumber: 4, search: searchText)
                                            }
                                            
                                        }
                                    }
                                }
                            
                            
                        }.onAppear {
                            
                        }
                        
                        Spacer()
                    }
                    //                    SideMenu(width: 270,
                    //                             isOpen: self.menuOpen,
                    //                             menuClose: self.openMenu)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                
            }.navigationBarHidden(true).onAppear(perform: {
                if fetcher.firstTimeCall && fetcher.nextApiCall{
                    fetcher.firstTimeCall = false
                    fetcher.load(pageNumber: 1)
                }
            })
        )
        
        
        
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HeaderCell: View {
    var title : String
    var body: some View {
        VStack() {
            Text("Category \(title)")
                .padding(.all, 10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 2)
                )
        }
    }
}

struct BlogCell: View {
    var title : BlogDataModel
    var showViewMore = true
    var currentPage = 0
    @State private var onClickDetail = false
    @State private var showingActionSheet = false
    @State private var showingSecondActionSheet = false
    @State var activeSheet: ActiveSheet?
    @ObservedObject var fetcher = MovieFetcher()
    @State private var shouldRefresh = true
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
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
                Text(title.title ?? "")
                Spacer()
                //ellipsis
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 25,
                           maxHeight: 25,
                           alignment: .leading).onTapGesture {
                            showingActionSheet = true
                           }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text(""), message: Text("Please select"), buttons: [
                            .default(Text("Report"), action: {
                                Utilities.sharedInstance.reportUser { (value) in
                                    fetcher.reportBlogApi(blogId: title.id ?? 0, reportText: value)
                                }
                                
                            }),
                            .cancel()
                            
                        ])
                        
                    }
            }
            
            //Divider()
            NavigationLink(destination: CommentView(blogId: currentPage, fetcher: fetcher), isActive: $onClickDetail) {  }.hidden()
            
            
            
            ScrollView( title.allMedia.count == 1 ? [] : .horizontal , showsIndicators: false) {
                
                HStack {
                    
                    ForEach(0 ..< title.allMedia.count, id: \.self) { item in
                        
                        
                        if title.allMedia[item]["type"] as! String == "1"{
                            WebImage(url: URL(string: title.allMedia[item]["media"] as! String ))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 40 , height: 450)
                        }else if title.allMedia[item]["type"] as! String == "2"{
                            
                            let  player = AVPlayer(url: URL(string: title.allMedia[item]["media"] as! String )!)
                            
                            VideoPlayer(player: player)
                                .onDisappear(){
                                    player.pause()
                                }
                                .onAppear() {
                                    player.play()
                                }
                                .frame(width: UIScreen.main.bounds.width - 40 , height: 450)
                        }else if title.allMedia[item]["type"] as! String == "3"{
                            
                            //                            Button(action: {
                            //                                            self.shouldRefresh = true
                            //                                        }){
                            //                                            Text("Reload")
                            //                                        }
                            //                                        WebView(url: URL(string: "https://youtu.be/ULji81XJXVU")!, reload: $shouldRefresh).frame(width: UIScreen.main.bounds.width - 40 , height: 450)
                            
                            
                            WebView(request:URLRequest(url: URL(string: title.allMedia[item]["media"] as! String )!))
                                .onDisappear(){
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width - 40 , height: 450)
                        }
                        
                    }
                }
                //  })
                
            }.frame(height : title.allMedia.count == 0 ? 0 :  450)
            
           // let value  = Utilities.sharedInstance.comapreDate(testStr: title.post_date ?? "",firstContect: title.post_content,secondContent: title.app_content)
//            Text( title.post_content)
//                .font(.title3)
//                .lineLimit(4)
            HStack(){
                HStack(){
                    Image( title.isLiked == true ? "heart_select" : "heart-3")
                        .resizable()
                        .frame(maxWidth: 25,
                               maxHeight: 25,
                               alignment: .leading).onTapGesture {
                                fetcher.favoriteApi(blogId: title.id ?? 0, indx: currentPage)
                               }
                    Text("\(title.likes ?? "0")")
                }
                HStack(){
                    Image("comment")
                        .resizable()
                        .frame(maxWidth: 25,
                               maxHeight: 25,
                               alignment: .leading).onTapGesture {
                                onClickDetail = true
                               }
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            HStack(){
                //  Text("20 Views")
                //     .font(.caption)
                
                Text("View All \(title.comment_count ?? "") comment")
                    .font(.caption)
                
                
            }
            
            Spacer()
                .frame(height: 10.0)
        }.navigationBarHidden(true)
        
    }
    
    func placeOrder() { }
}


enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}




struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 568), configuration: webConfiguration)
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
