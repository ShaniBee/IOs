//
//  Html.swift
//  pinkwalljmg
//
//  Created by apple on 07/05/21.
//

import SwiftUI
struct PlacePicker: View {
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    @State var location: String = ""
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
                
                PlacePicker()
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true))
        
        
    }
    
    
    
}

struct PlacePicker_Previews: PreviewProvider {
    static var previews: some View {
        PlacePicker()
    }
}








