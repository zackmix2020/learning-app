//
//  LearningApp.swift
//  Learning
//
//  Created by Zack Anders on 10/7/21.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(Contentmodel())
        }
    }
}
