//
//  StoryIconCollectionViewCell.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit
import SDWebImage

final class StoryIconCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with viewModel: StoryIconCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.sd_setImage(with: viewModel.imageURL)
    }

}
