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
            RootViewTwoTypes()
            
            //Memory Leaks?
            //BooleanLanding()  //Leaks
            //SplitViewLanding()  //Doesn't appear to leak
            //EnumSwapLandingView(coordinator: CoordinatorStore())  //Leaks
            
            //How to make a splash page / first time user path for real then? 
            //SplashPathView(navigation: SplashPathCoordinator())  //meh. works alright but mushes concerns together
            //SplashBoolView(navigation: SplashBoolCoordinator())  //bad
            //SplashTVTEView()  //Uses two enums and two views but 1 manager class. so far the favorite.
        }
    }
}
