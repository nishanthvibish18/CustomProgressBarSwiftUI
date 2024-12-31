//
//  DashboardViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 03/07/24.
//

import Foundation
import SwiftUI
import SampleData


class DashboardViewModel: ObservableObject{
    @Published var invoiceAPIModelArray: [InvoiceApiModel] = []
    @Published var  jobAPIModelArray: [JobApiModel] = []
    @Published var jobCount: String = ""
    @Published var jobCompletedCount: String = ""
    @Published var totalValue: String = ""
    @Published var collectedValue: String = ""
    @Published var jobProgressArray: [ProgressColorModel] = []
    @Published var invoiceProgressArray: [ProgressColorModel] = []
    @Published var isJobData: Bool = true
    @Published var dataListEnums: DataListEnum = .invoiceListArray([])
    
    @Published var navigationPath = NavigationPath()
    
    func updateData(){
        self.jobProgressArray = []
        self.invoiceProgressArray = []
        jobAPIModelArray = SampleData.generateRandomJobList(size: 50)
        invoiceAPIModelArray = SampleData.generateRandomInvoiceList(size: 20)
        self.jobCount = "\(jobAPIModelArray.count) Jobs"
        self.jobCompletedCount = "\(jobAPIModelArray.filter({$0.status == .completed}).count) of \(jobAPIModelArray.count) completed"
        self.totalValue = "Total Value ($\(invoiceAPIModelArray.reduce(0) {$0 + ($1.total)}))"
        self.collectedValue = "$\(invoiceAPIModelArray.filter({$0.status == .paid}).reduce(0) {$0 + ($1.total)}) collected"
        
        self.progressBarUpdate()
        
    }
    
    
//    MARK: Here Looping Job Status enum and sorting array
    private func progressBarUpdate(){
        for item in JobStatus.allCases{
            self.jobStatusProgressBarUpdate(status: item)
        }
        for invoiceStatus in InvoiceStatus.allCases{
            self.invoiceStatus(invoiceStatus: invoiceStatus)
        }
        self.jobProgressArray = self.jobProgressArray.sorted(by: {$0.barSize > $1.barSize})
        self.invoiceProgressArray = self.invoiceProgressArray.sorted(by: {$0.barSize > $1.barSize})
    }
    
//    MARK: Adding Job Status Progress Bar Array
    private func jobStatusProgressBarUpdate(status: JobStatus){
        let filterItems = self.jobAPIModelArray.filter({$0.status == status})
        let percentage = self.calculatePercentage(itemCount: filterItems.count, array: self.jobAPIModelArray)
        let itemCount = "\(String(describing: status)) (\(filterItems.count))"
        
        self.jobProgressArray.append(ProgressColorModel(barColor: self.jobProgressColor(status: status), barSize: percentage, productText: itemCount, selectedItem: false, status: String(describing: status)))
    }
    
//    MARK: Adding Inovice Status Bar Array
    private func invoiceStatus(invoiceStatus: InvoiceStatus){
        let invoiceArray = self.invoiceAPIModelArray.filter({$0.status == invoiceStatus})
        let percentageCalulator = self.calculatePercentage(itemCount: invoiceArray.count, array: self.invoiceAPIModelArray)
        let priceCount = "\(String(describing: invoiceStatus)) ($\(invoiceArray.reduce(0) {$0 + ($1.total)}))"
        self.invoiceProgressArray.append(ProgressColorModel(barColor: self.invoicePercentageColor(status: invoiceStatus), barSize: percentageCalulator, productText: priceCount, selectedItem: false, status: String(describing: invoiceStatus)))
    }
    
//    MARK: Job Status Bar Color Condition
    private func jobProgressColor(status: JobStatus) -> Color{
        switch status {
        case .yetToStart:
            return Color.lightPurpleColor
        case .inProgress:
            return Color.lightBlueColor
        case .canceled:
            return Color.lightYellowColor
        case .completed:
            return Color.lightGreenColor
        case .incomplete:
            return Color.lightRedColor
        }
    }
    
    
//    MARK: Invoice Status Bar Color Condition
    private func invoicePercentageColor(status: InvoiceStatus) -> Color{
        switch status {
        case .draft:
            return Color.lightYellowColor
        case .pending:
            return Color.lightBlueColor
        case .paid:
            return Color.lightGreenColor
        case .badDebt:
            return Color.lightRedColor
        }
    }
    
//    MARK: Here we are passing generic array because we need to calculate 2 different array progress bar width
    private func calculatePercentage<T>(itemCount: Int, array: [T]) -> Double{
     return ((Double(itemCount) / Double(array.count)) * 100) / 100
    }
    
    
//    MARK: Update SegmentController ButtonValue
    
    func updateButtonValue(index: Int){
        
        if(isJobData){
            for i in 0..<jobProgressArray.count {
                jobProgressArray[i].selectedItem = false
            }
            self.jobProgressArray[index].selectedItem = true
            self.dataListEnums = .jobsListArray(self.jobAPIModelArray.filter({String(describing: $0.status) == self.jobProgressArray[index].status}))
        }
        else{
            for i in 0..<invoiceProgressArray.count {
                invoiceProgressArray[i].selectedItem = false
            }
            self.invoiceProgressArray[index].selectedItem = true
            self.dataListEnums = .invoiceListArray(self.invoiceAPIModelArray.filter({String(describing: $0.status) == self.invoiceProgressArray[index].status}))
        }

    }
    
}




