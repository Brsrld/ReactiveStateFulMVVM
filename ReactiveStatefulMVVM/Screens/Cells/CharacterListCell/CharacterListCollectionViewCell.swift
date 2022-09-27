//
//  CharacterListCollectionViewCell.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit
import Kingfisher

class CharacterListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    // MARK: Properties
    private var viewModel: CharacterListCellViewModel?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(viewModel: CharacterListCellViewModel) {
        self.viewModel = viewModel
        backgroundColor = .white
        fillContent()
    }
    
    private func fillContent() {
        characterImage.kf.setImage(with: viewModel?.imageURl)
        nameLabel.text = viewModel?.characterName
        speciesLabel.text = viewModel?.characterSpecies.rawValue
        genderLabel.text = viewModel?.characterGender.rawValue
        
        switch viewModel?.characterStatus {
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
