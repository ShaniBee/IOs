//
//  TermsView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode) var presentationMode
    let text: String = "here's ddkddkdskl s dkls"
    var body: some View {
        VStack(alignment: .leading){
            // Navigation View
            HStack(){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color("Color_theme"))
                Text("Terms & Condtion").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center)
            }
            
            ScrollView( showsIndicators: false) {
                Text(text).multilineTextAlignment(.leading)
                    .padding(.horizontal, 20.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,alignment: .leading)
                
            }
            
        }.navigationBarHidden(true)
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
