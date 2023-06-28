//
//  TableViewCell.swift
//  myM15.5
//
//  Created by Антон Казеннов on 12.01.2023.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {

    lazy var imageC: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.backgroundColor = UIColor.green
        image.layer.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1).cgColor
        return image
    }()
    
     lazy var header: UILabel = {
        let text = UILabel()
        return text
    }()
    
     lazy var text: UILabel = {
        let text = UILabel()
        text.numberOfLines = .zero
        return text
    }()
    
    private lazy var timeLabel: UILabel = {
        let text = UILabel()
        return text
    }()
    
    lazy var firstline: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(header)
        stack.addArrangedSubview(timeLabel)
        return stack
     }()
    
    private lazy var stackV: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(firstline)
        stack.spacing = 5
        stack.addArrangedSubview(text)
        
        
        return stack
    }()
    private lazy var stackH: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.addArrangedSubview(imageC)
        stack.spacing = 10
        stack.addArrangedSubview(stackV)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "myTable")
        stackH.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackH)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        imageC.image = nil
    }
    
    private func setupConstraints() {
        imageC.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        stackH.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
