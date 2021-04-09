//
//  CustomButton.swift
//  Test task
//
//  Created by Сергей on 21.03.2021.
//

import SwiftUI

struct CustomStyleButton: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content

            .foregroundColor(colorScheme == .light ? .vkDarkBlue : .vkWhite)
            .frame(maxWidth: .infinity, minHeight: 34)
            .background(colorScheme == .light ? Color.vkLightGray : .vkDarkGray)
            .cornerRadius(10)
    }
}


extension View {
    func setCustomStyleButton(disabledStyle: Bool = false) -> some View {
        self.modifier(
            CustomStyleButton()
        )
    }
}
