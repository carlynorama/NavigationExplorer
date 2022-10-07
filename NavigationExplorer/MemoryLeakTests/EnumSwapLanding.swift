//
//  EnumSwapLanding.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/4/22.
//  https://stackoverflow.com/questions/73941284/why-are-objects-still-in-memory-after-emptying-navigationstack-path/73954020#73954020

import Foundation
import SwiftUI


//This way causes a memory leak. Use the SplashPage example for a better way.

enum PathItem: Hashable {
    case apples(AppleStore)
    case bananas(BananaStore)
}

enum Screen {
    case initial
    case stack
}

final class CoordinatorStore: ObservableObject {
    @Published var path: [PathItem] = []
    @Published var screen: Screen = .initial
    
    init() {
        print("new coordinator")
    }
    
    deinit {
        print("goodbye coordinator")
    }
    
    func showApple() {
        path.append(.apples(AppleStore()))
    }
    
    func showBanana() {
        path.append(.bananas(BananaStore()))
    }
    
    func clearToInitial() {
        clearStack()
        screen = .initial
    }
    
    func clearStack() {
        path = []
    }
    
    func showStack() {
        screen = .stack
    }
    
    func gotToStackRoot() {
        clearStack()
        screen = .stack
    }
}


struct EnumSwapLandingView: View {
    @StateObject var coordinator = CoordinatorStore()
    
    var body: some View {
        switch coordinator.screen {
        case .initial: initial
        case .stack: stack
        }
    }
    
    var stack: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                Text("Root")
            }
            .toolbar {
                Button(action: self.coordinator.showApple) {
                    Text("Push an Apple View")
                }
            }
            .navigationDestination(for: PathItem.self) { path in
                switch path {
                case .apples(let AStore):
                    ViewA(store: AStore)
                        .toolbar {
                            Button(action: self.coordinator.showBanana) {
                                Text("Push a Banana View")
                            }
                        }
                case .bananas(let BStore):
                    ViewB(store: BStore)
                        .toolbar {
                            Button(action: self.coordinator.clearToInitial) {
                                Text("Show Initial")
                            }
                        }
                }
            }
        }
    }
    
    var initial: some View {
        VStack {
            Text("Initial")
            Button(action: coordinator.showStack) {
                Text("Go to Stack")
            }
        }
    }
}


struct ViewA: View {
    @StateObject var store: AppleStore
    
    var body: some View {
        Text("Apple View")
    }
}

//Must be final NSObject so PathItem can be Equatable the easy way.
final class AppleStore: NSObject, ObservableObject {
    deinit {
        print("Deinit: \(String(describing: self))")
    }
}


struct ViewB: View {
    @StateObject var store: BananaStore
    
    var body: some View {
        Text("Banana View")
    }
}

//Must be final NSObject so PathItem can be Equatable the easy way.
final class BananaStore: NSObject, ObservableObject {
    deinit {
        print("Deinit: \(String(describing: self))")
    }
}
