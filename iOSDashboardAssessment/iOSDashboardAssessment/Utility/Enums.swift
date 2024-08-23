//
//  Enums.swift
//  iOSDashboardAssessment
//
//  Created by Nishanth on 05/07/24.
//

import Foundation
import SampleData

enum DataListEnum{
    case jobsListArray([JobApiModel])
    case invoiceListArray([InvoiceApiModel])
}


enum NavigationPathEnum: Hashable{
    case datadetailview
}
