//
//  ContentView.swift
//  Learning
//
//  Created by Zack Anders on 10/7/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: Contentmodel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
