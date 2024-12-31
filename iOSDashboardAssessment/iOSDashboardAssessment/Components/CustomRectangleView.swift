//
//  CustomRectangleView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 03/07/24.
//

import SwiftUI

struct RoundedRectangleView: View {
    let viewHeight: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .frame(height: viewHeight)
            .shadow(color: .black.opacity(0.2), radius: 1)
        
        
    }
}


