//
//  SearchBar.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 23/09/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "text.magnifyingglass")
            
            TextField("Search", text: $text)
                .frame(height: 35)
                .font(.system(size: 18))
                .padding(.trailing, 20)
            
            Spacer(minLength: 0)
            
            if !text.isEmpty {
                
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(Color(UIColor.systemGray))
                        .frame(width: 8, height: 8)
                        .background(Circle().foregroundColor(Color(UIColor.systemGray2)).frame(width: 16, height: 16))
                }
                
            }
            
        }
        .padding(5)
        .padding([.leading, .trailing], 6)
        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color(UIColor.systemGray6)))
        .frame(maxWidth: .infinity)
    }
}
