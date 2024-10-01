//
//  String+Extentions.swift
//  NewsX
//
//  Created by Fırat Ören on 27.09.2024.
//

import Foundation

extension String {


    var capitalizeFirstLetter: String {
        let firstLetter = self.prefix(1).capitalized
        let remainLetters = self.dropFirst().lowercased()

        return firstLetter + remainLetters
    }



    func toDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale.current
            return formatter.string(from: date)
        }

        return "nil"
    }



    
}
