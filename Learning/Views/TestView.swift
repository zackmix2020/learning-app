//
//  TestView.swift
//  Learning
//
//  Created by Zack Anders on 10/23/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: Contentmodel
    
    @State var selectedAnswerIndex:Int?
    
    @State var submitted = false
    
    @State var numCorrect = 0
   
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack (alignment: .leading) {
                
                // question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // questions
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button {
                                // track the selected index
                                selectedAnswerIndex = index
                                
                            } label: {
                                
                                ZStack {
                                
                                    if submitted == false {
                                    RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                        .frame(height: 48)
                                    }
                                    else {
                                        // answer has been submitted
                                       if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                           // user has selectd the right answer
                                           // show a green background
                                           RectangleCard(color: Color.green)
                                               .frame(height: 48)
                                       }
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            //user selected wrong asnser
                                        //show red background
                                            RectangleCard(color: Color.red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        }
                                        
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                                
                             
                            }
                            .disabled(submitted)
                            
                           
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // submit button
                Button {
                    
                    // change submitted stste to true
                    submitted = true
                    
                    // check thr anserr
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("submit")
                            .bold()
                            .foregroundColor(Color.white)
                        
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
                
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
