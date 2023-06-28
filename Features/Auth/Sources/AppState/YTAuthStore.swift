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
    case prepared, success, wrongID, wrongPassword
}

public struct AuthStateStore: ReducerProtocol {
    public struct State: Equatable {
        public static func == (
            lhs: AuthStateStore.State,
            rhs: AuthStateStore.State
        ) -> Bool {
            lhs.userDeviceToken == rhs.userDeviceToken
        }
        
        public var userDeviceToken: String = UIDevice.current.identifierForVendor!.uuidString
        public var authProcessState: AuthProcessState = .unSigned
        public var authenticateState: AuthenticateState = .prepared
        
        public var isLoginButtonTapped: Bool = false
        
        @AppStorage("HasUserLoggedIn")
        var hasUserLoggedIn: Bool = UserDefaults.standard.bool(forKey: "")
    }
    
    public enum Action: Equatable {
        case checkAuthenticate
        case changeAuthProcessState
        
        case loginButtonTapped
        case loginScreenIsAppearing
    }
    
    public init() { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .loginScreenIsAppearing:
                return .none
                
            case .checkAuthenticate:
                // 유저가 로그인 되어 있는지를 확인한다.
                // 자동 로그인이 되어있다면 success로 state를 변경
                Task {
                    await checkAuthenticate()
                }
                return .none
                
            case .changeAuthProcessState:
                switch state.authenticateState {
                case .prepared:
                    return .none
                    
                case .success:
                    if state.isLoginButtonTapped {
                        state.isLoginButtonTapped = false
                    }
                    return .none
                    
                default:
                    return .none
//                    return .send(.wrongAuthenticationInformation)
                    
                }
                
            case .loginButtonTapped:
                state.isLoginButtonTapped = true
                Task {
                    await processAppleLogin()
                }
                
                return .none
                
//            case .wrongAuthenticationInformation:
//
//                return .none
            }
        }
    }
    
    private func processAppleLogin() async {
        // Apple Login 실행
        // Auth 내부에 Capability 추가 필요
    }
    
    private func checkAuthenticate() async {
        // 만약 서버에 user의 Token이 있다 -> success
        // 없다 -> login 진행
    }
    
    private func createUserOnServer() async {
        // 서버에 유저 정보 생성
    }
}
