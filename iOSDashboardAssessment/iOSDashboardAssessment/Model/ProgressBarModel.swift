//
//  ProgressBarModel.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 04/07/24.
//

import Foundation
import SwiftUI

struct ProgressColorModel: Identifiable, Hashable{
    let id = UUID()
    var barColor: Color
    var barSize: CGFloat
    var productText: String = ""
    var selectedItem: Bool
    var status: String = ""
    
   
}
