//
//  File.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

internal import Combine
import Foundation
import SwiftUI

class CountryViewModel: ObservableObject {
    @Published var country: CountryModel?
    @Published var errorMessage: String?
    @Published var isLoading: Bool?

    private var cancellables = Set<AnyCancellable>()

    //get location
    @Published var locationManager = LocationManager()
    //add default country in the list
    @Published var countries: [CountryModel] = [
        CountryModel(
            name: "Egypt",
            capital: "Cairo",
            currencies: [
                Currency(
                    code: "EGP",
                    name: "Egyptian pound",
                    symbol: "£"
                )
            ],
            independent: true
        )
    ]

    init() {
        // Listen for country updates
        locationManager.$countryName
            .compactMap { $0 }
            .sink { [weak self] country in
                self?.addFirstUserCountry(firstUserCountry: country)
            }
            .store(in: &cancellables)
    }

    // check user country or fall back to Egypt
    func addFirstUserCountry(firstUserCountry: String) {
        fetchCountry(by: firstUserCountry) { [weak self] fetchedCountry in
            guard let self = self else {
                return
            }
            if let fetchedCountry = fetchedCountry {
                self.countries = [fetchedCountry]
            } else {
                print("error fetching user country")
            }
        }
    }

    let MaxNumberOfCountriesAllowed = 5

    func fetchCountry(
        by name: String,
        completion: @escaping (CountryModel?) -> Void
    ) {

        self.isLoading = true

        let encodedName = name.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )!
//        print(encodedName)
//        print(
//            "https://restcountries.com/v2/name/\(encodedName)?fields=name,capital,currencies"
//        )
        // Call API URL for the given country name
        guard
            let url = URL(
                string:
                    "https://restcountries.com/v2/name/\(encodedName)?fields=name,capital,currencies"
            )
        else {
            self.errorMessage = "Invalid URL"
            return
        }

        // Make the network request
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            // Decode the response
            do {
                let countries = try JSONDecoder().decode(
                    [CountryModel].self,
                    from: data
                )
                if let firstCountry = countries.first {
                    DispatchQueue.main.async {
                        self.country = firstCountry
                        self.errorMessage = nil
                        completion(firstCountry)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode JSON"
                }
            }
        }.resume()
    }

    // Add the fetched country to the list
    func addCountryToList() {
        // check is there's a valid country to add
        guard let country = country else {
            self.errorMessage = "No country to add"
            return
        }
        // check if max number of items already added in the country
        if countries.count == MaxNumberOfCountriesAllowed {
            self.errorMessage = "You reached max number of countries to add"
        }
        // Add the country to the list
        if !countries.contains(where: { $0.name == country.name }) {
            countries.append(country)
        } else {
            self.errorMessage = "Country already added"
        }
        self.country = nil
    }
}
