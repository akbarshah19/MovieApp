//
//  MovieDetailsInfoTableViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/2/23.
//

import UIKit

class MovieDetailsInfoTableViewCell: UITableViewCell {
    static let identifier = "MovieDetailsInfoTableViewCell"
    private var subTitle: String = ""
    
    let textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
    
    func configure(subTitle: String) {
        self.subTitle = subTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = CGRect(x: 10, y: 10, width: contentView.width - 20, height: contentView.height - 20)
    }
}
