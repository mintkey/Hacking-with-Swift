//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Helen Dempsey on 5/23/25.
//

import Foundation
import SwiftUI

extension EditView {
    @Observable
    class ViewModel {
        private(set) var location: Location
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(location: Location, name: String, description: String, loadingState: LoadingState = LoadingState.loading, pages: [Page] = [Page]()) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.loadingState = .loading
            self.pages = []
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                self.loadingState = .failed
            }
        }
        
        func addNewLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = location.name
            newLocation.description = location.description
            return newLocation
        }
    }
}
