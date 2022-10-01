//
//  Vehicle.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import Foundation
import SwiftUI


struct Vehicle:Hashable, Identifiable {
    static let vehicleList = [Vehicle(name: "Bicycle"), Vehicle(name: "Scooter"), Vehicle(name: "Bus")]
    
    var id: String
    
    init(name: String) {
        self.id = name
    }
    
    var name:String {
        id
    }
    
    // to conform to Hashable which inherit from Equatable
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    // to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct VehicleView: View {
    
    @State private var counter = 0
    @EnvironmentObject var navigation: NavigationManager
    var vehicle: Vehicle
    
    //@Environment(\.self) var env
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("I AM A VEHICLE VIEW")
            Text("Selected vehicle: " + vehicle.id)
            Text("How many updates: \(counter)")
            
            NavigationOptionsView(counter: $counter).environmentObject(navigation)
            
            
//            HStack(spacing:10) {
//                Text("Who is in the visibility stack")
//                ForEach(fruitViewController.visibilityStack, id: \.self) { fruit as any Displayable in
//                    Text(fruit.id)
//                }
//
//            }
            
        }.onDisappear() {
            print("Vehicle view \(vehicle.id) is gone")
        }.onAppear() {
            print("Hi I'm \(vehicle.id), I'm new here.")
            //dump(env)
        }
        
        //        }.onReceive(fruitViewController.$visibilityStack) { value in
        //            counter = 0
        //            showMoreText = false
        //
        //        }
        
    }
}


