//
//  SplashPage_PathPlusBool.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/8/22.
//

import Foundation
import SwiftUI


//WHY DOESN'T THIS WORK? isSplash can't start as true?

enum SplashBoolOptions: Hashable {
    case optionA(OptionAVM)
    case optionB(OptionBVM)
}


final class SplashBoolCoordinator: ObservableObject {
    @Published var path: [SplashBoolOptions] = []
    @Published var isSplash = true
    
    var isNew = true
    
    func showA() {
        path.append(.optionA(OptionAVM()))
    }
    
    func showB() {
        path.append(.optionB(OptionBVM()))
    }
    
    func showSplash() {
        path = []
        isSplash = true
    }
    
    func checkSplash() {
        print("Checking")
        if isNew {
            print("was new")
            showSplash()
            isNew = false
        } else {
            showA()
        }
    }
    
    
    func showStack() {
        isNew = false
        isSplash = false
        path = []
        print(isSplash, isNew)
    }
}


struct SplashBoolView: View {
    @StateObject var navigation:SplashBoolCoordinator
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            VStack {
                Text("Application Root View")
            }
            .toolbar {
                Button(action: self.navigation.showA) {
                    Text("Push A")
                }
            }
            .navigationDestination(isPresented: $navigation.isSplash, destination: { splash })
            .navigationDestination(for: SplashBoolOptions.self) { path in
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
                            Button(action: self.navigation.showSplash) {
                                Text("Kick Back To Splash")
                            }
                        }
                }

            }
            
        }
    }
    
    var splash: some View {
        VStack {
            Text("Splash Page")
            Button(action: navigation.showStack) {
                Text("Go App Root")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

