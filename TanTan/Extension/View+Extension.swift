//
//  View+Extension.swift
//  TanTan
//
//  Created by Run on 2024/4/7.
//

import SwiftUI

extension View {
    func colorButton(type: ButtonType) -> some View {
        self.modifier(ColorButton(type: type))
    }
}
