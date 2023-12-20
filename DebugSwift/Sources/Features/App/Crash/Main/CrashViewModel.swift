//
//  CrashViewController.swift
//  DebugSwift
//
//  Created by Matheus Gois on 19/12/23.
//

import UIKit
import Foundation

class CrashViewModel: NSObject {

    var data: [CrashModel] {
        CrashManager.recover(ofType: .nsexception) +
        CrashManager.recover(ofType: .signal)
    }

    // MARK: - ViewModel

    func viewTitle() -> String {
        "actions-crash".localized()
    }

    func numberOfItems() -> Int {
        data.count
    }

    func dataSourceForItem(atIndex index: Int) -> (title: String, value: String) {
        let trace = data[index]
        return (title: trace.details.name, value: "")
    }

    func handleClearAction() {
        CrashManager.deleteAll(ofType: .nsexception)
        CrashManager.deleteAll(ofType: .signal)
    }

    func handleDeleteItemAction(atIndex index: Int) {
        let crash = data[index]
        CrashManager.delete(crash: crash)
    }

    func emptyListDescriptionString() -> String {
        "empty-data".localized() + viewTitle()
    }
}