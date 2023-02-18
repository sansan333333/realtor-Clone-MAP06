//
//  CoreDataTableViewCell.swift
//  v3
//
//  Created by Jun on 2023-02-17.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {

    static let identifier = "CoreDataTableViewCell"
    
    private let listingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let priceLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let addressLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.lineBreakMode = .byTruncatingTail
        lable.numberOfLines = 3
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(listingImage)
        contentView.addSubview(priceLable)
        contentView.addSubview(addressLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyConstraints() {
        let listingImageConstrains = [
            listingImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listingImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let priceLableConstrains = [
            priceLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            priceLable.leadingAnchor.constraint(equalTo: listingImage.trailingAnchor, constant: 30)
        ]
        
        let addressLabelConstrains = [
            addressLabel.topAnchor.constraint(equalTo: priceLable.bottomAnchor, constant: 30),
            addressLabel.leadingAnchor.constraint(equalTo: listingImage.trailingAnchor, constant: 30),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(listingImageConstrains)
        NSLayoutConstraint.activate(priceLableConstrains)
        NSLayoutConstraint.activate(addressLabelConstrains)
    }
    
    public func config(with model: ListingViewModel) {
        guard let url = URL(string: model.ListImageURL) else {return}
        listingImage.sd_setImage(with: url)
        
        priceLable.text = model.priceLabel
        addressLabel.text = model.addressLable
    }
}
