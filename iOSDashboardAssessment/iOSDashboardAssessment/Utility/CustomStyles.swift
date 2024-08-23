//
//  CustomStyles.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 03/07/24.
//

import Foundation
import SwiftUI


//MARK: Date view Text Modifier In this method also we can reuse font attributes
struct DateTextStyleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.gray.opacity(0.8))
    }
}




//MARK: By calling text modifier we need to use like this
extension Text{
    func customTextStyle<Style: ViewModifier>(_ style: Style) -> some View{
        ModifiedContent(content: self, modifier: style)
    }
}
