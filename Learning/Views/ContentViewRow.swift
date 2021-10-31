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
    
    var lesson: Lesson {
        
        
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        }
        else {
            return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
        }
    }
    
    var body: some View {
        
    
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
