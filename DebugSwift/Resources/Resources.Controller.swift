//
//  Resources.Controller.swift
//  DebugSwift
//
//  Created by Matheus Gois on 14/12/23.
//  Copyright © 2023 apple. All rights reserved.
//

import UIKit

final class ResourcesViewController: BaseController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorColor = .gray

        return tableView
    }()

    private let items = ["Files", "User Defaults", "Keychain"] // TODO: - "CoreData", "Cookies"

    override init() {
        super.init()
        setupTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }

    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: .cell
        )

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupTabBar() {
        title = "Resources"
        tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: "filemenu.and.selection"),
            tag: 2
        )
    }
}
extension ResourcesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: .cell,
            for: indexPath
        )
        cell.setup(title: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller: UIViewController?
        switch indexPath.row {
        case 0:
            // Handle "File" selection
            controller = ResourcesFilesViewController()
        case 1:
            let viewModel = ResourcesUserDefaultsViewModel()
            controller = ResourcesGenericController(viewModel: viewModel)
        case 2:
            let viewModel = ResourcesKeychainViewModel()
            controller = ResourcesGenericController(viewModel: viewModel)
        case 3:
            // Handle "CoreData" selection
            showAlert(with: "TODO")

        case 4:
            // Handle "Cookies" selection
            showAlert(with: "TODO")

        default:
            break
        }
        if let controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
