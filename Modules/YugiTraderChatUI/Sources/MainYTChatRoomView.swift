//
//  MainYTChatRoomView.swift
//  YugiTraderChatUI
//
//  Created by Celan on 2023/06/03.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import CommonModule
import YugiTraderAppInternal

struct MainYTChatRoomView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var date: Date = .now
    
    let mockArr: [Message] = Array(
        repeating: Message.mock(),
        count: 20
    )
    
    var body: some View {
        ScrollView {
            DatePicker(
                  "DatePicker",
                  selection: $date,
                  displayedComponents: [.date]
            )
            .padding(.horizontal)
            
            ScrollViewReader { reader in
                VStack {
                    ForEach(
                        Array(mockArr.enumerated()),
                        id: \.offset
                    ) { index, message in
                        Text("\(index), \(message.message)")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .id(Date.getMessageDateString(with: message.date))
                        
                        Text(Date.getMessageDateString(with: message.date))
                    }
                }
                .onChange(of: date) { newValue in
                    print("DATE CHANGED: \(newValue.formatted())")
                    reader.scrollTo(
                        Date.getMessageDateString(with: newValue),
                        anchor: .bottom
                    )
                }
            }
        }
    }
}

struct MainYTChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MainYTChatRoomView()
    }
}

struct Message: Hashable {
    let id: String = UUID().uuidString
    let message: String
    let date: Date
    
    static func mock() -> Self {
        Message(
            message: "mock Message",
            date: .now
        )
    }
}

struct ScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        defaultValue = value ?? nextValue()
    }
}

extension Date {
    static func getMessageDateString(with messageDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: messageDate)
        return str
    }
}
