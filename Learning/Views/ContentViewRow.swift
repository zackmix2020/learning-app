//
//  ContentViewRow.swift
//  Learning
//
//  Created by Zack Anders on 10/15/21.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: Contentmodel
    var index:Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
    
    // lesson card
        ZStack (alignment: .leading) {
        
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height: 66)
        
        HStack (spacing: 30) {
            
            Text(String(index + 1))
                .bold()
            
            VStack (alignment: .leading) {
                
                Text(lesson.title)
                Text(lesson.duration)
            }
        }
        .padding()
    }
        .padding(.bottom, 5)
    }
}
