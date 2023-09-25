//
//  HomeDetail.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 24/09/23.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    var articleData: ArticleDTO
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    KFImage(URL(string: articleData.urlToImage ?? ""))
                        .resizable()
                        .scaledToFit()
                        .progressViewStyle(.circular)
                        .padding([.leading, .trailing], 15)
                        .cornerRadius(20)
                    
                    Text(articleData.author ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .padding([.leading, .trailing, .top], 15)
                    
                    Text(articleData.publishedAt ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .padding([.leading, .trailing, .top], 15)
                    
                    Text(articleData.title ?? "")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                        .padding([.leading, .trailing, .top])
                    
                    
                    Text(articleData.description ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .padding([.leading, .trailing, .top])
                    
                }
                
                Spacer()
            }
            
        }
        .navigationBarTitle(articleData.title ?? "", displayMode: .inline)

    }
}

struct HomeDetail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(articleData: ArticleDTO())
    }
}
