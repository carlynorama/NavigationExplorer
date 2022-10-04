//
//  SplitViewLanding.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/4/22.
// 

import SwiftUI

//struct Option:Identifiable, Hashable {
//    let value:String
//    let id = UUID()
//
//    init(_ value: String) {
//        self.value = value
//    }
//}

struct SplitViewLanding: View {
    //var options = [Option("Alpha"), Option("Beta"), Option("Gamma"), Option("Delta"), Option("Epsilon")]
    var options = ["Alpha", "Beta", "Gamma", "Delta", "Epsilon"]
    
    //@State var selection:Option = Option("Psi")
    //NOTE: the selection binding must be an optional. 
    @State var selection:String?
    
    var body: some View {
        NavigationSplitView {
            Button("Nil Selection") { selection = nil }
            List(options, id:\.self, selection: $selection) { o in
                Text("\(o)")
            }
        } detail: {
            if let selection {
                RootForDetailView(for: selection)//.id(selection)
            }
            
        }
    }
}

struct SplitViewLanding_Previews: PreviewProvider {
    static var previews: some View {
        SplitViewLanding()
    }
}
