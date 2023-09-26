//
//  SportView.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 22/09/23.
//

import SwiftUI
import Kingfisher

struct SportView: View {
    @StateObject var sportModel = SportViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack() {
                
                if sportModel.sportDataList.isEmpty {
                    LoadingView()
                }
                
                List(sportModel.sportDataList, id: \.id) { sportData in
                    
                    NavigationLink { DetailView(articleData: sportData) } label: {
                        HStack(spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(sportData.title ?? "")
                                    .font(.system(size: 18))
                                    .lineLimit(2)
                                Text(sportData.description ?? "No Description")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            
                            KFImage(URL(string: sportData.urlToImage ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 150)
                                .progressViewStyle(.circular)
                            
                            if sportData.urlToImage == nil {
                                Text("No Image")
                            }
                        }
                    }
                }
                
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: { sportModel.fetchSportData()})

            .navigationBarTitle("Sport", displayMode: .large)
            
        }
    }
}

struct SportView_Previews: PreviewProvider {
    static var previews: some View {
        SportView()
    }
}
