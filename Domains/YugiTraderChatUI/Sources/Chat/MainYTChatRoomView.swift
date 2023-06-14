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
                        VStack(
                            alignment: messageContentsHorizontalAlignment(
                                message: message
                            ),
                            spacing: 5
                        ) {
                            Text(message.messageSenderID)
                                .bold()
                            
                            VStack {
                                Text("\(index), \(message.message)")
                                    .padding(.horizontal, 8)
                                    .padding()
                            }
                            .background {
                                getMessageCellBackgroundColor(with: message)
                            }
                            .clipShape(Bubble(isCurrentUsersMessage: checkIfCurrentUsersMessage(message: message)))
                            
                            Text(
                                Date.getMessageDateString(
                                    with: message.date
                                )
                            )
                            .font(.footnote)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: messageContentsAlignment(
                                message: message
                            )
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
                        withAnimation(Animation.easeInOut(duration: 1.25)) {
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
    
    private func messageContentsAlignment(message: Message) -> Alignment {
        if checkIfCurrentUsersMessage(message: message) {
            return .trailing
        } else {
            return .leading
        }
    }
    
    private func messageContentsHorizontalAlignment(message: Message) -> HorizontalAlignment {
        if checkIfCurrentUsersMessage(message: message) {
            return .trailing
        } else {
            return .leading
        }
    }
}

struct MainYTChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainYTChatRoomView()
        }
    }
}

