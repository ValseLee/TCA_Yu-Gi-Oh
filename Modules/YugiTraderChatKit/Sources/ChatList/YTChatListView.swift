//
//  YTChatListView.swift
//  YugiTraderChat
//
//  Created by Celan on 2023/05/22.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI
import CommonModule
import SendbirdChatSDK

public struct YTChatListView: View {
    public init() { }
    public var body: some View {
        VStack {
            YTButton()
        }
    }
}

struct YTChatListView_Previews: PreviewProvider {
    static var previews: some View {
        YTChatListView()
    }
}
