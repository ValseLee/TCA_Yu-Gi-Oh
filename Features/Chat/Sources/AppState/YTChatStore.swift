//
//  YTChatStore.swift
//  YugiTraderChatKit
//
//  Created by Celan on 2023/06/03.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import YugiTraderAppInternal

public enum StateFilter: String {
    case all, proceeding, completed
}

public struct ChatStateStore: ReducerProtocol {
    public struct State: Equatable {
        public var chatStateFilter: StateFilter = .all
        public var name: String
        public var scollDate: Date
        public var scrollHighlight: String
        public var isCalendarShown: Bool
        
        public init(
            chatStateFilter: StateFilter,
            name: String,
            scollDate: Date,
            scrollHighlight: String,
            isCalendarShown: Bool
        ) {
            self.chatStateFilter = chatStateFilter
            self.name = name
            self.scollDate = scollDate
            self.scrollHighlight = scrollHighlight
            self.isCalendarShown = isCalendarShown
        }
    }
    
    public enum Action: Equatable {
        case sendMessage
        case afterSendMessage
        case selectDateToScroll(message: Message)
        case scrollToSpecificDate(message: Message)
        case highlightMessageBubble(message: Message)
    }
    
    public init() { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .sendMessage:
                state.chatStateFilter = .proceeding
                print("Message IS NOW SENDING")
                return .send(.afterSendMessage)
                
            case .afterSendMessage:
                state.chatStateFilter = .completed
                return .none
            
            case let .selectDateToScroll(message):
                return .send(.scrollToSpecificDate(message: message))
                
            case let .scrollToSpecificDate(message):
                state.scollDate = message.date
                return .send(.highlightMessageBubble(message: message))
                
            case let .highlightMessageBubble(message):
                state.scrollHighlight = message.getSpecificDateStringToScroll()
                return .none
            }
        }
    }
}
