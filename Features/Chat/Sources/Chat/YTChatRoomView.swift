//
//  MainYTChatRoomView.swift
//  YugiTraderChatUI
//
//  Created by Celan on 2023/06/03.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import AppCore
import Utilities
import ComposableArchitecture

public struct MainYTChatRoomView: View {
    let store: StoreOf<ChatStateStore>
    
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
    
    // MARK: LIFECYCLE
    public init(
        store: StoreOf<ChatStateStore>,
        isCalendarShown: Bool
    ) {
        self.store = store
        self.isCalendarShown = isCalendarShown
    }
    
    // MARK: - BODY
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                ScrollViewReader { reader in
                    VStack {
                        ForEach(
                            Array(mockArr.enumerated()),
                            id: \.offset
                        ) { index, message in
                            VStack(
                                alignment: viewStore.state.messageBubbleHorizontalAlignment,
                                spacing: 5
                            ) {
                                Text(message.messageSenderID)
                                    .bold()
                                
                                VStack {
                                    Text("\(index), \(message.message)")
                                        .padding(.horizontal, 8)
                                        .padding()
                                }
                                .background { viewStore.state.messageBubbleBackgroundColor }
//                                .clipShape(Bubble(isCurrentUsersMessage: checkIfCurrentUsersMessage(message: message)))
                                
                                Text(
                                    Date.getMessageDateString(
                                        with: message.date
                                    )
                                )
                                .font(.footnote)
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: viewStore.state.messageBubbleAlignment
                            )
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .id(Date.getMessageDateString(with: message.date))
                        }
                    }
                    .id("TOP")
                    .onChange(of: viewStore.state.scrollDate) { newValue in
                        let dateString = Date.getMessageDateString(with: newValue)
                        viewStore.send(.renderAction(.scrollTo(proxy: reader, position: dateString)))
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            viewStore.send(.renderAction(.scrollTo(proxy: reader, position: "TOP")))
                        } label: {
                            Text("TO TOP")
                        }
                    }
                }
            }
            .sheet(isPresented: $isCalendarShown) {
                ScrollView {
                    //                DatePicker(
                    //                    selection: $scollDate,
                    //                    in: arrDateRange,
                    //                    displayedComponents: .date) {
                    //                        Image(systemName: "calendar")
                    //                    }
                    //                    .datePickerStyle(.graphical)
                    //                    .frame(width: 340)
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
    }
}

struct MainYTChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
//            MainYTChatRoomView()
        }
    }
}

