//
//  Divider.swift
//  Moonshot
//
//  Created by Helen Dempsey on 4/27/25.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    Divider()
}
