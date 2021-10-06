//
//  CardView.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import UIKit

class CardView: UIView {

    private let margin: CGFloat = 30
    var card: Card?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subTitleLabelWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
    }()
    
    lazy var subTitleLabelAbilities: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    lazy var subTitleLabelExp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    let weightStack = HorizontalStackView(arrangedSubviews: [])
    let expStack = HorizontalStackView(arrangedSubviews: [])
    let abilitiesStack = HorizontalStackView(arrangedSubviews: [], spacing: 20)
    
    required init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }

    private func setup() {
        guard let card = card else { return }

        card.items.forEach { item in
            switch item.title {
            case "Base Experience":
                subTitleLabelExp.text = item.title
                let label = UILabel()
                label.textAlignment = .right
                label.text = item.description
                label.font = UIFont.boldSystemFont(ofSize: 24)
                expStack.addArrangedSubview(label)
            case "Weight":
                subTitleLabelWeight.text = item.title
                let label = UILabel()
                label.textAlignment = .right
                label.text = item.description
                label.font = UIFont.boldSystemFont(ofSize: 24)
                weightStack.addArrangedSubview(label)
            case "Abilities":
                subTitleLabelAbilities.text = item.title
                let arrayAbilities = item.description.words.map{String($0)}
                buildAbilities(arrayAbilities)
            default:
                print("")
            }
        }

        titleLabel.text = card.title
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    private func buildAbilities(_ abilities: [String]) {
        abilities.forEach { abilities in
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = .darkGray
            label.text = abilities.capitalized
            label.backgroundColor = .init(white: 0.5, alpha: 0.1)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 7
            abilitiesStack.addArrangedSubview(label)
        }
    }

    private func setupUI() {
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: margin * 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true
        
        // TODO: Display pokemon info (eg. types, abilities)
        
        let stackTitles = HorizontalStackView(arrangedSubviews: [subTitleLabelWeight, UIView(), subTitleLabelExp])
        let expWeightStack = HorizontalStackView(arrangedSubviews: [weightStack, UIView(), expStack])
        let stackTitleAbilities = VerticalStackView(arrangedSubviews: [subTitleLabelAbilities])
        
        addSubview(stackTitles)
        stackTitles.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor , bottom: nil, trailing: trailingAnchor, padding: .init(top: margin, left: margin, bottom: 0, right: margin))
        
        addSubview(expWeightStack)
        expWeightStack.anchor(top: stackTitles.bottomAnchor, leading: leadingAnchor , bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: margin, bottom: 0, right: margin))
        
        stackTitleAbilities.alignment = .leading
        addSubview(stackTitleAbilities)
        stackTitleAbilities.anchor(top: expWeightStack.bottomAnchor, leading: leadingAnchor , bottom: nil, trailing: trailingAnchor, padding: .init(top: margin, left: margin, bottom: 0, right: margin))
        
        abilitiesStack.distribution = .fillEqually
        abilitiesStack.alignment = .center
        addSubview(abilitiesStack)
        abilitiesStack.anchor(top: stackTitleAbilities.bottomAnchor, leading: leadingAnchor , bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: margin, bottom: 0, right: margin))
    }

}
