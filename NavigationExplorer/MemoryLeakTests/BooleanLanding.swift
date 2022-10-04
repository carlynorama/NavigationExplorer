//
//  ContentView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/3/22.
//

import SwiftUI

struct BooleanLanding: View {
    @State var showNavStack:Bool = false
    var body: some View {
        Button("ShowHide") {
            showNavStack.toggle()
        }.padding(20)
        if showNavStack {
            SimpleRootView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BooleanLanding()
    }
}
