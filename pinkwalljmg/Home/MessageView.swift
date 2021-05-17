//
//  MessageView.swift
//  pinkwalljmg
//
//  Created by apple on 10/05/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessageView : View {
    var currentMessage: String?
    var image : String?
    var time : String?
    
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            WebImage(url: URL(string: image ?? ""))
                .resizable()
                .placeholder(Image(systemName: "person.crop.circle.fill"))
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
            
            ContentMessageView(contentMessage: currentMessage ?? "",date: time ?? "")
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
       
        //MessageView(currentMessage: Message(content: "There are a lot of premium iOS templates on iosapptemplates.com", user: DataSource.secondUser))
    }
}
