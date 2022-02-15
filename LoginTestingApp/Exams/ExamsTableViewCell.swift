//
//  ExamsTableViewCell.swift
//  LoginTestingApp
//
//  Created by Maximus on 14.02.2022.
//

import Foundation
import UIKit

class ExamsTableViewCell: UITableViewCell {
    
    
    
    let picture: UIImageView = {
        let image = UIImageView(
            frame: .init(
                origin: .zero, size:
                        .init(width: 50, height: 50)))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let detailedText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let roundedView: UIView =  {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return  view
    }()
    
    func configure(post: Exam) {
        title.text = post.title
        date.text = post.date
        detailedText.text = post.text
    }

    
    let padding = Padding.eight
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(roundedView)
        roundedView.addSubview(title)
        roundedView.addSubview(detailedText)
        roundedView.addSubview(date)
        roundedView.addSubview(picture)
        selectionStyle = .none
        roundedView.backgroundColor = .init(white: 0.1, alpha: 0.2)
        roundedView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: padding, left: 0, bottom:padding, right: padding))
        picture.anchor(top: nil, leading: marginGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: padding, left: 0, bottom: padding, right: 0),size: .init(width: 100, height: 100))
    
        picture.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor, constant: 0).isActive = true
        title.anchor(top: marginGuide.topAnchor, leading: picture.trailingAnchor, bottom: nil , trailing: marginGuide.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: 0))
        detailedText.anchor(top: title.bottomAnchor, leading: picture.trailingAnchor, bottom: nil , trailing: marginGuide.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        date.anchor(top: detailedText.bottomAnchor, leading: picture.trailingAnchor, bottom: marginGuide.bottomAnchor , trailing: marginGuide.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
        title.text = nil
        detailedText.text = nil
        date.text = nil
    }
}

