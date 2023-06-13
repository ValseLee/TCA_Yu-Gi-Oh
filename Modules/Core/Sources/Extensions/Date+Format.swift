//
//  Date+Format.swift
//  YugiTraderAppInternal
//
//  Created by Celan on 2023/06/06.
//  Copyright © 2023 Celan. All rights reserved.
//

import Foundation

public extension Date {
    static func getMessageDateString(with messageDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: messageDate)
        return str
    }
}
