//
//  MenuViewCell.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    var title: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupConstraints()
    }
    func setupLabel(){
        title = UILabel()
        title.textColor = .black
        title.font = .systemFont(ofSize: 14)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)

    }
    func configure(for cafe: Cafe) {
        title.text = cafe.restaurant.title
     }
    func setupConstraints(){
        NSLayoutConstraint.activate([
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        title.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
