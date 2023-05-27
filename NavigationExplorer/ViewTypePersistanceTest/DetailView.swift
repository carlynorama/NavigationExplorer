//
//  DetailView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import SwiftUI


protocol Displayable:Identifiable {
    var name:String  { get }
    var id:String { get }
}

struct DisplayView<Item:Displayable>: View {
    
    @State private var counter = 0
    @EnvironmentObject var navigation: NavigationManager
    var item:Item
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("I AM A DISPLAY VIEW")
            Text("Selected vehicle: " + item.id)
            Text("How many updates: \(counter)")
            
            NavigationOptionsView(counter: $counter).environmentObject(navigation)
            
            
        }.onDisappear() {
            print("Vehicle view \(item.id) is gone")
        }.onAppear() {
            print("Hi I'm \(item.id), I'm new here.")
        }
        
    }
}



struct DisplayView2<Item:Displayable>: View {
    
    @State private var counter = 0
    @EnvironmentObject var navigation: NavigationManager
    var item:Item
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("I AM A DISPLAY VIEW")
            Text("Selected vehicle: " + item.id)
            Text("How many updates: \(counter)")
            
            //NavigationOptionsView(counter: $counter).environmentObject(navigation)
            
            
        }.onDisappear() {
            print("Vehicle view \(item.id) is gone")
        }.onAppear() {
            print("Hi I'm \(item.id), I'm new here.")
        }
        
    }
}

