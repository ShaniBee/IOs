//
//  TabBarView.swift
//  pinkwalljmg
//
//  Created by apple on 04/05/21.
//

import SwiftUI

struct TabBarView: View {
    init(){
        UITabBar.appearance().barTintColor = UIColor.init(named: "Color_theme")
    }
    var body: some View {
        NavigationView{
            TabView{
                HomeView()
                    .tabItem {
                        Image("ic_home")
                        
                        Text("Blogs")
                    }
                    .tag(1)
                ProfileView()
                    .tabItem {
                        Image("ic_profile")
                        
                        Text("Account")
                    }
                    .tag(2)
                
            }.accentColor(.white)
        }.navigationBarHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
