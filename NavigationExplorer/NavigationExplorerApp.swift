//
//  NavigationExplorerApp.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import SwiftUI

@main
struct NavigationExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            //Exploring how view persistence / identity works
            //RootView()
            
            //Memory Leaks?
            BooleanLanding()  //Leaks
            //SplitViewLanding()  //Doesn't appear to leak
            //EnumSwapLandingView(coordinator: CoordinatorStore())  //Leaks
            
            //How to make a splash page / first time user path for real then? 
            //SplashPathView(navigation: SplashPathCoordinator())
            //SplashBoolView(navigation: SplashBoolCoordinator())
        }
    }
}
