//
//  AboutMeCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit

private let ABOUT_ME_TOP_OFFSET: CGFloat = 10 * SCREEN_SCALE_BY_HEIGHT
private let ABOUT_ME_LEFT_OFFSET: CGFloat = 30
private let ABOUT_ME_FONT_SIZE: CGFloat = 24 * SCREEN_SCALE_BY_HEIGHT
private let ABOUT_ME_TEXT_VIEW_HORIZONTAL_OFFSETS: CGFloat = 30
private let ABOUT_ME_TEXT_VIEW_HEIGHT: CGFloat = 250 * SCREEN_SCALE_BY_HEIGHT
private let ABOUT_ME_TEXT_VIEW_TOP_OFFSET: CGFloat = 10 * SCREEN_SCALE_BY_HEIGHT
private let ABOUT_ME_TEXT_VIEW_FONT_SIZE: CGFloat = 14 * SCREEN_SCALE_BY_HEIGHT
private let SAVE_CHANGES_BUTTON_HORIZONTAL_OFFSETS: CGFloat = 30
private let SAVE_CHANGES_BUTTON_BOTTOM_OFFSET: CGFloat = 10 * SCREEN_SCALE_BY_HEIGHT
private let SAVE_CHANGES_BUTTON_HEIGHT: CGFloat = 56 * SCREEN_SCALE_BY_HEIGHT
private let SAVE_CHANGES_BUTTON_TOP_OFFSET: CGFloat = 30 * SCREEN_SCALE_BY_HEIGHT

final class AboutMeCell: UITableViewCell {
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProDisplayRegular(size: ABOUT_ME_FONT_SIZE)
        label.text = Localizable.about_me_label_title()
        label.textColor = Colors.miniColor()
        return label
    }()
    
    private lazy var aboutMeTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black.withAlphaComponent(0.5)
//        tv.font = Fonts.sfProDisplayRegular(size: ABOUT_ME_TEXT_VIEW_FONT_SIZE)
        tv.layer.cornerRadius = 10
        tv.backgroundColor = Colors.miniColor()
        tv.text = Localizable.about_me_text_view_placeholder()
        tv.delegate = self
        
        return tv
    }()
    
    private lazy var saveChagesButton = AppButton(withTitle: Localizable.save_changes_button_title())

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

//MARK: - Private methods
extension AboutMeCell {
    func setupUI() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = Colors.mainColor()
        
        contentView.addSubview(aboutMeLabel)
        contentView.addSubview(aboutMeTextView)
        contentView.addSubview(saveChagesButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        aboutMeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ABOUT_ME_TOP_OFFSET)
            $0.left.equalToSuperview().offset(ABOUT_ME_LEFT_OFFSET)
        }
        
        aboutMeTextView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(ABOUT_ME_TEXT_VIEW_HORIZONTAL_OFFSETS)
            $0.top.equalTo(aboutMeLabel.snp.bottom).offset(ABOUT_ME_TEXT_VIEW_TOP_OFFSET)
            $0.height.equalTo(ABOUT_ME_TEXT_VIEW_HEIGHT)
        }
        
        saveChagesButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(SAVE_CHANGES_BUTTON_HORIZONTAL_OFFSETS)
            $0.bottom.equalToSuperview().inset(SAVE_CHANGES_BUTTON_BOTTOM_OFFSET)
            $0.height.equalTo(SAVE_CHANGES_BUTTON_HEIGHT)
            $0.top.equalTo(aboutMeTextView.snp.bottom).offset(SAVE_CHANGES_BUTTON_TOP_OFFSET)
        }
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
