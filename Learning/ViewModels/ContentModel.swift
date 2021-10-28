//
//  ContentModel.swift
//  Learning
//
//  Created by Zack Anders on 10/7/21.
//

import Foundation

class Contentmodel: ObservableObject {
    //list of modules

    @Published var modules = [Module]()
    
    // current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var CodeText = NSAttributedString()
    
    var styleData: Data?
    
    // currewnt selected content and test
    @Published var currentContentSelected:Int?
    
    @Published var currentTestSelected:Int?
    
    init() {
        
        getLocalData()
    }
    
    //MARK: data methods
    
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        // get url to the json file
        
        
        // Read file into  data object
        do {
            /// try to decode json into an array of modules
            let jsonData = try Data(contentsOf: jsonUrl!)
        
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
      
        // assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            
            print("couldnt parse data")
            // TODO Log error
        }
      
        //parse style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        }
        
        catch{
            //log error
            print("couldnt parse style")
        }
        
    }
    
    //MARK: module navigation methods
    
    func beginModule(_ moduleId:Int) {
        
        // find index for this module id
        for index in 0..<modules.count {
           
            if modules[index].id == moduleId {
                
                //found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        // check that lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        // set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        CodeText = addStyling(currentLesson!.explanation)
    }
    func nextLesson() {
        // advance the lesson index
        currentLessonIndex += 1
        
        // check if in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // set current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            CodeText = addStyling(currentLesson!.explanation)
        }
        else {
            // reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId:Int) {
        
        // set the current module
        beginModule(moduleId)
               
               // Set the current question
               currentQuestionIndex = 0
               
               // If there are questions, set the current question to the first one
               if currentModule?.test.questions.count ?? 0 > 0 {
                   currentQuestion = currentModule!.test.questions[currentQuestionIndex]
                   //set the
                   CodeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion() {
        
        // advance the question index
        currentQuestionIndex += 1
        
        
        // check if its within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            CodeText = addStyling(currentQuestion!.content)
        }
        else {
            // if not reset the propertys
            currentQuestionIndex = 0
            currentQuestion = nil
        }
        
    }
    //MARK:: code styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if styleData != nil {
        data.append(styleData!)
        }
        
        // add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
    }
}
