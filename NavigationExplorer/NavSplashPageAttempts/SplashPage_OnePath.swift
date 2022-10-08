//
//  SplashPage.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/6/22.
//

import Foundation
import SwiftUI


enum SplashPathItems: Hashable {
    case splash
    case optionA(OptionAVM)
    case optionB(OptionBVM)
}


final class SplashPathCoordinator: ObservableObject {
    @Published var path: [SplashPathItems] = [.splash]
    
    func showA() {
        path.append(.optionA(OptionAVM()))
    }
    
    func showB() {
        path.append(.optionB(OptionBVM()))
    }
    
    func showSplash() {
        path = []
        path.append(.splash)
    }
    
    func showStack() {
        path = []
    }
}


struct SplashPathView: View {
    @ObservedObject var navigation:SplashPathCoordinator

    
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
            .navigationDestination(for: SplashPathItems.self) { path in
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
                case .splash:
                    splash
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

