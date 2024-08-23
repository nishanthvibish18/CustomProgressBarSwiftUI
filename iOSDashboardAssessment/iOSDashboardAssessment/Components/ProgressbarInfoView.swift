//
//  ProgressbarInfoView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 04/07/24.
//

import SwiftUI

struct ProgressbarInfoView: View {
    var progressBarColorArray: [ProgressColorModel]
    private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 150))
        ]
    var body: some View {
           
            LazyVGrid(columns: adaptiveColumn,alignment: .center, content: {
            ForEach(self.progressBarColorArray, id: \.self) { items in
                ProgressBarRectangleView(titleText: items.productText, backgroundColor: items.barColor)
            }
        })
        
       
    }
}

struct ProgressBarRectangleView: View {
    let titleText: String
    let backgroundColor: Color
    var body: some View {
        HStack(alignment: .center,spacing: 8, content: {
            
            RoundedRectangle(cornerRadius: 3)
                .fill(backgroundColor)
                .frame(width: 15,height: 15)
            
            CustomTextView(font: .footnote, fontWeight: .medium, color: Color.black.opacity(0.6), titleText: titleText)
            
            Spacer()
            
        })
    }
}
