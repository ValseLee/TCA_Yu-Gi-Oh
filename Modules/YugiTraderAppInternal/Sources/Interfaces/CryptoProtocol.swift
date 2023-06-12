//
//  CryptoProtocol.swift
//  YugiTraderChatKit
//
//  Created by Celan on 2023/06/08.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import CryptoKit

protocol CryptoProtocol {
    func encryptData() -> Result<Data, Error>?
    func decryptData() -> Result<Data, Error>?
}

// MOCK
@main
struct MockApp: App {
    /**
     1. 모든 깃스페 유저의 UserDefault에 각자의 SymmetricKey를 심는다.
     2. hash + HMAC 인증 메시지를 db에 올린다.
     3. decrypt 할 때 UserDefault의 SymmetricKey로 SealedBox를 decrypt한다.
     */
    
    var body: some Scene {
        WindowGroup {
            MockView()
        }
    }
}

struct MockView: View {
    @StateObject var mockCryptic = MockCryptic()
    
    var body: some View {
        VStack {
            
            Text("Hi")
            
            Text(mockCryptic.myData)
                .background { Color.red }
        }
        .onAppear {
            dump(mockCryptic.mySymmetricKey)
        }
    }
}

// MARK: Encrypt, Decrypt Logic
final class MockCryptic: ObservableObject {
    let mySymmetricKey: SymmetricKey = .init(size: SymmetricKeySize(bitCount: 256))
    
    @Published var myData: String = ""
}

extension MockCryptic: CryptoProtocol {
    func encryptData() -> Result<Data, Error>? {
        return nil
    }
    
    func decryptData() -> Result<Data, Error>? {
        return nil
    }
    
}

// MARK: Preview
struct MockPreview: PreviewProvider {
    static var previews: some View {
        MockView()
    }
}
