//
//  File.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

internal import Combine
import Foundation

class CountryViewModel: ObservableObject {
    @Published var country: CountryModel?
    @Published var errorMessage: String?
    @Published var isLoading: Bool?
    @Published var countries = [
        CountryModel(
            name: "Egypt",
            capital: "Cairo",
            currencies: [
                Currency(code: "EGP", name: "Egyptian pound", symbol: "£")
            ],
            independent: true
        )
    ]

    let MaxNumberOfCountriesAllowed = 5

    func fetchCountry(by name: String) {
        self.isLoading = true

        // Call API URL for the given country name
        guard
            let url = URL(
                string:
                    "https://restcountries.com/v2/name/\(name)?fields=name,capital,currencies"
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
