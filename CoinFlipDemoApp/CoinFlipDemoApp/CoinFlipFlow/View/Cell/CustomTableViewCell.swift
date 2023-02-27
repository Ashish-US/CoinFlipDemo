//
//  CustomTableViewCell.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private var hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Leverage factory method to get the label
    var titleLabel = UILabel.create(with: "", style: .normal())
    var priceLabel = UILabel.create(with: "", style: .small(color: .systemGreen))
    
    var thumbNail:  UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp() {
        // add to vStack
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(priceLabel)

        // add thumbnail and vStackView
        hStackView.addArrangedSubview(thumbNail)
        hStackView.addArrangedSubview(vStackView)
        
        // add stack to content view
        contentView.addSubview(hStackView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        [thumbNail.widthAnchor.constraint(equalToConstant: 40),
        thumbNail.heightAnchor.constraint(equalToConstant: 40)].forEach {
            $0.isActive = true
        }

        [hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
         hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
         hStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
         hStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)].forEach {
            $0.isActive = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
