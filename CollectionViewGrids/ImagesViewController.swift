//
//  ViewController.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 24/1/26.
//

import UIKit

class ImagesViewController: UIViewController {
    enum Section {
        case main
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        return collectionView
    }() 
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageItem>!
    private let viewModel = ImagesViewModel()
    private var selectedItem: ImageItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        applySnapshot()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            return self?.createSection(layoutEnvironment: layoutEnvironment)
        }
        return layout
    }
    
    private func createSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        func makeCalculationsStrategy(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            // Calculate item size proportionally to screen width
            // As screen size increases, cell size increases proportionally
            let columns: Int = 4
            let spacing: CGFloat = 16
            let containerWidth = layoutEnvironment.container.effectiveContentSize.width
            let totalSpacing = spacing * CGFloat(columns + 1)
            let itemWidth = (containerWidth - totalSpacing) / CGFloat(columns)
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .absolute(itemWidth)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(itemWidth)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(
                top: spacing,
                leading: spacing,
                bottom: spacing,
                trailing: spacing
            )
            
            return section
        }
        
        func useFractionalStrategy(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let spacing: CGFloat = 16
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.25),
                heightDimension: .fractionalWidth(0.25)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.25)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(
                top: spacing,
                leading: spacing,
                bottom: spacing,
                trailing: spacing
            )
            
            return section
        }
        
//        return useFractionalStrategy(layoutEnvironment: layoutEnvironment)
        return makeCalculationsStrategy(layoutEnvironment: layoutEnvironment)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ImageItem>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCell.identifier,
                for: indexPath
            ) as! ImageCell
            cell.configure(with: item.imageName)
            
            // Update selection state
            let isSelected = self?.selectedItem?.id == item.id
            cell.setSelected(isSelected ?? false, animated: false)
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { [weak self] _ in
            guard let self = self else { return }
            // Invalidate layout when screen size changes to recalculate cell sizes proportionally
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            applySnapshot()
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        // Deselect previous item
        if let previousItem = selectedItem,
           let previousIndexPath = dataSource.indexPath(for: previousItem),
           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? ImageCell {
            previousCell.setSelected(false, animated: true)
        }
        
        // Select new item
        selectedItem = item
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            cell.setSelected(true, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            cell.setSelected(false, animated: true)
        }
        if let item = dataSource.itemIdentifier(for: indexPath),
           selectedItem?.id == item.id {
            selectedItem = nil
        }
    }
}

