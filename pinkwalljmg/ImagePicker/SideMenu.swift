//
//  SideMenu.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct MenuContent: View {
    @State private var onClickProfile = false
    @State private var onClickTerms = false
    @State var onClickPrivacy = false
    @State var menuOpen: Bool = false
    var body: some View {
        //
        VStack(){
            NavigationLink(destination: ProfileView(), isActive: $onClickProfile) {  }
            NavigationLink(destination: TermsView(), isActive: $onClickTerms) {  }
            NavigationLink(destination: PrivacyView(), isActive: $onClickPrivacy) {  }
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 50.0)
                .frame(width: 150.0, height: 150.0)
            Text("UserName")
            Spacer()
                .frame(height: 30.0)
            List {
                Text("Blog").onTapGesture {
                    print("My Profile")
                    
                }
                Text("My Profile").onTapGesture {
                    print("My Profile")
                    onClickProfile = true
                    
                }
                Text("Terms & Condition").onTapGesture {
                    print("Posts")
                    self.onClickTerms = true
                }
                Text("Privacy Policy").onTapGesture {
                    self.onClickPrivacy = true
                    print("Logout")
                }
                Text("Logout").onTapGesture {
                    print("Logout")
                }
                
            }
        }
        
    }
    func openMenu() {
        self.menuOpen.toggle()
    }
}

struct SideMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            
            HStack {
                MenuContent()
                    .frame(width: self.width)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}
