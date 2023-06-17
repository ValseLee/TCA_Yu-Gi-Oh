//
//  YTAuthStore.swift
//  YugiTraderAuth
//
//  Created by Celan on 2023/06/15.
//  Copyright © 2023 Celan. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Utilities

public enum AuthState {
    case signedIn
    case beforeSignedin
    case unsigned
}

public struct AuthStateStore: ReducerProtocol {
    public struct State: Equatable {
        
    }
    
    public enum Action: Equatable {
        case loginButtonTapped
    }
    
    public init() { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                return .none
            }
        }
    }
}
