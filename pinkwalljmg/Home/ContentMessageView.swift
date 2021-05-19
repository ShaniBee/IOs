//
//  ContentMessageView.swift
//  pinkwalljmg
//
//  Created by apple on 10/05/21.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var date : String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(contentMessage)
                .padding(5)
                .foregroundColor(Color.black )
                .background( Color.white)
                .cornerRadius(10).frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
            Text(date)
                .font(.body)
                .padding(5)
            
                
        }
        
        
        
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMessageView(contentMessage: "Hi, I am your friend", date: "")
    }
}
