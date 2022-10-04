//
//  HelloThereView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/1/22.
//

import SwiftUI

struct HelloThereView: View {
    @EnvironmentObject var navigation:NavigationManager
    
    var body: some View {
        VStack {
            Text("Hello There!")
            VStack() {
                Spacer()
                Text("Who is in the visibility stack:")
                Spacer()
                if navigation.visibilityStack.count > 0 {
                    ForEach(navigation.visibilityStack, id: \.self) { item in
                        Text(item.name)
                    }
                } else {
                    Text("The manual stack is empty.")
                }
                Spacer()
            }
        }
    }
}

struct HelloThereView_Previews: PreviewProvider {
    static var previews: some View {
        HelloThereView()
    }
}
