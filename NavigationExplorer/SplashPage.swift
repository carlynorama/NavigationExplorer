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
    //@Published var isSplash = false
    
    func showA() {
        path.append(.optionA(OptionAVM()))
    }
    
    func showB() {
        path.append(.optionB(OptionBVM()))
    }
    
    func showSplash() {
        path = []
        path.append(.splash)
        //isSplash = true
    }
    
    func showStack() {
        //isSplash = false
        path = []
    }
}


struct SplashPageNavView: View {
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

            }//.navigationDestination(isPresented: $store.isInitial, destination: { initial })
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


struct OptionAView: View {
    @ObservedObject var vm: OptionAVM
    
    var body: some View {
        Text("Option A View")
    }
}

final class OptionAVM: NSObject, ObservableObject {
    deinit {
        print("deinit: \(String(describing: self))")
    }
}


struct OptionBView: View {
    @ObservedObject var vm: OptionBVM
    
    var body: some View {
        Text("Option B View")
    }
}

final class OptionBVM: NSObject, ObservableObject {
    deinit {
        print("deinit: \(String(describing: self))")
    }
}
