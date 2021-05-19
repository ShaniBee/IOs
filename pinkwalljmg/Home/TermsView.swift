//
//  TermsView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    
                    Text("Terms & Condtion").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(.white)
                    
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                WebView(request:URLRequest(url: URL(string: "https://www.jamaicanmateyangroupie.com/terms-and-conditions/" )!))
                    .onDisappear(){
                        
                    }.frame(minWidth: 0, idealWidth: 200, maxWidth: .infinity, minHeight: 20, idealHeight: 300, maxHeight: .infinity, alignment: .center)
                
                
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true)).onAppear(perform: {
                
            })
        
        
    }
    
//    struct HTMLText: UIViewRepresentable {
//
//       let html: String
//        
//        func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
//            let label = UILabel()
//            label.numberOfLines = 0
//            
//            label.attributedText = self.html.htmlToAttributedString
//            
//            
//            return label
//        }
//        
//        func updateUIView(_ uiView: UILabel, context: Context) {
//            uiView.attributedText = self.html.htmlToAttributedString
//        }
//    }
    
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
