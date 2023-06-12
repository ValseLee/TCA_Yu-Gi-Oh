//
//  MessageBubble.swift
//  YugiTraderChatUI
//
//  Created by Celan on 2023/06/05.
//  Copyright © 2023 Celan. All rights reserved.
//

import SwiftUI

internal struct Bubble: Shape {
    internal let isCurrentUsersMessage: Bool
    
    internal init(isCurrentUsersMessage: Bool) {
        self.isCurrentUsersMessage = isCurrentUsersMessage
    }
    
    internal func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners:
                isCurrentUsersMessage
            ? [.topLeft, .bottomLeft, .bottomRight]
            : [.topRight, .bottomRight, .bottomLeft],
            cornerRadii: CGSize(
                width: 20,
                height: 20
            )
        )
        
        return Path(path.cgPath)
    }
}
