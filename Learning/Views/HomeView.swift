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
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("What Do You Want To Do Today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            //learning card
                            VStack (spacing: 20) {
                                
                                NavigationLink(
                                    destination:
                                        ContentsView()
                                        .onAppear(perform: {
                                            model.beginModule(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected) {
                                        //Learning Card
                                        HomeViewRow(image: module.content.image, title: "learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                //test card
                                NavigationLink(
                                    destination:
                                        TestView()
                                        .onAppear(perform: {
                                            model.beginTest(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected) {
                                    // test card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                }
                            
                                NavigationLink (destination: EmptyView()) {
                                    EmptyView()
                                }
                            
                            }
                            .padding(.bottom, 10)
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { changeValue in
                if changeValue == nil {
                    model.currentModule = nil
                }
                    
            }
            .onChange(of: model.currentTestSelected) { changeValue in
                if changeValue == nil {
                    model.currentModule = nil
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Contentmodel())
    }
}
