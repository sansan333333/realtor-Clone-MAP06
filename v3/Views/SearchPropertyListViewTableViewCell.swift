//
//  SearchPropertyListViewTableViewCell.swift
//  v3
//
//  Created by Jun on 2023-02-20.
//

import UIKit


class SearchPropertyListViewTableViewCell: UITableViewCell {

    static let identifier = "SearchPropertyListViewTableViewCell"
    
    private let addressLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.lineBreakMode = .byTruncatingTail
        return lable
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(addressLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyConstraints() {
        
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
    
        NSLayoutConstraint.activate(addressLabelConstraints)
        
    }
    
    public func config(with model: ListingViewModel) {

        addressLabel.text = model.addressLable
    }
}
