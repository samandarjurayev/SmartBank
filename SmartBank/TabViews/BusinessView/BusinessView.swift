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
                
                if businessModel.sportDataList.isEmpty {
                    LoadingView()
                        .frame(width: 50, height: 50)
                }
                
                List(businessModel.sportDataList, id: \.id) { sportData in
                    
                    NavigationLink { DetailView(articleData: sportData) } label: {
                        HStack(spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(sportData.title ?? "")
                                    .font(.system(size: 18))
                                    .lineLimit(2)
                                Text(sportData.description ?? "")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            
                            KFImage(URL(string: sportData.urlToImage ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 150)
                                .progressViewStyle(.circular)
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
