//
//  NavigiationOptionsView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import SwiftUI

struct NavigationOptionsView: View {
    @Binding var counter:Int
    @EnvironmentObject var navigation:NavigationManager
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("Fruit")
                HStack() {
                    Text("Swap View")
                    ForEach(Fruit.fruitList) { item in
                        Button(item.name) {
                            counter += 1
                            navigation.swapView(.Fruit(item))
                        }
                    }
                }
                
                HStack() {
                    Text("Load New Item View")
                    ForEach(Fruit.fruitList) { item in
                        Button(item.name) {
                            counter += 1
                            navigation.loadView(.Fruit(item))
                        }
                    }
                }
            }
            Spacer()
            Group {
                Text("Vehicles")
                HStack() {
                    Text("Swap View")
                    ForEach(Vehicle.vehicleList) { item in
                        Button(item.name) {
                            counter += 1
                            navigation.swapView(.Vehicle(item))
                        }
                    }
                }
                
                HStack() {
                    Text("Load New Item View")
                    ForEach(Vehicle.vehicleList) { item in
                        Button(item.name) {
                            counter += 1
                            navigation.loadView(.Vehicle(item))
                        }
                    }
                }
                
            }
            Spacer()
            HStack() {
                Text("Who is in the visibility stack")
                ForEach(navigation.visibilityStack, id: \.self) { item in
                    Text(item.name)
                }
            }
            Spacer()
            
        }.environmentObject(navigation)
        
    }
}

struct NavigiationOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationOptionsView(counter: .constant(4))
    }
}
