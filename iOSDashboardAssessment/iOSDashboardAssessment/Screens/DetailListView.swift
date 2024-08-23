//
//  DetailListView.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 04/07/24.
//

import SwiftUI

struct DetailListView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading,content: {
            //MARK: Progress bar based on the button navigation data is updated from the dashboard view model by adding ternary operator condition
            DashboardProgressWithTextView(leadingText: dashboardViewModel.isJobData ?  dashboardViewModel.jobCount : dashboardViewModel.totalValue, trailingText: dashboardViewModel.isJobData ? dashboardViewModel.jobCompletedCount : dashboardViewModel.collectedValue, progressArray: dashboardViewModel.isJobData ? dashboardViewModel.jobProgressArray : dashboardViewModel.invoiceProgressArray)
            
            //MARK: Horizontal Segment Button View for both job status and invoice status
            HorizontalSegMentCollectionView(progressItemArray: self.dashboardViewModel.isJobData ? self.dashboardViewModel.jobProgressArray : self.dashboardViewModel.invoiceProgressArray, buttonTap: self.dashboardViewModel.updateButtonValue)
                .frame(height: 45)
                .padding(.vertical, 15)
            
            switch self.dashboardViewModel.dataListEnums {
            case .jobsListArray(let jobArray):
                StatusListGenericView(listArray: jobArray, contentView: { items in
                    ListContentView(containerHeight: 110, firstText: "\(items.jobNumber)", secondText: items.title, thirdText: items.startTime)
                    
                })
            case .invoiceListArray(let invoiceArray):
                StatusListGenericView(listArray: invoiceArray) { items in
                    
                    ListContentView(containerHeight: 110, firstText: "\(items.invoiceNumber)", secondText: items.customerName, thirdText: "\(items.total)")
                    
                }
            }
            
            
        })
        .padding(.horizontal, 10)
        .onAppear(perform: {
            self.dashboardViewModel.updateButtonValue(index: 0)
            
        })
        .refreshable {
            dashboardViewModel.updateData()
            self.dashboardViewModel.updateButtonValue(index: 0)
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.dashboardViewModel.navigationPath.removeLast()
        }, label: {
            HStack(alignment: .center,spacing: 5,content: {
                Image(systemName: "arrow.left")

                Text(self.screenTitle())
                
            })
        }))
    }
    
    
    private func screenTitle() -> String{
       let screenTitle = self.dashboardViewModel.isJobData ? self.dashboardViewModel.jobCount : self.dashboardViewModel.totalValue
        return screenTitle
    }
}

#Preview {
    DetailListView().environmentObject(DashboardViewModel())
    
}


//MARK: Horizontal Scroll SegmentController
struct HorizontalSegMentCollectionView: View {
    
    let progressItemArray: [ProgressColorModel]
    
    let buttonTap: (Int) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15, content: {
                ForEach(0..<progressItemArray.count, id: \.self) { index in
                    
                    Button {
                        buttonTap(index)
                    } label: {
                        VStack(alignment:.leading, spacing: 8) {
                            CustomTextView(font: .headline, fontWeight: .medium, color: Color.black, titleText: "\(progressItemArray[index].productText)")
                            
                            Rectangle()
                                .fill(progressItemArray[index].selectedItem == true ? Color.gray : Color.clear)
                                .frame(height: 1.5)
                        }
                        
                        
                        
                    }
                }
            })
        }
    }
}


//MARK: Job List and Invoice List Content View

struct ListContentView: View {
    let containerHeight: CGFloat
    let firstText: String
    let secondText: String
    let thirdText: String
    var body: some View {
        RoundedRectangleView(viewHeight: containerHeight)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading,spacing: 8, content: {
                    CustomTextView(font: .caption, fontWeight: .medium, color: .gray, titleText: firstText)
                    
                    CustomTextView(font: Font.title2, fontWeight: .medium, color: .black, titleText: secondText)
                    
                    CustomDateTextView(dateText: thirdText)
                    
                })
                .padding(.all, 15)
            }
    }
}


//MARK: Generic List View to display job status and invoicestatus
struct StatusListGenericView<T: Identifiable, ReturnView: View>:View {
    let listArray:[T]
    let contentView: (T) -> ReturnView
    var body: some View {
        
        List(listArray) { data in
            contentView(data)
                .listRowSeparatorTint(Color.clear)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        
    }
}
