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
        
        public init(
            chatStateFilter: StateFilter,
            name: String
        ) {
            self.chatStateFilter = chatStateFilter
            self.name = name
        }
    }
    
    public enum Action: Equatable {
        case sendChat
        case afterSendChat
        case changeName
    }
    
    public init() { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .sendChat:
                state.chatStateFilter = .proceeding
                print("CHAT IS NOW SENDING")
                return .send(.afterSendChat)
                
            case .afterSendChat:
                state.chatStateFilter = .completed
                return .send(.changeName)
            
            case .changeName:
                state.name = state.chatStateFilter.rawValue
                return .none
            }
        }
    }
}
