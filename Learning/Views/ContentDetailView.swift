//
//  ContentDetailView.swift
//  Learning
//
//  Created by Zack Anders on 10/15/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: Contentmodel
    
    var body: some View {
        
        
        let lesson = model.currentLesson
       let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
            VStack {
            // only show video if we get a valid url
            if url != nil {
           VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // TODO: Description
            
            // Show next lesson button, only if their is a next lesson
                if model.hasNextLesson() {
                    Button(action: {
                        //action for next
                        model.nextLesson()
                        
                    }, label: {
                        
                        ZStack {
                            
                            Rectangle()
                                .frame(height:48)
                                .foregroundColor(Color.green)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        
                        Text("Next Lesson \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    })
                }
               
        }
            .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
