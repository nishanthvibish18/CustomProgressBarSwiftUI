//
//  DashboardView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 03/07/24.
//

import SwiftUI
import SampleData
struct DashboardView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    let statusBarHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment:.leading) {
            CustomTextView(font: .title, fontWeight: .bold, color: Color.black, titleText: "Dashboard")
                .padding(.bottom, 10)
            
            //MARK: User Name View
            UserProfileCardView()
                .padding(.bottom, 18)
            
            GeometryReader(content: { geometry in
                VStack(spacing: 20) {
                    
                    //MARK: Job Status Container View
                    Button(action: {
                        self.dashboardViewModel.isJobData = true
                        self.dashboardViewModel.navigationPath.append(NavigationPathEnum.datadetailview)
                    }, label: {
                        //MARK: Job Status Reactangle view here i am added progress bar inside over lay of the rounded rectangle
                        RoundedRectangleView(viewHeight: statusBarHeight <= 667 ? geometry.frame(in: .local).height / 2.1 : geometry.frame(in: .local).height / 2.7)
                            .overlay {
                                VStack(alignment: .center,spacing: 8) {
                                    //MARK: Job status text with divider view
                                    StatusTextView(titleText: "Job Status")
                                    
                                    //MARK: Custom Progress bar with Leading and Trailing Value here passing job status array and values
                                    DashboardProgressWithTextView(leadingText: self.dashboardViewModel.jobCount, trailingText: dashboardViewModel.jobCompletedCount, progressArray: self.dashboardViewModel.jobProgressArray)
                                    
                                    //MARK: Job Progress Bar Information View
                                    
                                    ProgressbarInfoView(progressBarColorArray: self.dashboardViewModel.jobProgressArray)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 10)
                                    
                                    Spacer()
                                    
                                }
                            }
                        
                    })
                    
                    
                    
                    //MARK: Invoice Status Container View
                    Button(action: {
                        self.dashboardViewModel.isJobData = false
                        self.dashboardViewModel.navigationPath.append(NavigationPathEnum.datadetailview)
                    }, label: {
                        //MARK: Invoice Reactangle view here i am added progress bar inside over lay of the rounded rectangle
                        RoundedRectangleView(viewHeight: statusBarHeight <= 667 ?  geometry.frame(in: .local).height / 2.6 : geometry.frame(in: .local).height / 3.2)
                            .overlay {
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    //MARK: Job status text with divider view
                                    StatusTextView(titleText: "Invoice Status")
                                    
                                    //MARK: Custom Progress bar with Leading and Trailing Value here passing Invoice status array and values
                                    DashboardProgressWithTextView(leadingText: self.dashboardViewModel.totalValue, trailingText: dashboardViewModel.collectedValue, progressArray: self.dashboardViewModel.invoiceProgressArray)
                                    
                                    //MARK: Inovice Progress Bar Information View
                                    ProgressbarInfoView(progressBarColorArray: self.dashboardViewModel.invoiceProgressArray)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 8)
                                    Spacer()
                                }
                            }
                        
                    })
                    
                }
                
            })
            
        }.padding(.horizontal, 20)
            .navigationBarHidden(true)
        
            .onAppear(perform: {
                dashboardViewModel.updateData()
            })
            .navigationDestination(for: NavigationPathEnum.self) { paths in
                switch paths{
                case .datadetailview:
                    DetailListView()
                }
            }
        
    }
    
    
    
}

#Preview {
    DashboardView()
}



//MARK: User Profile Card View
struct UserProfileCardView: View {
    var body: some View {
        RoundedRectangleView(viewHeight: 100)
            .overlay {
                HStack(alignment: .center, content: {
                    VStack(alignment: .leading, spacing: 10, content: {
                        CustomTextView(font: .title2, fontWeight: .bold, color: .black, titleText: "Hello, User! 👋")
                        
                        CustomDateTextView(dateText: "\(Date.now.addingTimeInterval(86400).formatted())")
                    })
                    
                    Spacer()
                    
                    Image("userimage")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                })
                .padding(.all, 15)
            }
    }
}



//MARK: Status Title Text View With Divider View
struct StatusTextView: View {
    let titleText: String
    var body: some View {
        
        VStack(alignment: .leading,spacing: 8) {
            
            CustomTextView(font: .title3, fontWeight: .medium, color: .black, titleText: titleText)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            
            Divider()
            
            
        }
        
    }
}




//MARK: Dashboard Progress View With Leading And Trailing Text View
struct DashboardProgressWithTextView: View {
    let leadingText: String
    let trailingText: String
    let progressArray: [ProgressColorModel]
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            HStack(alignment: .center, content: {
                CustomTextView(font: .caption, fontWeight: .medium, color: .gray, titleText: leadingText)
                
                Spacer()
                
                CustomTextView(font: .caption, fontWeight: .medium, color: .gray, titleText: trailingText)
                
                
            })
            
            CustomProgressBar(progressBarColorArray: progressArray)
        })
        .padding(.horizontal, 10)
        
    }
}

