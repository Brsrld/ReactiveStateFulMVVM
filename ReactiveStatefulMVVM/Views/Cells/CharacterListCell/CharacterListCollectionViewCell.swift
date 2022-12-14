//
//  CharacterListCollectionViewCell.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit
import Combine

class CharacterListCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var viewModel: CharacterListCellViewModel?
    
    // MARK: Functions
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(viewModel: CharacterListCellViewModel) {
        self.viewModel = viewModel
        fillContent()
    }
        
    private func fillContent() {
        characterImage.clipsToBounds = true
        characterImage.layer.cornerRadius = 8
        characterImage.image = viewModel?.getImage(imageView: characterImage)
        nameLabel.text = viewModel?.characterDetail?.name
        contentView.layer.cornerRadius = 8
        
        switch viewModel?.characterDetail?.status {
        case .unknown:
            contentView.backgroundColor = .gray
        case .alive:
            contentView.backgroundColor = .green
        case .dead:
            contentView.backgroundColor = .red
        case .none:
            contentView.backgroundColor = .white
        }
    }
}
