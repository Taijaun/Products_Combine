//
//  ContentView.swift
//  Products_Combine
//
//  Created by Taijaun Pitt on 28/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var productViewModel = ProductViewModel(manager: NetworkManager())
    
    var body: some View {
        NavigationStack {
            List(productViewModel.productList, id: \.id) { product in
                Text(product.title ?? "Unknown")
                    .padding()
            }
        }
        .onAppear {
            productViewModel.getProductList(apiUrl: "https://dummyjson.com/products")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
