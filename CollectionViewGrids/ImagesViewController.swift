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
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }() 
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageItem>!
    private let viewModel = ImagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        applySnapshot()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
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
        ) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionViewCell.identifier,
                for: indexPath
            ) as! ImageCollectionViewCell
            cell.configure(with: item.imageName)
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

