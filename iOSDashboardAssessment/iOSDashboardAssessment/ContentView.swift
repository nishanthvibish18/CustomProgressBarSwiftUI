//
//  ContentView.swift
//  iOSDashboardAssessment
//
//  Created by SabariZuper on 15/05/24.
//

import SwiftUI
import SampleData


struct ContentView: View {
    @EnvironmentObject var userData: DashboardViewModel 
    

    var body: some View {
        NavigationStack(path: $userData.navigationPath) {
            DashboardView()
            .environmentObject(userData)
        }
    }
}

#Preview {
    ContentView()
}
