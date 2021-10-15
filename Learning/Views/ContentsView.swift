//
//  ContentsView.swift
//  Learning
//
//  Created by Zack Anders on 10/13/21.
//

import SwiftUI

struct ContentsView: View {
    
    @EnvironmentObject var model: Contentmodel
    
    var body: some View {
       
        ScrollView {
            
            LazyVStack {
                
                // confirm that current module is set
                
                if model.currentModule != nil {
                    
                
                
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        ContentViewRow(index: index)
        
                }
                }
                    
                }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            }
            
        }
        
    }

