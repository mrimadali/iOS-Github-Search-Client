//
//  LoadingCell.swift
//  CS_iOS_Assignment
//
//  Created by Mohammad Imad Ali on 18/06/21.
//

import UIKit

class LoadingCell : UITableViewCell {
    var activityIndicator: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupSubviews() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.hidesWhenStopped = true
        
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
}
