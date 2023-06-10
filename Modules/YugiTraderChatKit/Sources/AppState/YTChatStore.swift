//
//  YTChatStore.swift
//  YugiTraderChatKit
//
//  Created by Celan on 2023/06/03.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

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
        case changeName
        case selectDateToScroll
        case scrollToSpecificDate(specificDate: Date)
        case highlightMessageBubble(withID: String)
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
                return .send(.changeName)
            
            case .changeName:
                state.name = state.chatStateFilter.rawValue
                return .none
            
            case .selectDateToScroll:
                return .send(.scrollToSpecificDate(specificDate: .now))
                
            case let .scrollToSpecificDate(specificDate):
                state.scollDate = specificDate
                return .send(.highlightMessageBubble(withID: ""))
                
            case let .highlightMessageBubble(dateID):
                state.scrollHighlight = dateID
                return .none
            }
        }
    }
}
