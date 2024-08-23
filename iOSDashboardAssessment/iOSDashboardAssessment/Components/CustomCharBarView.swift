//
//  CustomCharBarView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 04/07/24.
//

import SwiftUI

struct CustomProgressBar: View {
    
    var progressBarColorArray: [ProgressColorModel]
    var body: some View {
        
        GeometryReader { geometrySize in
            ZStack(alignment: .leading) {
                ForEach(0..<self.progressBarColorArray.count, id: \.self) { index in
                    self.progressBarColorArray[index].barColor
                        .frame(width: geometrySize.size.width * progressBarColorArray[index].barSize)
                        .offset(x: self.currentOffetPosition(itemSize: geometrySize.size.width, currentIndex: index))
                }
            }
        }
        .frame(height: 25)
        .cornerRadius(4)
    }
    
    private func currentOffetPosition(itemSize: CGFloat, currentIndex: Int) -> CGFloat{
        let framePosition = self.progressBarColorArray[..<currentIndex].reduce(0) { $0 + ($1.barSize * itemSize)}

        return framePosition
    }
    
   
}


