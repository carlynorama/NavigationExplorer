//
//  ContentView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import Foundation
import SwiftUI



struct RootView: View {
    @StateObject private var nav = NavigationManager()
    
    @State private var helloNewItem = false
    
    var body: some View {
        NavigationStack(path: $nav.visibilityStack) {
            VStack {
                Button("Jump to Strawberry through Banana", action: bananaAndStrawberry)
                    .padding(40)
                Button("Push Hello") { helloNewItem.toggle() }
                    .padding(40)
                List(Fruit.fruitList) {
                    fruit in NavigationLink(value: NavigationManager.RouteItem.Fruit(fruit)) {
                        Text(fruit.id)
                    }
                }
            }
            .onAppear() {
                print("RootView Appeared")
            }
            // Original call for when there was just fruit.
            //            .navigationDestination(for: Fruit.self) {
            //                fruit in FruitView(fruit: fruit).environmentObject(fruitController)
            //            }
            .navigationDestination(for: NavigationManager.RouteItem.self) { route in
                switch route {
                case .Fruit(let fruit):
                    DisplayView(item: fruit).environmentObject(nav)
//                    FruitView(fruit: fruit)
//                        .id(fruit)
//                        .environmentObject(nav)
                    
                case .Vehicle(let vehicle):
                    DisplayView(item: vehicle).environmentObject(nav)
//                    VehicleView(vehicle: vehicle).environmentObject(nav)
                }
            }.navigationDestination(isPresented: $helloNewItem, destination: { HelloThereView().environmentObject(nav) })
        }
    }
    
    func bananaAndStrawberry() {
        nav.bananaAndStrawberry()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
