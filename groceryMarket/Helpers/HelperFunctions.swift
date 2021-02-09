//
//  HelperFunctions.swift
//  groceryMarket
//
//  Created by bhargava on 09/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import Foundation
func convertTocurrency(_ number:Double)-> String{
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    let priceString = currencyFormatter.string(from: NSNumber(value: number)) ?? ""
    return priceString
}
