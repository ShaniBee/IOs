//
//  ProfileView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading){
            // Navigation View
            HStack(){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color("Color_theme"))
                Text("Profile").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center)
            }
            
            ScrollView( showsIndicators: false) {
                Spacer()
                    .frame(height: 30.0)
                HStack(){
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160.0, height: 160.0)
                    Spacer()
                }
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 40,
                    maxHeight: 200,
                    alignment: .top)
            
            List {
                HStack(){
                    Text("Name:")
                        .foregroundColor(Color.black)
                    Spacer().frame(width: 10.0)
                    Text("Rajit Rana").foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                }
                HStack(){
                    Text("Email:")
                        .foregroundColor(Color.black)
                    Spacer().frame(width: 10.0)
                    Text("Rajit@gmail.com ").foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                }
                HStack(){
                    Text("Phone:")
                        .foregroundColor(Color.black)
                    Spacer().frame(width: 10.0)
                    Text("3333").foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                }
                HStack(){
                    Text("Location:")
                        .foregroundColor(Color.black)
                    Spacer().frame(width: 10.0)
                    Text("Mohali").foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(10)
            
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
