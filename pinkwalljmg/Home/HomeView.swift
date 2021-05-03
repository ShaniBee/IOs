//
//  HomeView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct HomeView: View {
    @State var menuOpen: Bool = false
    let data = (1...100).map { "Item \($0)" }
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                
                HStack(){
                    Button(action: {
                        self.openMenu()
                    },label: { Image(systemName: "line.horizontal.3.decrease") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    Text("Blog").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                
                ZStack {
                    VStack(alignment: .leading){
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: columns, content: {
                                ForEach(data, id: \.self) { item in
                                    
                                    HeaderCell(title: item)
                                }
                                
                            }).padding(.horizontal, 50.0)
                            .frame(height: 50)
                        }
                        Spacer()
                            .frame(height: 20.0)
                        List{
                            ForEach(data, id: \.self){
                                item in
                                BlogCell(title: item,showViewMore: true)
                            }
                        }
                        Spacer()
                    }
                    
                    
                    
                    SideMenu(width: 270,
                             isOpen: self.menuOpen,
                             menuClose: self.openMenu)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                
            }.navigationBarHidden(true)
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
