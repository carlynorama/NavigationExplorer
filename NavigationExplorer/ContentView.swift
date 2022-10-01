//
//  ContentView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import Foundation
import SwiftUI



struct ContentView: View {
    @StateObject private var nav = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $nav.visibilityStack) {
            VStack {
                Button("Pile Banana and Strawberry", action: bananaAndStrawberry)
                    .padding(40)
                List(Fruit.fruitList) {
                    fruit in NavigationLink(value: NavigationManager.RouteItem.Fruit(fruit)) {
                        Text(fruit.id)
                    }
                }
            }
            .onAppear() {
                print("appeared")
            }
            //            .navigationDestination(for: Fruit.self) {
            //                fruit in FruitView(fruit: fruit).environmentObject(fruitController)
            //            }
            .navigationDestination(for: NavigationManager.RouteItem.self) { route in
                switch route {
                case .Fruit(let fruit):
                    FruitView(fruit: fruit).environmentObject(nav)
                    
                case .Vehicle(let vehicle):
                    VehicleView(vehicle: vehicle).environmentObject(nav)
                }
            }
        }
    }
    
    func bananaAndStrawberry() {
        nav.bananaAndStrawberry()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
