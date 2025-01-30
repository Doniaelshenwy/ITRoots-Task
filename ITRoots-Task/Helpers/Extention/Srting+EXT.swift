//
//  Srting+EXT.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    func isValidEmail() -> Bool {
        let inputRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{3,64}"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:self)
    }
}

extension String {
    private static let formatter = NumberFormatter()

    private func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }
        Self.formatter.locale = locale
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            let digit = Self.formatter.number(from: original)!
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }
        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }
}
