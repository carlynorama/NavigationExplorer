//
//  OptionViews.swift
//  NavigationExplorer
//
//  Created by Labtanza on 10/8/22.
//

import Foundation
import SwiftUI

struct OptionAView: View {
    @ObservedObject var vm: OptionAVM
    
    var body: some View {
        Text("Option A View")
    }
}

final class OptionAVM: NSObject, ObservableObject {
    deinit {
        print("deinit: \(String(describing: self))")
    }
}


struct OptionBView: View {
    @ObservedObject var vm: OptionBVM
    
    var body: some View {
        Text("Option B View")
    }
}

final class OptionBVM: NSObject, ObservableObject {
    deinit {
        print("deinit: \(String(describing: self))")
    }
}
