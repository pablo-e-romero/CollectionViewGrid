//
//  ImageCollectionViewCell.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 24/1/26.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make the image view circular
        contentView.layer.cornerRadius = contentView.frame.width / 2
    }
    
    func configure(with imageName: String) {
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .systemBlue
    }
}
