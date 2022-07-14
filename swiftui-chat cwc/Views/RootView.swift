//
//  RootView.swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/4/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    var body: some View {
        
        VStack {
            
        Text("Hello, world!")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
       
            CustomTabBar(selectedTab: $selectedTab)
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
