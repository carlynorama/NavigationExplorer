//
//  StoreExampleView.swift
//  NavigationExplorer
//
//  Created by Labtanza on 9/30/22.
//

import SwiftUI

struct StoreExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ShopContainerView: View {
    @StateObject private var store = Store()
    @State private var path: [Product] = []

    var body: some View {
        NavigationStack(path: $path) {
            List(store.products) { product in
                NavigationLink(product.title, value: product)
            }
            .task { await store.fetch() }
            .navigationDestination(for: Product.self) { product in
                ProductView(product: product)
                    .toolbar {
                        Button("Show similar") {
                            path.append(product.similar[0])
                        }
                    }
            }
        }
    }
}


struct ProductView: View {
    let product:Product
    var body: some View {
        Text(product.name)
    }
}

class Store:ObservableObject {
   @Published var products:[Product] = [Product(name: "TotallyTheSame")]
    
    func fetch() {
        
    }
}



struct Product:Hashable, Identifiable {
    static func similarGenerator() -> [Product] {
        [Product(name: "TotallyTheSame")]
    }
    
    var id: String
    
    var similar:[Product]
    
    init(name: String) {
        self.id = name
        self.similar = Self.similarGenerator()
    }
    
    var name:String {
        id
    }
    
    var title:String {
        id
    }
    
    // to conform to Hashable which inherit from Equatable
    static func == (lhs: Product, rhs: Product) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    // to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}


struct StoreExampleView_Previews: PreviewProvider {
    static var previews: some View {
        StoreExampleView()
    }
}
