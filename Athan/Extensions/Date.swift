//
//  Date.swift
//  Athan
//
//  Created by Khalid Alhazmi on 18/09/2021.
//

import Foundation

extension Date {
    func getShortDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short

        return formatter.string(from: self)
    }
}
