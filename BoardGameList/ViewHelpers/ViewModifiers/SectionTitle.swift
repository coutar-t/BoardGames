//
//  SectionTitle.swift
//  BoardGameList
//
//  Created by Thibaut Coutard on 31/01/2022.
//

import Foundation
import SwiftUI

struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white.opacity(0.8))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {
    func sectionTitle() -> some View {
        modifier(SectionTitle())
    }
}
