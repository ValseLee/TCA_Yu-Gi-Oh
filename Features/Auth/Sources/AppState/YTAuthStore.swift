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

/**
 User가 로그인 되어 있는지, 로그인되지 않았는지를 구별하는 열거형
 */
public enum AuthProcessState {
    case unSigned, beforeSignedin, signedIn
}

/**
 로그인 인증 상태를 구별해주는 열거형
 */
public enum AuthenticateState {
    case prepare, success, wrongPassword, wrongID
}

public struct AuthStateStore: ReducerProtocol {
    public struct State: Equatable {
        public var authProcessState: AuthProcessState = .unSigned
        public var authenticateState: AuthenticateState = .prepare
        public var isLoginButtonTapped: Bool = false
        
    }
    
    public enum Action: Equatable {
        case checkAuthenticate
        case changeAuthProcessState
        case loginButtonTapped
    }
    
    public init() { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .checkAuthenticate:
                // 유저가 로그인 되어 있는지를 확인한다.
                // 자동 로그인이 되어있다면 success로 state를 변경
                return .none
                
            case .changeAuthProcessState:
                return .none
                
            case .loginButtonTapped:
                return .send(.changeAuthProcessState)
            }
        }
    }
}
