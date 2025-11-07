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

    func fetchAPI() {
        viewModel.fetchCountry(by: countryName)
        //        if let newCountry = viewModel.country {
        //            viewModel.countries.append(newCountry)
        //        }
    }
    var body: some View {
        
//        NavigationSplitView {
            
            HStack {
                // Input field for the country name
                TextField("Enter country name", text: $countryName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //            .onSubmit {
                //                fetchAPI()
                //            }
                Button("Search") { fetchAPI() }.padding(.trailing)
            }
            
            // Show error message if any
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            //        // Show country details if available
            if let country = viewModel.country {
                VStack(alignment: .leading) {
                    //                Text("Country: \(country.name)")
                    //                    .font(.title)
                    //                    .fontWeight(.bold)
                    //                Text("Capital: \(country.capital)")
                    //                if let firstCurrency = country.currencies.first {
                    //                    Text(
                    //                        "Currency: \(firstCurrency.name) (\(firstCurrency.symbol))"
                    //                    )
                    //                }
                    
                    CountryRow(countryModel: country, isDetailsView: false)
                    Button("Add to list") { viewModel.addCountryToList() }
                }
                .padding()
                
            }
            
            Spacer()
            
            // MARK: - List Section
            
            //        Text("Display List")
            //            .font(.title)
            
            //        NavigationSplitView {
            List(viewModel.countries) { country in
                //            VStack(alignment: .leading) {
                //                Text(country.name)
                //                    .font(.headline)
                //                    .foregroundColor(.blue)
                //                Text("Capital: \(country.capital)")
                //                    .font(.subheadline)
                //                Text("Currency: \(country.currencies[0].code ?? "")")
                //                    .font(.subheadline)
                //            }
                //            .padding(.vertical, 4)
                
//                NavigationLink {
//                    CountryDetailsView()
//                } label: {
                    CountryRow(countryModel: country, isDetailsView: false)
//                }
                
                
            }
            //            .navigationTitle("Display List")
            //        } detail: {
            //            Text("Select a Landmark")
            //        }
            
        }
    }
//        .navigationTitle("Display List")
//    } detail: {
//        Text("Select a Landmark")
//    }

#Preview {
    ContentView()
}
