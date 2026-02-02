//
//  StackViewViewController.swift
//  CollectionViewGrids
//
//  Created by Pablo Romero on 25/1/26.
//

import UIKit

class StackViewViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addUIElements()
    }
    
    private func setupUI() {
        title = "Stack View"
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    private func addUIElements() {
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Stack View"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)
        
        // Image View
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.addArrangedSubview(imageView)
        
        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.text = """
                                This is a description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically. This is a 
                                description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically. This is a 
                                description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically. This is a 
                                description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically. This is a 
                                description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically. This is a 
                                description label showing how 
                                UIStackView can organize multiple UI 
                                elements vertically.
                                """
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(descriptionLabel)
        
        // Primary Button
        let primaryButton = UIButton(type: .system)
        primaryButton.setTitle("Primary Action", for: .normal)
        primaryButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        primaryButton.backgroundColor = .systemBlue
        primaryButton.setTitleColor(.white, for: .normal)
        primaryButton.layer.cornerRadius = 10
        primaryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(primaryButton)
        
        // Secondary Button
        let secondaryButton = UIButton(type: .system)
        secondaryButton.setTitle("Secondary Action", for: .normal)
        secondaryButton.titleLabel?.font = .systemFont(ofSize: 16)
        secondaryButton.setTitleColor(.systemBlue, for: .normal)
        secondaryButton.layer.borderWidth = 1
        secondaryButton.layer.borderColor = UIColor.systemBlue.cgColor
        secondaryButton.layer.cornerRadius = 10
        secondaryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(secondaryButton)
        
        // Info Label
        let infoLabel = UILabel()
        infoLabel.text = "Info Section"
        infoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        infoLabel.textColor = .label
        stackView.addArrangedSubview(infoLabel)
        
        // Multiple small labels
        for i in 1...5 {
            let itemLabel = UILabel()
            itemLabel.text = "• Item \(i)"
            itemLabel.font = .systemFont(ofSize: 14)
            itemLabel.textColor = .label
            stackView.addArrangedSubview(itemLabel)
        }
        
        // Another Image
        let secondImageView = UIImageView()
        secondImageView.image = UIImage(systemName: "heart.fill")
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.tintColor = .systemRed
        secondImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stackView.addArrangedSubview(secondImageView)
        
        // Footer Label
        let footerLabel = UILabel()
        footerLabel.text = "Scroll to see more content!"
        footerLabel.font = .systemFont(ofSize: 14, weight: .medium)
        footerLabel.textAlignment = .center
        footerLabel.textColor = .tertiaryLabel
        stackView.addArrangedSubview(footerLabel)
    }
    
    @objc private func primaryButtonTapped() {
        print("Primary button tapped!")
        let alert = UIAlertController(title: "Primary Action", message: "You tapped the primary button!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func secondaryButtonTapped() {
        print("Secondary button tapped!")
        let alert = UIAlertController(title: "Secondary Action", message: "You tapped the secondary button!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
