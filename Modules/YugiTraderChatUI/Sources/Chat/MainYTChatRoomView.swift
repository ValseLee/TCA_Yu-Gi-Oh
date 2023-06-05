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

public struct MainYTChatRoomView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var date: Date = .now
    @State private var toIndex: Int = 0
    
    let mockArr: [Message] = Array(
        repeating: Message.mock(),
        count: 50
    )
    
    // MARK: - LIFECYCLE
    public init() { }
    
    public init(scrollOffset: CGFloat, date: Date) {
        self.scrollOffset = scrollOffset
        self.date = date
    }
    
    // MARK: - BODY
    public var body: some View {
        ScrollView {
            Picker("\(toIndex)", selection: $toIndex) {
                ForEach(0..<mockArr.count) { index in
                    Text("\(index)")
                }
            }
            
            DatePicker("To Date", selection: $date)
   
            ScrollViewReader { reader in
                VStack {
                    ForEach(
                        Array(mockArr.enumerated()),
                        id: \.offset
                    ) { index, message in
                        VStack {
                            VStack {
                                Text("\(index), \(message.message)")
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                                    
                                Text(Date.getMessageDateString(with: message.date))
                            }
                            .id(index)
                        }
                        .id(Date.getMessageDateString(with: message.date))
                    }
                }
                .onChange(of: date) { newValue in
                    let dateString = Date.getMessageDateString(with: newValue)
                    print("DATE CHANGED: \(dateString)")
                    withAnimation {
                        reader.scrollTo(
                            dateString,
                            anchor: .bottom
                        )
                    }
                }
                .onChange(of: toIndex) { newValue in
                    withAnimation {
                        reader.scrollTo(
                            newValue,
                            anchor: .bottom
                        )
                    }

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
