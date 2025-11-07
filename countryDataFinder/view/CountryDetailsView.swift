//
//  CountryDetailsView.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

import SwiftUI


struct CountryDetailsView: View {

    var countryModel: CountryModel?
    
    
    var body: some View {
        CountryRow(countryModel: countryModel, isDetailsView: true)
        
//        HStack {
//            VStack {
//                // country name
//                Text("Country Name").font(.title).foregroundStyle(Color.blue)
//                    .frame(alignment: .center)
//
//                // country capital
//                HStack {
//                    Text("Capital:").padding(.leading).foregroundStyle(.primary)
//                    Text(countryModel?.capital ?? "capital name")
//                        .foregroundStyle(.secondary)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                // country currency
//                HStack {
//                    Text("Currency:").padding(.leading).foregroundStyle(
//                        .primary
//                    )
//                    Text(
//                        countryModel?.currencies.first?.name ?? "currency name"
//                    ).foregroundStyle(.secondary)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            }.frame(maxWidth: .infinity)
//        }
//
    }
}


#Preview {
    CountryDetailsView()
}
