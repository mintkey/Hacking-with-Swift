//
//  Divider.swift
//  FriendFace
//
//  Created by Helen Dempsey on 5/14/25.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1.5)
            .foregroundStyle(Color(.systemGray6))
            .padding(.vertical)
    }
}

#Preview {
    Divider()
}
