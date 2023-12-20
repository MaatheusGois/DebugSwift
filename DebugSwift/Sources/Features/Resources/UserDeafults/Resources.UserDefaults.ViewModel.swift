//
//  Resources.UserDefaults.ViewModel.swift
//  DebugSwift
//
//  Created by Matheus Gois on 15/12/23.
//  Copyright © 2023 apple. All rights reserved.
//

import Foundation

class ResourcesUserDefaultsViewModel: NSObject, ResourcesGenericListViewModel {

    private var keys = [String]()

    // MARK: - Initialization

    override init() {
        super.init()
        setupKeys()
    }

    private func setupKeys() {
        keys = UserDefaults.standard.dictionaryRepresentation().keys.sorted()
        if let latitudeIndex = keys.firstIndex(
            of: LocationToolkit.Constants.simulatedLatitude
        ) {
            keys.remove(at: latitudeIndex)
        }
        if let longitudeIndex = keys.firstIndex(
            of: LocationToolkit.Constants.simulatedLongitude
        ) {
            keys.remove(at: longitudeIndex)
        }
    }

    // MARK: - ViewModel

    var reloadData: (() -> Void)?

    func viewTitle() -> String {
        "User defaults"
    }

    func numberOfItems() -> Int {
        keys.count
    }

    func dataSourceForItem(atIndex index: Int) -> (title: String, value: String) {
        let key = keys[index]
        let value = "\(UserDefaults.standard.object(forKey: key) ?? "")"
        return (title: key, value: value)
    }

    func handleClearAction() {
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
        keys.removeAll()
    }

    func handleDeleteItemAction(atIndex index: Int) {
        let key = keys[index]
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
        keys.remove(at: index)
    }

    func emptyListDescriptionString() -> String {
        "empty-data".localized() + "User Defaults"
    }

    // MARK: - Search Functionality

    private var filteredKeys = [String]()

    func numberOfFilteredItems() -> Int {
        filteredKeys.count
    }

    func filteredDataSourceForItem(atIndex index: Int) -> (title: String, value: String) {
        let key = filteredKeys[index]
        let value = "\(UserDefaults.standard.object(forKey: key) ?? "")"
        return (title: key, value: value)
    }

    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredKeys = keys
        } else {
            filteredKeys = keys.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}