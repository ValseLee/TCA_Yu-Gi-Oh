//
//  CryptoProtocol.swift
//  YugiTraderChatKit
//
//  Created by Celan on 2023/06/08.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI

protocol CryptoProtocol {
    func encryptData() -> Result<Data, Error>?
}

// MOCK
@main
struct MockApp: App {
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
    }
}

final class MockCryptic: ObservableObject {
//    let mySymmetricKey: SymmetricKey = .init(size: SymmetricKeySize(bitCount: 256))
    @Published var myData: String = ""
}

extension MockCryptic: CryptoProtocol {
    func encryptData() -> Result<Data, Error>? {
        return nil
    }
    
    
}

// MARK: Preview
struct MockPreview: PreviewProvider {
    static var previews: some View {
        MockView()
    }
}
