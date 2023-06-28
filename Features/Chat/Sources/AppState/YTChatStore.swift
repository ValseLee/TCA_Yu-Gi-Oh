//
//  YTChatStore.swift
//  YugiTraderChatKit
//
//  Created by Celan on 2023/06/03.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Utilities
import AppCore

public struct ChatStateStore: ReducerProtocol {
    // MARK: STATE Filter
    public enum ChatStateFilter: String {
        case all, proceeding, completed
    }
    
    // MARK: STATE
    public struct State: Equatable {
        public var chatStateFilter: ChatStateFilter = .all
        public var currentUserName: String
        public var scrollDate: Date
        public var scrollHighlighted: String
        public var isCalendarShown: Bool
        
        // Message Bubble UI State
        public var messageBubbleAlignment: Alignment
        public var messageBubbleHorizontalAlignment: HorizontalAlignment
        public var messageBubbleBackgroundColor: Color
        
        // MARK: - State Lifecycle
        public init(
            chatStateFilter: ChatStateFilter,
            currentUserName: String,
            scrollDate: Date,
            scrollHighlight: String,
            isCalendarShown: Bool,
            messageBubbleAlignment: Alignment,
            messageBubbleHorizontalAlignment: HorizontalAlignment,
            messageBubbleBackgroundColor: Color
        ) {
            self.chatStateFilter = chatStateFilter
            self.currentUserName = currentUserName
            self.scrollDate = scrollDate
            self.scrollHighlighted = scrollHighlight
            self.isCalendarShown = isCalendarShown
            self.messageBubbleAlignment = messageBubbleAlignment
            self.messageBubbleHorizontalAlignment = messageBubbleHorizontalAlignment
            self.messageBubbleBackgroundColor = messageBubbleBackgroundColor
        }
    }
    // MARK: Action
    public enum Action: Equatable {
        case renderAction(ViewRenderAction)
        case backgroundLogics(BackgroundAction)
    }
    
    // MARK: Render Action
    public enum ViewRenderAction: Equatable {
        case renderUserMessageBubbleWithAlignment(message: Message)
        case renderUserMessageBubbleWithBackgroundColor(message: Message)
        case scrollTo(proxy: ScrollViewProxy, position: String)
        case highLightMessageBubble
        
        private var id: UUID { UUID() }
        public static func == (
            lhs: ChatStateStore.ViewRenderAction,
            rhs: ChatStateStore.ViewRenderAction
        ) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    // MARK: Backround Logic
    public enum BackgroundAction: Equatable {
        case sendMessage(Message)
    }
    
    // MARK: STORE LIFECYCLE
    public init() { }
    
    // MARK: Reducer
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            // MARK: VIEW RENDER ACTION
            case let .renderAction(renderAction):
                switch renderAction {
                case let .renderUserMessageBubbleWithAlignment(message):
                    if state.currentUserName == message.messageSenderID {
                        state.messageBubbleAlignment = .trailing
                        state.messageBubbleHorizontalAlignment = .trailing
                        
                    } else {
                        state.messageBubbleAlignment = .leading
                        state.messageBubbleHorizontalAlignment = .leading
                    }
                    
                    return .none
                
                case let .renderUserMessageBubbleWithBackgroundColor(message):
                    let dateString = Date.getMessageDateString(with: message.date)
                    
                    if state.scrollHighlighted == dateString {
                        state.messageBubbleBackgroundColor = Color.yellow
                    } else if state.currentUserName == message.messageSenderID {
                        state.messageBubbleBackgroundColor = .blue
                    } else {
                        state.messageBubbleBackgroundColor = .yellow
                    }
                    
                    return .none
                    
                case let .scrollTo(reader, position):
                    state.scrollHighlighted = position
                    
                    withAnimation {
                        reader.scrollTo(
                            state.scrollHighlighted,
                            anchor: .bottom
                        )
                    }
                    
                    return .send(.renderAction(.highLightMessageBubble))
                    
                case .highLightMessageBubble:
                    withAnimation(Animation.easeInOut(duration: 1.25)) {
                        state.scrollHighlighted = ""
                    }
                    
                    return .none
                }
            
            // MARK: BACKGROUND LOGICS
            case let .backgroundLogics(background):
                switch background {
                case let .sendMessage(message):
                    state.chatStateFilter = .proceeding
                    return .run { send in
                        print("CREATE A \(message.messageSenderID) ON FIRESTORE")
                    }
                }
            }
        }
    }
}
