//
//  CustomTextView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 03/07/24.
//

import SwiftUI

struct CustomDateTextView: View {
    let dateText: String
    var body: some View {
        Text(dateText)
            .customTextStyle(DateTextStyleModifier())
    }
}


//MARK: Custom Text View
struct CustomTextView: View {
    let font: Font
    let fontWeight: Font.Weight
    let color: Color
    let titleText: String
    var body: some View {
        Text(titleText)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundStyle(color)
    }
}
