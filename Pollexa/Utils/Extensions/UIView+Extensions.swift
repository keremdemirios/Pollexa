//
//  UIView+Extensions.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import Foundation


import UIKit

extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeading: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingTrailing: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperview(
        topPadding: CGFloat = 0, leadingPadding: CGFloat = 0,
        bottomPadding: CGFloat = 0, trailingPadding: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(
            top: view.topAnchor, leading: view.leadingAnchor,
            bottom: view.bottomAnchor, trailing: view.trailingAnchor,
            paddingTop: topPadding, paddingLeading: leadingPadding,
            paddingBottom: bottomPadding, paddingTrailing: trailingPadding
        )
    }
    
    func setSize(
        height: CGFloat, width: CGFloat
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func makeBorder(color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
    }
    
    func addShadow(shadowColor: UIColor = .black) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.40
        layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        layer.masksToBounds = false
    }
    
    func makeCircle(radius: CGFloat) {
        setSize(height: radius * 2, width: radius * 2)
        layer.cornerRadius = radius
    }
    
    // MARK: Add Subviews
    func addSubViews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
    
    // MARK: Pin To Edges
    func pinToEdgesOf(view: UIView){
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: Setup Label Container
    func setupLabelContainer(label: UILabel, color: UIColor, alpha: Double) {
        self.backgroundColor = color.withAlphaComponent(alpha)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8.0
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: padding / 2),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding / 2),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
}


