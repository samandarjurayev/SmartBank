//
//  ContentView.swift
//  SmartBank
//
//  Created by Samandar Jurayev on 21/09/23.
//

import SwiftUI




struct ContentView: View {
    
    
    var body: some View {
        
        TabView {
            
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            BusinessView().tabItem {
                Label("Business", systemImage: "dollarsign.square")
            }
            
            SportView().tabItem {
                Label("Sport", systemImage: "soccerball")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
