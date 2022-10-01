//
//  Fruit.swift
//  Fruit
//
//  Created by Labtanza on 9/28/22.
//

import Foundation
import SwiftUI


struct Fruit : Hashable, Identifiable, Displayable{
    static let fruitList = [Fruit(name: "Banana"), Fruit(name: "Strawberry"), Fruit(name: "Pineapple")]
    
    var id: String
    
    init(name: String) {
        self.id = name
    }
    
    var name:String {
        id
    }
    
    // to conform to Hashable which inherit from Equatable
    static func == (lhs: Fruit, rhs: Fruit) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    // to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



struct FruitView: View {
    
    @State private var counter = 0
    @EnvironmentObject var navigation: NavigationManager
    var fruit: Fruit
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("I AM A FRUIT VIEW")
            Text("Selected fruit: " + fruit.id)
            Text("How many updates: \(counter)")
            
            NavigationOptionsView(counter: $counter).environmentObject(navigation)
            
            
        }.onDisappear() {
            print("Fruit view \(fruit.id) is gone")
        }.onAppear() {
            print("Hi I'm \(fruit.id), I'm new here.")
        }
        
    }
}

