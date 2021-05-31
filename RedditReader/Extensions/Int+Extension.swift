//
//  Int+Extension.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation

extension Int {
    var kmValue: String {
        if self > 0 {
            if self >= 1000000 {
                return String((self / 1000000)) + "m"
            } else if self >= 1000 {
                return String((self / 1000)) + "k"
            }
        }
        return String(self)
    }
}
