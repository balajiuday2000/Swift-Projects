//
//  ViewModel.swift
//  Brewery
//
//  Created by Balaji Udayakumar on 3/29/23.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var data: Data = Data(items: [])
    private var task: AnyCancellable?
    private var url: String =
        "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    func fetchData() {
        guard let validURL = URL(string: url + text) else { return }
        task = URLSession.shared.dataTaskPublisher(for: validURL)
            .map({ $0.data })
            .decode(type: Data.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .replaceError(with: Data(items: []))
            .receive(on: RunLoop.main)
            .assign(to: \.data, on: self)
    }
}
