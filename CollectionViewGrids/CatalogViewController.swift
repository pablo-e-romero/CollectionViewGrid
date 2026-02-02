//
//  CatalogViewController.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 25/1/26.
//

import UIKit

class CatalogViewController: UIViewController {
    enum LayoutOption: String, CaseIterable {
        case imagesGrid = "Images Grid"
        case centerButton = "Center Button"
        case stackView = "Stack view"
        
        var viewController: UIViewController {
            switch self {
            case .imagesGrid:
                return ImagesViewController()
            case .centerButton:
                return CenterButtonViewController()
            case .stackView:
                return StackViewViewController()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CatalogCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Compositional Layout Catalog"
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LayoutOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell", for: indexPath)
        let option = LayoutOption.allCases[indexPath.row]
        cell.textLabel?.text = option.rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = LayoutOption.allCases[indexPath.row]
        let viewController = option.viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
