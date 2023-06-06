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
    @State private var scollDate: Date = .now
    @State private var scrollHighlight: String = ""
    @State private var isCalendarShown: Bool = false
    
    let mockArr: [Message] = Message.getMockArray(repeatCount: 30)
    var arrDateRange: ClosedRange<Date> {
        if mockArr.count > 0 {
            let dateArr = mockArr.map { $0.date }
            // !!!: - 나중에 last랑 First랑 위치 바꿔야댐!
            return dateArr.last! ... dateArr.first!
        } else {
            return Date.now ... Date.now
        }
    }

    // MARK: - LIFECYCLE
    public init() { }
    
    public init(date: Date) {
        self.scollDate = date
    }
    
    // MARK: - BODY
    public var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                VStack {
                    ForEach(
                        Array(mockArr.enumerated()),
                        id: \.offset
                    ) { index, message in
                        VStack {
                            VStack {
                                Text("\(index), \(message.message)")
                                    .padding(.horizontal, 8)
                                    
                                Text(Date.getMessageDateString(with: message.date))
                            }
                            .padding()
                            .id(index)
                        }
                        .background {
                            getMessageCellBackgroundColor(with: message)
                        }
                        .clipShape(Bubble(isCurrentUsersMessage: checkIfCurrentUsersMessage(message: message)))
                        .frame(
                            maxWidth: .infinity,
                            alignment: checkIfCurrentUsersMessage(message: message)
                            ? .trailing
                            : .leading
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .id(Date.getMessageDateString(with: message.date))
                    }
                }
                .id("TOP")
                .onChange(of: scollDate) { newValue in
                    let dateString = Date.getMessageDateString(with: newValue)
                    isCalendarShown = false
                    
                    withAnimation {
                        reader.scrollTo(
                            dateString,
                            anchor: .bottom
                        )
                        scrollHighlight = dateString
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            scrollHighlight = ""
                        }
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        withAnimation {
                            reader.scrollTo(
                                "TOP",
                                anchor: .top
                            )
                        }
                    } label: {
                        Text("TO TOP")
                    }
                }
            }
        }
        .sheet(isPresented: $isCalendarShown) {
            ScrollView {
                DatePicker(
                    selection: $scollDate,
                    in: arrDateRange,
                    displayedComponents: .date) {
                        Image(systemName: "calendar")
                    }
                    .datePickerStyle(.graphical)
                    .frame(width: 340)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        if !isCalendarShown {
                            isCalendarShown = true
                        } else {
                            isCalendarShown = false
                        }
                    }
                } label: {
                    Image(systemName: "calendar")
                }
            }
        }
    }
    
    private func getMessageCellBackgroundColor(with message: Message) -> Color {
        let dateString = Date.getMessageDateString(with: message.date)
        if scrollHighlight == dateString {
            return Color.yellow
        } else {
            return message.messageSenderID == "Current"
            ? Color.blue
            : Color.orange
        }
    }
    
    private func checkIfCurrentUsersMessage(message: Message) -> Bool {
        message.messageSenderID == "Current"
    }
}

struct MainYTChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainYTChatRoomView()
        }
    }
}

struct Message: Hashable {
    let id: String = UUID().uuidString
    let message: String
    let date: Date
    let messageSenderID: String
    
    static func getMockArray(
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
}
