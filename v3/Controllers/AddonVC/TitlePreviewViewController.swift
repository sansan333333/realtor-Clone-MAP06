//
//  TitlePreviewViewController.swift
//  v3
//
//  Created by Jun on 2023-02-10.
//

import UIKit
import SDWebImage

class TitlePreviewViewController: UIViewController {

    private let propertyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "house")
        return imageView
    }()
    
    private let favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()
    
    private let shareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        return imageView
    }()
    
//    private let priceLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "$888"
//        return label
//    }()
//
//    private let numberBedroomLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .light)
//        label.text = "1"
//        return label
//    }()
//
//    private let numberwBathroomLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .light)
//        label.text = "1"
//        return label
//    }()
//
//    private let addressLabel: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .light)
//        label.text = "$888"
//        return label
//    }()
//
//    private let propertyAddress: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "Property Address"
//        return label
//    }()
//
//    private let propertyInfo: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "Property Info"
//        return label
//    }()
//
//    private let propertyType: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "Property Type"
//        return label
//    }()
//
//    private let propertySize: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "Property size"
//        return label
//    }()
//
//
//    private let generalDescription: UILabel = {
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.text = "General Description"
//        return label
//    }()
//
//    private let moreButton: UIButton = {
//
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .red
//        button.setTitle("More", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.layer.masksToBounds = true
//        return button
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(propertyImage)
        view.addSubview(favouriteIcon)
        view.addSubview(shareIcon)
//        view.addSubview(priceLabel)
//        view.addSubview(numberBedroomLabel)
//        view.addSubview(numberwBathroomLabel)
//        view.addSubview(addressLabel)
//        view.addSubview(propertyAddress)
//        view.addSubview(propertyInfo)
//        view.addSubview(propertyType)
//        view.addSubview(propertySize)
//        view.addSubview(generalDescription)
//        view.addSubview(moreButton)
        
        configureConstraints()
    }

    func configureConstraints() {
        let propertyImageConstrains = [
            propertyImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            propertyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            propertyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            propertyImage.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let favouriteIconConstrains = [
            favouriteIcon.topAnchor.constraint(equalTo: propertyImage.bottomAnchor, constant: 10),
            favouriteIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            favouriteIcon.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let shareIconConstrains = [
            shareIcon.topAnchor.constraint(equalTo: propertyImage.bottomAnchor, constant: 10),
            shareIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            favouriteIcon.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        
        
        
        
        NSLayoutConstraint.activate(propertyImageConstrains)
        NSLayoutConstraint.activate(favouriteIconConstrains)
        NSLayoutConstraint.activate(shareIconConstrains)
    }
    
    public func configure (with model: TitlePreviewViewModel) {
        
        guard let url = URL(string: model.propertyImage) else { return }
        propertyImage.sd_setImage(with: url)
        
        favouriteIcon.image = UIImage(named: model.favouriteIcon)
        shareIcon.image = UIImage(named: model.shareIcon)
    }
}
