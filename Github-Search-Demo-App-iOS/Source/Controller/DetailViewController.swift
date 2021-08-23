//
//  DetailViewController.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Class private variables
    var repoItem: Item!
    var index: Int!
    
    // MARK: - UI elements lazy initialization
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AppFont.medium, size: 16)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AppFont.regular, size: 14)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
        
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AppFont.italic, size: 14)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: AppFont.regular, size: 14)
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: AppFont.bold, size: 15)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private lazy var dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: AppFont.bold, size: 15)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        return button
    }()
    
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        updateLabels()
    }
    
    // MARK: - Class private methods
    private func setupConstraints() {
        view.addSubview(avatarImage)
        view.addSubview(ownerNameLabel)
        view.addSubview(creationDateLabel)
        view.addSubview(languageLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(likeButton)
        view.addSubview(dislikeButton)
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            ownerNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            ownerNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            ownerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ownerNameLabel.heightAnchor.constraint(equalToConstant: 25),
            creationDateLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 10),
            creationDateLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            creationDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            creationDateLabel.heightAnchor.constraint(equalToConstant: 20),
            languageLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            languageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            languageLabel.heightAnchor.constraint(equalToConstant: 20),
            descriptionTextView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 140),
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            likeButton.widthAnchor.constraint(equalToConstant: 140),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            dislikeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dislikeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            dislikeButton.widthAnchor.constraint(equalToConstant: 150),
            dislikeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func updateLabels() {
        view.backgroundColor = .white
        navigationItem.title = repoItem.name
        navigationItem.backButtonTitle = Constants.navBackButtonTitle
        if let avatarURL = repoItem.owner.avatarURL {
            let processor = RoundCornerImageProcessor(cornerRadius: 50)
            let url = URL(string: avatarURL)
            avatarImage.kf.setImage(with: url, placeholder: nil, options: [.processor(processor)])
        }
        if let user = repoItem.owner.loginName {
            ownerNameLabel.text = "Owner: \(user)"
        }
        if let created_at = repoItem.creationDate?.displayDateWithTime() {
            creationDateLabel.text = "Created at: \(created_at)"
        }
        if let language = repoItem.language, let count = repoItem.starCount {
            let formatCount = Utils.formatNumber(count)
            languageLabel.text  = "\(language)  |  ☆ \(formatCount)"
        }else {
            languageLabel.text  = repoItem.language
        }
        descriptionTextView.text = repoItem.description
        likeButton.setTitle(Constants.likeButtonTitle, for: .normal)
        dislikeButton.setTitle(Constants.dislikeButtonTitle, for: .normal)
        
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeAction), for: .touchUpInside)
    }
    
    @objc func likeAction() {
        NotificationCenter.default.post(name: NSNotification.Name(Constants.likeNotifications), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dislikeAction() {
        NotificationCenter.default.post(name: NSNotification.Name(Constants.dislikeNotifications), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
}
