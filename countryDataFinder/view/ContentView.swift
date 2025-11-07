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

    // API error
    func showErrorView() -> Text {
        if let errorMessage = viewModel.errorMessage {
            return Text(errorMessage)
                .foregroundColor(.red)
        } else {
            return Text("")
        }
    }

    // delete country from list on swipe
    func deleteCountry(at offsets: IndexSet) {
        viewModel.countries.remove(atOffsets: offsets)
    }

    var body: some View {

        NavigationSplitView {

            // MARK:  - search view
            HStack {
                TextField("Search by country name", text: $countryName)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: countryName) { newValue in
                        // reseting searchview on editing
                        viewModel.country = nil
                        viewModel.errorMessage = nil

                        if !(viewModel.isLoading ?? false) && !newValue.isEmpty
                        {
                            fetchAPI()
                        }
                    }
            }

            // Show country from search response
            if let country = viewModel.country {
                HStack {
                    Text(country.name).padding(.horizontal)
                    Button("Add to list") { viewModel.addCountryToList() }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
            }
            //show loading text
            if viewModel.isLoading ?? false {
                Text("Loading.....").padding()
            }
            // error view
            showErrorView()

            Spacer()

            // MARK: - List Section
            List {
                ForEach(viewModel.countries) { country in
                    NavigationLink {
                        CountryDetailsView(countryModel: country)
                    } label: {
                        CountryRow(countryModel: country, isDetailsView: false)
                    }

                }
                .onDelete(perform: deleteCountry)

            }.toolbar { EditButton() }
                .navigationTitle("Country Finder")
        } detail: {
            Text("Select a Country")
        }

    }
}

#Preview {
    ContentView()
}
