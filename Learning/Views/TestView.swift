//
//  TestView.swift
//  Learning
//
//  Created by Zack Anders on 10/23/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: Contentmodel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
                
                // question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // questions
                CodeTextView()
                
                // answers
                
                // buttons
                
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            // test hasnt loaded yet
            ProgressView()
        }

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
