//
//  RootViewTwoTypes.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/11/22.
//

import SwiftUI


struct RootViewTwoTypes: View {
    @StateObject private var nav = NavigationPathManager()
    
    @State private var helloNewItem = false
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            VStack {
                Button("Jump to Strawberry through Banana", action: bananaAndStrawberry)
                    .padding(40)
                Button("Push Hello") { helloNewItem.toggle() }
                    .padding(40)
                List(Fruit.fruitList) {
                    fruit in NavigationLink(value: fruit) {
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
            .navigationDestination(for: Fruit.self) { fruit in
                let a = print("Test Me")
                    DisplayView2(item: fruit)
                        .environmentObject(nav)
                        .id(fruit)
            }.navigationDestination(for: Vehicle.self) { vehicle in
                let a = print("Test Me")
                    DisplayView2(item: vehicle)
                        .environmentObject(nav)
                        .id(vehicle)
            }
            
            .navigationDestination(isPresented: $helloNewItem, destination: { HelloThereView().environmentObject(nav) })
        }
    }
    
    func bananaAndStrawberry() {
        nav.bananaAndStrawberry()
    }
}


//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}

struct RootViewTwoTypes_Previews: PreviewProvider {
    static var previews: some View {
        RootViewTwoTypes()
    }
}
