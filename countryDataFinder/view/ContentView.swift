//
//  ContentView.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountryViewModel()
    @State private var countryName: String = ""

    // API Call
    func fetchAPI() {
        viewModel.fetchCountry(by: countryName)
    }

    func showErrorView() -> Text {
        if let errorMessage = viewModel.errorMessage {
            return Text(errorMessage)
                .foregroundColor(.red)
        } else {
            return Text("")
        }
    }

    var body: some View {

        NavigationSplitView {

            // search view
            HStack {
                TextField("Enter country name", text: $countryName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Search") { fetchAPI() }.padding(.trailing)
            }

            // error view
            showErrorView()

            // Show country from search response
            if let country = viewModel.country {
                VStack(alignment: .leading) {

                    CountryRow(countryModel: country, isDetailsView: false)
                    Button("Add to list") { viewModel.addCountryToList() }
                }
                .padding()

            }

            Spacer()

            // MARK: - List Section
            List(viewModel.countries) { country in

                NavigationLink {
                    CountryDetailsView(countryModel: country)
                } label: {
                    CountryRow(countryModel: country, isDetailsView: false)
                }

            }
            .navigationTitle("Country Finder")
        } detail: {
            Text("Select a Landmark")
        }

    }
}

#Preview {
    ContentView()
}
