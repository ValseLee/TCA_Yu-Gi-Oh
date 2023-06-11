//
//  Message.swift
//  YugiTraderAppInternal
//
//  Created by Celan on 2023/06/11.
//  Copyright © 2023 Celan. All rights reserved.
//

import Foundation

public struct Message: Hashable {
    public let id: String = UUID().uuidString
    public let message: String
    public let date: Date
    public let messageSenderID: String
    
    public init(message: String, date: Date, messageSenderID: String) {
        self.message = message
        self.date = date
        self.messageSenderID = messageSenderID
    }
    
    public static func getMockArray(
        repeatCount: Int
    ) -> [Self] {
        var array = [Message]()
        
        for count in 0..<repeatCount {
            array.append(
                Message(
                    message: "mock Message",
                    date: .now.adding(days: -count),
                    messageSenderID: count % 2 == 0 ? "Current" : "Others"
                )
            )
        }
        
        return array
    }
    
    public func getSpecificDateStringToScroll() -> String {
        Date.getMessageDateString(with: self.date)
    }
}
