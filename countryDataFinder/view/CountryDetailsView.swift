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
    }
}


#Preview {
    CountryDetailsView()
}
