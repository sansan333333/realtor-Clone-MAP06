//
//  TitlePreviewViewController.swift
//  v3
//
//  Created by Jun on 2023-02-10.
//

import UIKit
import SDWebImage

class TitlePreviewViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.isDirectionalLockEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        //        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()
    
    private let FavourtieLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let shareLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let priceLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "$888"
        return label
    }()
    
    private let addressLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 3
        return label
    }()
    
    private let BedroomIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "bed.double.fill")
        image.tintColor = .label
        return image
    }()
    
    private let numberBedroomLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let BathroomIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "shower")
        image.tintColor = .label
        return image
    }()
    
    private let numberBathroomLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let propertyInfo: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let propertyInfoDetailes: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let MlsNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let agentInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Agent Info"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let agentImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "house")
        return image
    }()
    
    private let agentName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Agent Name"
        label.font = .systemFont(ofSize: 20, weight: .black)
        return label
    }()
    
    private let agentPhone: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "514-123-4567"
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private let agentCompany: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Agent Company"
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let agentCompanyLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "house")
        return image
    }()
    
    private let areaCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private let wholePhone: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstraints()
    }
    
    
    func configureConstraints() {
        
        view.addSubview(scrollView)
        let scrollViewContrains = [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        scrollView.addSubview(contentView)
        let contentViewConstrains = [
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        
        let propertyImageConstrains = [
            propertyImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            propertyImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            propertyImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            propertyImage.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let favouriteIconConstrains = [
            favouriteIcon.topAnchor.constraint(equalTo: propertyImage.bottomAnchor, constant: 20),
            favouriteIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
            favouriteIcon.heightAnchor.constraint(equalToConstant: 30),
            favouriteIcon.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        let priceLabelConstrains = [
            priceLabel.topAnchor.constraint(equalTo: favouriteIcon.bottomAnchor, constant: 20),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50)
        ]
        
        let addressLabelConstrains = [
            addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
            addressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50)
        ]
        
        let bedRoomIconConstrains = [
            BedroomIcon.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 30),
            BedroomIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
            BedroomIcon.heightAnchor.constraint(equalToConstant: 20),
            BedroomIcon.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let numberBedroomLabelCOnstrains = [
            numberBedroomLabel.topAnchor.constraint(equalTo: BedroomIcon.topAnchor),
            numberBedroomLabel.leftAnchor.constraint(equalTo: BedroomIcon.rightAnchor, constant: 10),
            BedroomIcon.heightAnchor.constraint(equalToConstant: 20),
            BedroomIcon.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        
        let BathroomIconConstrains = [
            BathroomIcon.topAnchor.constraint(equalTo: BedroomIcon.topAnchor),
            BathroomIcon.leftAnchor.constraint(equalTo: numberBedroomLabel.rightAnchor, constant: 10),
            BathroomIcon.heightAnchor.constraint(equalToConstant: 20),
            BathroomIcon.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let numberBathroomLabelConstrains = [
            numberBathroomLabel.topAnchor.constraint(equalTo: BathroomIcon.topAnchor),
            numberBathroomLabel.leadingAnchor.constraint(equalTo: BathroomIcon.trailingAnchor, constant: 10),
            BathroomIcon.heightAnchor.constraint(equalToConstant: 20),
            BathroomIcon.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let propertyInfoConstrains = [
            propertyInfo.topAnchor.constraint(equalTo: BedroomIcon.bottomAnchor, constant: 50),
            propertyInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
            propertyInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
            propertyInfo.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let propertyInfoDetailesConstreains = [
            propertyInfoDetailes.topAnchor.constraint(equalTo: propertyInfo.bottomAnchor, constant: 50),
            propertyInfoDetailes.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 50),
            propertyInfoDetailes.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
        ]
        
        let MlsNumberConstrains = [
            MlsNumber.topAnchor.constraint(equalTo: propertyInfoDetailes.bottomAnchor, constant: 30),
            MlsNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50)
        ]
        
        let agentInfoConstrains = [
            agentInfo.topAnchor.constraint(equalTo: MlsNumber.bottomAnchor, constant: 30),
            agentInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50)
        ]
        
        let agentImageConstrains = [
            agentImage.topAnchor.constraint(equalTo: agentInfo.bottomAnchor, constant: 30),
            agentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            agentImage.widthAnchor.constraint(equalToConstant: 100),
        ]
        
        let agentNameConstrains = [
            agentName.topAnchor.constraint(equalTo: agentImage.topAnchor, constant: 20),
            agentName.leadingAnchor.constraint(equalTo: agentImage.trailingAnchor, constant: 30),
            agentName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ]
        
        let wholePhoneConstrains = [
            wholePhone.topAnchor.constraint(equalTo: agentName.bottomAnchor, constant: 20),
            wholePhone.leadingAnchor.constraint(equalTo: agentImage.trailingAnchor, constant: 30),
            wholePhone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ]
        
        let agentCompanyLogoConstrains = [
            agentCompanyLogo.topAnchor.constraint(equalTo: agentImage.bottomAnchor, constant: 50),
            agentCompanyLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            agentCompanyLogo.heightAnchor.constraint(equalToConstant: 300),
            agentCompanyLogo.widthAnchor.constraint(equalToConstant: 300)
        ]
        
        let agentCompanyConstrains = [
            agentCompany.topAnchor.constraint(equalTo: agentCompanyLogo.bottomAnchor),
            agentCompany.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            agentCompany.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ]
        
        contentView.addSubview(propertyImage)
        contentView.addSubview(favouriteIcon)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(BedroomIcon)
        contentView.addSubview(numberBedroomLabel)
        contentView.addSubview(BathroomIcon)
        contentView.addSubview(numberBathroomLabel)
        contentView.addSubview(propertyInfo)
        contentView.addSubview(propertyInfoDetailes)
        contentView.addSubview(MlsNumber)
        contentView.addSubview(agentInfo)
        contentView.addSubview(agentImage)
        contentView.addSubview(agentName)
        contentView.addSubview(agentCompanyLogo)
        contentView.addSubview(agentCompany)
        contentView.addSubview(wholePhone)
        
        NSLayoutConstraint.activate(scrollViewContrains)
        NSLayoutConstraint.activate(contentViewConstrains)
        NSLayoutConstraint.activate(propertyImageConstrains)
        NSLayoutConstraint.activate(favouriteIconConstrains)
        NSLayoutConstraint.activate(priceLabelConstrains)
        NSLayoutConstraint.activate(addressLabelConstrains)
        NSLayoutConstraint.activate(bedRoomIconConstrains)
        NSLayoutConstraint.activate(numberBedroomLabelCOnstrains)
        NSLayoutConstraint.activate(BathroomIconConstrains)
        NSLayoutConstraint.activate(numberBathroomLabelConstrains)
        NSLayoutConstraint.activate(propertyInfoConstrains)
        NSLayoutConstraint.activate(propertyInfoDetailesConstreains)
        NSLayoutConstraint.activate(MlsNumberConstrains)
        NSLayoutConstraint.activate(agentInfoConstrains)
        NSLayoutConstraint.activate(agentImageConstrains)
        NSLayoutConstraint.activate(agentNameConstrains)
        NSLayoutConstraint.activate(agentCompanyLogoConstrains)
        NSLayoutConstraint.activate(agentCompanyConstrains)
        NSLayoutConstraint.activate(wholePhoneConstrains)
        
        //fav icon tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favouriteIconTapped))
        favouriteIcon.isUserInteractionEnabled = true
        favouriteIcon.addGestureRecognizer(tapGesture)
    }
    
    // fave icon action
    @objc func favouriteIconTapped() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newPropertyItem = PropertyItem(context: context)
        
        newPropertyItem.address = self.addressLabel.text
        newPropertyItem.price = self.priceLabel.text
        newPropertyItem.mlsNumber = self.MlsNumber.text
        
        do {
            try context.save()
            print("saved to core data")
            print(context)
            print(newPropertyItem)
        } catch {
            print("error saving to core data")
        }
    }
    
    public func configure (with model: TitlePreviewViewModel) {
        
        guard let url = URL(string: model.propertyImage) else { return }
        propertyImage.sd_setImage(with: url)
        
        favouriteIcon.image = UIImage(systemName: "heart.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        priceLabel.text = model.price
        
        addressLabel.text = model.address
        
        BedroomIcon.image = UIImage(systemName: "bed.double.fill")
        
        numberBedroomLabel.text = model.bedroomNum
        
        BathroomIcon.image = UIImage(systemName: "shower")
        
        numberBathroomLabel.text = model.bathroom
        
        propertyInfo.text = "Property Info"
        
        propertyInfoDetailes.text = model.propertyInfoDetailes
        
        MlsNumber.text = "MLS : " + model.MlsNumber
        
        agentInfo.text = "Agent Info"
        
        guard let url = URL(string: model.agentImage) else {return}
        agentImage.sd_setImage(with: url)
        
        agentName.text = model.agentName
        
        agentPhone.text = model.agentPhone
        
        areaCode.text = model.areaCode
        
        wholePhone.text = model.areaCode + "-" + model.agentPhone
        
        guard let url = URL(string: model.agentCompanyLogo) else {return}
        agentCompanyLogo.sd_setImage(with: url)
        
        agentCompany.text = model.agentCompany
    }
}
