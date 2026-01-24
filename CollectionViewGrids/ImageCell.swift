//
//  ImageCell.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 24/1/26.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.systemBlue.cgColor
        layer.lineWidth = 3.0
        layer.isHidden = true
        return layer
    }()
    
    private let borderInset: CGFloat = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.backgroundColor = .clear
        
        // Add border layer
        contentView.layer.addSublayer(borderLayer)
        
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
        imageView.layer.cornerRadius = contentView.frame.width / 2
        
        // Update border path with inset
        let radius = (contentView.frame.width / 2) + borderInset
        let center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        borderLayer.path = path.cgPath
    }
    
    func configure(with imageName: String) {
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .systemBlue
    }
    
    func setSelected(_ selected: Bool, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.borderLayer.isHidden = !selected
                self.borderLayer.opacity = selected ? 1.0 : 0.0
            }
        } else {
            borderLayer.isHidden = !selected
            borderLayer.opacity = selected ? 1.0 : 0.0
        }
    }
}
