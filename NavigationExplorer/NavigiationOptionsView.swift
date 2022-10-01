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
            Text("Fruit")
            HStack(spacing: 10) {
                Text("Swap View")
                ForEach(Fruit.fruitList) { item in
                    Button(item.name) {
                        counter += 1
                        navigation.swapView(.Fruit(item))
                    }
                }
            }
            
            HStack(spacing: 10) {
                Text("Load New Item View")
                ForEach(Fruit.fruitList) { item in
                    Button(item.name) {
                        counter += 1
                        navigation.loadView(.Fruit(item))
                    }
                }
            }
            Spacer()
            Text("Vehicles")
            HStack(spacing: 10) {
                Text("Swap View")
                ForEach(Vehicle.vehicleList) { item in
                    Button(item.name) {
                        counter += 1
                        navigation.swapView(.Vehicle(item))
                    }
                }
            }
            
            HStack(spacing: 10) {
                Text("Load New Item View")
                ForEach(Vehicle.vehicleList) { item in
                    Button(item.name) {
                        counter += 1
                        navigation.loadView(.Vehicle(item))
                    }
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
