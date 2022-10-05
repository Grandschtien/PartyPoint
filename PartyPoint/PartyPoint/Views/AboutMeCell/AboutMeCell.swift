//
//  AboutMeCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit

final class AboutMeCell: UITableViewCell {
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProDisplayRegular(size: 24)
        label.text = Localizable.about_me_label_title()
        label.textColor = Colors.miniColor()
        return label
    }()
    
    private lazy var aboutMeTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black.withAlphaComponent(0.5)
        tv.font = Fonts.sfProDisplayRegular(size: 14)
        tv.layer.cornerRadius = 10
        tv.backgroundColor = Colors.miniColor()
        tv.text = Localizable.about_me_text_view_placeholder()
        tv.delegate = self
        
        return tv
    }()
    private lazy var saveChagesButton: AppButton = {
        let btn = AppButton(withTitle: Localizable.save_changes_button_title())
        
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = Colors.mainColor()
        contentView.addConstrained(subview: aboutMeLabel, top: 10, left: 30, bottom: nil, right: nil)
        
        contentView.addConstrained(subview: aboutMeTextView, top: nil, left: 30, bottom: nil, right: -30)
        
        aboutMeTextView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        aboutMeTextView.topAnchor.constraint(
            equalTo: aboutMeLabel.bottomAnchor,
            constant: 10
        ).isActive = true
    
        contentView.addConstrained(
            subview: saveChagesButton,
            top: nil,
            left: 30,
            bottom: -10,
            right: -30
        )
        saveChagesButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        saveChagesButton.topAnchor.constraint(
            equalTo: aboutMeTextView.bottomAnchor,
            constant: 30
        ).isActive = true
    }
}
extension AboutMeCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .black.withAlphaComponent(0.5) {
            textView.text = nil
            textView.textColor = Colors.mainColor()
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Localizable.about_me_text_view_placeholder()
            textView.textColor = .black.withAlphaComponent(0.5)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
