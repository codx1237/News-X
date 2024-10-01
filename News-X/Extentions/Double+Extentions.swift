//
//  Double+Extentions.swift
//  NewsX
//
//  Created by Fırat Ören on 28.09.2024.
//

import Foundation

extension Double {
    func roundToInt() -> Int{
        return Int(Darwin.round(self))
    }
}
