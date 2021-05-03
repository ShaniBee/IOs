//
//  BlogDetail.swift
//  pinkwalljmg
//
//  Created by apple on 14/04/21.
//

import SwiftUI

struct BlogDetail: View {
    @Environment(\.presentationMode) var presentationMode
    let data = (1...20).map { "Item \($0)" }
    @State private var commentTextfield = ""
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
            // Navigation View
            HStack(){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                Text("Blog Detail").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
            
            Spacer()
                .frame(height: 20.0)
            List(){
                BlogCell(title: "2",showViewMore: false)
            }
            
            Spacer()
            HStack(){
                Spacer()
                    .frame(width: 20.0)
                TextField("Enter comment..", text: $commentTextfield)
                    .padding(.leading, 20.0)
                    .frame(height: 40.0)
                    .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                    .cornerRadius(20)
                
                Spacer()
                    .frame(width: 10.0)
                Button(action: {
                    
                }) {
                    Image(systemName:"paperplane.circle")
                        .resizable()
                        .frame(maxWidth: 25,
                               maxHeight: 25,
                               alignment: .leading)
                        .accentColor(/*@START_MENU_TOKEN@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                    
                }
                Spacer()
                    .frame(width: 20.0)
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
            
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true))
        
    }
}

struct BlogDetail_Previews: PreviewProvider {
    static var previews: some View {
        BlogDetail()
    }
}


struct CommentCell: View {
    var title = ""
    var showViewMore = true
    @State private var onClickDetail = false
    var body: some View {
        //
        
        VStack(alignment: .leading){
            
            HStack(){
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.all, 4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.red, lineWidth: 1)
                    )
                Text("UserName")
                Spacer()
                //ellipsis
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 25,
                               maxHeight: 25,
                               alignment: .leading)
                    
                    
                }
            }
            
            Divider()
                
          
            Image("s")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    if showViewMore == true{
                        self.onClickDetail = true
                    }
                }
            if showViewMore == true{
                NavigationLink(destination: BlogDetail(), isActive: $onClickDetail) {  }.hidden()
            }
           
            
            HStack(){
                Button(action: {
                    
                }) {
                    HStack(){
                        Image("heart_select")
                            .resizable()
                            .frame(maxWidth: 25,
                                   maxHeight: 25,
                                  alignment: .leading)
                        Text("2")
                    }
                    
                }
                Button(action: {
                    
                }) {
                    HStack(){
                        Image("comment")
                            .resizable()
                            .frame(maxWidth: 25,
                                   maxHeight: 25,
                                  alignment: .leading)
                        Text("2")
                    }
                    
                }
                
                
            }
            HStack(){
                Text("20 Views")
                    .font(.caption)
                if showViewMore == true{
                    Button(action: {
                        
                    }) {
                        Text("View All 234 comment")
                            .font(.caption)
                    }
                }
                
                
                
            }
            
            Spacer()
                .frame(height: 10.0)
        }.navigationBarHidden(true)
        
    }
    
}
