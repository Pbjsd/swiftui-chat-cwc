//
//  CreateProfileTextfieldStyle .swift
//  swiftui-chat cwc
//
//  Created by Panchi on 7/25/22.
//

import Foundation
import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>)
    -> some View {
  
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            // This references the textfield 
            configuration
                .font(Font.tabBar)
                .padding()
        }
        
        
    }

}
