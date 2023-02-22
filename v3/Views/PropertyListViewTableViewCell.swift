//
//  CollectionViewTableViewCell.swift
//  v3
//
//  Created by Jun on 2023-02-07.
//

import UIKit
import SDWebImage

class PropertyListViewTableViewCell: UITableViewCell {
    
    static let identifier = "PropertyListViewTableViewCell"
    
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
        let listImageConstraints = [
            listingImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listingImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listingImage.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let priceLableConstraints = [
            priceLable.topAnchor.constraint(equalTo: listingImage.bottomAnchor, constant: 20),
            priceLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: priceLable.bottomAnchor,constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(listImageConstraints)
        NSLayoutConstraint.activate(priceLableConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
    }
    
    public func config(with model: ListingViewModel) {
        guard let url = URL(string: model.ListImageURL) else {return}
        listingImage.sd_setImage(with: url)
        priceLable.text = model.priceLabel
        addressLabel.text = model.addressLable
    }
}
