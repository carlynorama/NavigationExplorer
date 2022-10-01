//
//  NavigationManager.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import Foundation



class NavigationManager: ObservableObject {
    typealias Element = RouteItem
    enum RouteItem: Hashable {
        case Fruit(Fruit)
        case Vehicle(Vehicle)
        
        var name:String {
            switch self {
            case .Fruit(let fruit):
                return fruit.name
            case .Vehicle(let vehicle):
                return vehicle.name
            }
        }
    }
    
    @Published var visibilityStack : [RouteItem] = []

    func goToRoot() {
        visibilityStack.removeAll()
    }
    
    func loadView(_ item:Element) {
        visibilityStack.append(item)
    }
    
    func swapView(_ item:Element) {
        visibilityStack.removeLast()
        visibilityStack.append(item)
    }
    
    //weird. test.
    func replaceStack(_ item:Element) {
        visibilityStack.removeAll()
        Task { @MainActor in
            //The time delay may be device/app specific.
            try? await Task.sleep(nanoseconds: 400_000_000)
            loadView(item)
        }
    }
    
    // another one giving an example of what could be a deep link
    func bananaAndStrawberry() {
        visibilityStack.append(.Fruit(Fruit.fruitList[0]))
        visibilityStack.append(.Fruit(Fruit.fruitList[1]))
    }
    

}
