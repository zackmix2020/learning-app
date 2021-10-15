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
    
    var styleData: Data?
    
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
    
    func beginModule( moduleid:Int) {
        
        // find index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                //found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
    
}
