//
//  Date+Extentions.swift
//  NewsX
//
//  Created by Fırat Ören on 27.09.2024.
//

import Foundation

extension Date {
    func formattedString(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
}
