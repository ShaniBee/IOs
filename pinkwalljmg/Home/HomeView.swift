//
//  HomeView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct HomeView: View {
    @State var menuOpen: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            // Navigation View
            Button(action: {
                self.openMenu()
            },label: { Image(systemName: "line.horizontal.3.decrease") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color("Color_theme"))
            ZStack {
                ScrollView( showsIndicators: false) {
                    
                }
                SideMenu(width: 270,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
            }
            
        }.navigationBarHidden(true)
//        ZStack {
//            if !self.menuOpen {
//                Button(action: {
//                    self.openMenu()
//                }, label: {
//                    Text("Open")
//                })
//            }
//
            
        //}
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
