//
//  HomeView.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 22/09/23.
//

import SwiftUI
import Kingfisher

struct HomeView: View { 
    
    @StateObject var viewModel = HomeViewModel()

    @State private var searchData = ""
    
    @State private var isLoading = false
    
    @StateObject private var networkingMonitor = NetworkMonitor()
    
    var body: some View {
        
        NavigationView {
            VStack() {
                
                SearchBar(text: $searchData).padding([.leading, .trailing])
                    .onChange(of: searchData) { text in
                        viewModel.fetchSearchingResult(text: text)
                    }
                                
                if !networkingMonitor.isActive {
                    Text("No Internet")
                    
                    List(viewModel.fetchFromDatabase(), id: \.id) {  homeData in
                        
                        NavigationLink { DetailView(articleData: homeData) } label: {
                            HStack(spacing: 20) {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(homeData.title ?? "")
                                        .font(.system(size: 18))
                                        .lineLimit(2)
                                    Text(homeData.description ?? "")
                                        .font(.system(size: 16))
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                                
                                KFImage(URL(string: homeData.urlToImage ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 150)
                                    .progressViewStyle(.circular)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                } else {
                    
                    if viewModel.homeDataList.isEmpty {
                        LoadingView()
                            .frame(width: 50, height: 50)
                    }

                    List(viewModel.homeDataList, id: \.id) {  homeData in
                        
                        NavigationLink { DetailView(articleData: homeData) } label: {
                            HStack(spacing: 20) {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(homeData.title ?? "")
                                        .font(.system(size: 18))
                                        .lineLimit(2)
                                    Text(homeData.description ?? "")
                                        .font(.system(size: 16))
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                                
                                KFImage(URL(string: homeData.urlToImage ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 150)
                                    .progressViewStyle(.circular)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear(perform: {
                if networkingMonitor.isActive {
                    viewModel.fetchHomeData()
                }
            })
            .navigationBarTitle("Home", displayMode: .large)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
