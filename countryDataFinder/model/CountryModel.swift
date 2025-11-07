//
//  CountryModel.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 07/11/2025.
//

import Foundation

struct CountryModel: Identifiable, Codable {
    let id = UUID()

    let name, capital: String
    let currencies: [Currency]
    let independent: Bool?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}
