//
//  ContentView.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

internal import Combine
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CountryViewModel()
    @State private var countryName: String = ""
    @State var searchedCountry: CountryModel?

    private var cancellables = Set<AnyCancellable>()

    func getAskPermissionView() -> Text {
        if viewModel.locationManager.lastKnownLocation == nil {
            return Text("Please go to settings to request location permission")
        }
        return Text("")
    }

    // API Call
    func fetchAPI() {
        viewModel.fetchCountry(by: countryName) { country in
            searchedCountry = country
//            print("searchedCountry", searchedCountry)
        }
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
                        searchedCountry = nil
                        viewModel.errorMessage = nil

                        if !(viewModel.isLoading ?? false) && !newValue.isEmpty
                        {
                            fetchAPI()
                        }
                    }
            }

            // Show country from search response
            if let country = searchedCountry {
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

            }.onAppear {
                viewModel.locationManager.checkLocationAuthorization()
            }.toolbar { EditButton() }
                .navigationTitle("Country Finder")
        } detail: {
            Text("Select a Country")
        }

        // Permission view
        getAskPermissionView().padding().frame(
            maxWidth: .infinity,
            alignment: .center
        )

    }
}

#Preview {
    ContentView()
}
