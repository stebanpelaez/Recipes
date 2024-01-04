//
//  Dictionary+Extension.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

extension Dictionary {

    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            if let nKey = String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let nValue = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                parts.append("\(nKey)=\(nValue)")
            }
        }
        return parts.joined(separator: "&")
    }
}
