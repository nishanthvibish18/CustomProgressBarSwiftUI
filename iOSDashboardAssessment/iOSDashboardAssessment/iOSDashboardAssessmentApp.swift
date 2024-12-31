//
//  iOSDashboardAssessmentApp.swift
//  iOSDashboardAssessment
//
//  Created by SabariZuper on 15/05/24.
//

import SwiftUI

@main
struct iOSDashboardAssessmentApp: App {
    let dashboardViewModel = DashboardViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dashboardViewModel)
        }
    }
}
