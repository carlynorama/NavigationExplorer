//
//  SplashPage_OnePathTwoEnum.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/8/22.
//

import Foundation
import SwiftUI

enum AppSceneTvTe:Hashable {
    case setup
    case app
}

enum PathTvTeOptions: Hashable {
    case optionA(OptionAVM)
    case optionB(OptionBVM)
}


struct SplashTVTEView: View {
    @StateObject var oneCoordinator = CoordinatorTvTe()
    
    var body: some View {
        NavigationStack(path: $oneCoordinator.path) {
            splash
                .navigationDestination(for: AppSceneTvTe.self) { scene in
                switch scene {
                case .app:
                    SplashTvTeAppRootView().environmentObject(oneCoordinator)
                    let a = print("Three Times?")
                default:
                    splash
                }
                
            }
        }
    }
    
    var splash: some View {
        VStack {
            Text("Splash Page")
            Button(action:navigateToApp) {
                Text("Go App Root")
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func navigateToApp() {
        oneCoordinator.showStack()
    }
}


final class CoordinatorTvTe: ObservableObject {
    @Published var path = NavigationPath()

    //init could load state - see deep linking examples. 
    
    func showA() {
        path.append(PathTvTeOptions.optionA(OptionAVM()))
    }
    
    func showB() {
        path.append(PathTvTeOptions.optionB(OptionBVM()))
    }
    
    func showInitial() {
        unwindAll()
        //path = NavigationPath()
    }
    
    func showStack() {
        path = NavigationPath()
        path.append(AppSceneTvTe.app)
    }
    
    func unwindAll() {
        while !path.isEmpty {
            path.removeLast()
        }
    }
}


struct SplashTvTeAppRootView: View {
    @EnvironmentObject var navigation: CoordinatorTvTe

    init() {
        print("SubView Init")
    }
    
    var body: some View {
      
            VStack {
                Text("Real Root")
            }
            .onAppear() {
                print("Appear")
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                Button(action: self.navigation.showA) {
                    Text("Push A")
                }
            }
            .navigationDestination(for: PathTvTeOptions.self) { path in
                switch path {
                case .optionA(let vm):
                    OptionAView(vm: vm)
                        .toolbar {
                            Button(action: self.navigation.showB) {
                                Text("Push B")
                            }
                        }
                case .optionB(let vm):
                    OptionBView(vm: vm)
                        .toolbar {
                            Button(action: self.navigation.showInitial) {
                                Text("Show Initial")
                            }
                        }
                }
            }

    }
    
}
