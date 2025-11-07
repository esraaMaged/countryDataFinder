//
//  Untitled.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

import SwiftUI

struct CountryRow: View {
    var countryModel: CountryModel?
    var isDetailsView: Bool

    //    print("isDetailsView: \(isDetailsView)")

    var body: some View {

        HStack {
            VStack {
                // country name
                Text(countryModel?.name ?? "Not Found").foregroundStyle(
                    Color.blue
                ).font(.title)
                .frame(
                        maxWidth: .infinity,
                        alignment: isDetailsView ? .center : .leading
                    ).padding()

                // country capital
                HStack {
                    Text("Capital:").padding(.leading).foregroundStyle(.primary)
                    Text(countryModel?.capital ?? "Not Found")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // country currency
                HStack {
                    Text("Currency:").padding(.leading).foregroundStyle(
                        .primary
                    )
                    Text(
                        countryModel?.currencies.first?.name ?? "Not Found"
                    ).foregroundStyle(.secondary)

                    if isDetailsView {
                        Text(
                            countryModel?.currencies.first?.code ?? ""
                        ).foregroundStyle(.secondary)

                        Text(
                            countryModel?.currencies.first?.symbol ?? ""
                        ).foregroundStyle(.secondary)

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }.frame(maxWidth: .infinity)
        }
        // arrow icon
        //        Button() {}
    }
}

#Preview {
    CountryRow(isDetailsView: true)
}
