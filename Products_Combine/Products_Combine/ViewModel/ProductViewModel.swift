//
//  ProductViewModel.swift
//  Products_Combine
//
//  Created by Taijaun Pitt on 28/06/2023.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject{
    
    @Published var customError: NetworkError?
    @Published var productList: [Product] = []
    private var cancelable = Set<AnyCancellable>()
    
    var manager: Networkable
    
    init(manager: Networkable){
        self.manager = manager
    }
    
    func getProductList(apiUrl: String){
        guard let url = URL(string: apiUrl) else{
            return
        }
        
        self.manager.getPlanetsFromApi(url: url, type: Products.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("done")
                case .failure(let error):
                    switch error {
                    case is URLError:
                        self.customError = .invalidURL
                    case is DecodingError:
                        self.customError = .parsingError
                    default:
                        self.customError = .dataNotFound
                    }
                    print(self.customError?.localizedDescription)
                }
            } receiveValue: { products in
                print(products)
                self.productList = products.products
            }
            .store(in: &cancelable)

    }
}
