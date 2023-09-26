//
//  BusinessView.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 22/09/23.
//

import SwiftUI
import Kingfisher

struct BusinessView: View {
    @StateObject var businessModel = BusinessViewModel()
    
    var body: some View {
        
        NavigationView {
           
            
            VStack() {
                
                if businessModel.businessDataList.isEmpty {
                    LoadingView()
                        .frame(width: 50, height: 50)
                }
                
                List(businessModel.businessDataList, id: \.id) { businessData in
                    
                    NavigationLink { DetailView(articleData: businessData) } label: {
                        HStack(spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(businessData.title ?? "")
                                    .font(.system(size: 18))
                                    .lineLimit(2)
                                Text(businessData.description ?? "No Description")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            
                            KFImage(URL(string: businessData.urlToImage ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 150)
                                .progressViewStyle(.circular)
                            
                            if businessData.urlToImage == nil {
                                Text("No Image")
                            }
                        }
                    }
                }
                
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: { businessModel.fetchSportData()})

            
            .navigationBarTitle("Business", displayMode: .large)
        }
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView()
    }
}
