//
//  CharacterDetailViewController.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import UIKit
import Combine
import Kingfisher

class CharacterDetailViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var transparentImage: UIImageView!
    
    public var viewModel: CharacterDetailViewModel!
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
    }
    
    // MARK: States
    private func handleStates() {
        let stateValueHandler: (CharacterDetailState) -> Void = { [weak self] state in
            switch state {
            case .ready:
                self?.setupUI()
                self?.fillContent()
            }
        }
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    
    private func setupUI() {
        characterImage.layer.cornerRadius = 100
        characterImage.clipsToBounds = true
        characterImage.layer.borderWidth = 10
        transparentImage.isOpaque = false
        transparentImage.alpha = 0.2
        animationLabel(label: nameLabel)
    }
    
    private func animationLabel(label:UILabel) {
        label.text = ""
        var charIndex = 0
        guard let titleText = viewModel.characterDetail.name else { return }
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.15 * Double(charIndex), repeats: false) { (timer) in
                label.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    // MARK: Functions
    private func fillContent() {
        if let imageUrl = viewModel.characterDetail.image{
            characterImage.kf.setImage(with: URL(string: imageUrl))
            transparentImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        speciesLabel.text = viewModel.characterDetail.species
        genderLabel.text = viewModel.characterDetail.gender
        originLabel.text = viewModel.characterDetail.origin?.name
        locationLabel.text = viewModel.characterDetail.location?.name
        
        switch viewModel.characterDetail.status {
        case .unknown:
            characterImage.layer.borderColor = UIColor.lightGray.cgColor
            nameLabel.textColor = .lightGray
        case .alive:
            characterImage.layer.borderColor = UIColor.green.cgColor
            nameLabel.textColor = .systemGreen
        case .dead:
            characterImage.layer.borderColor = UIColor.red.cgColor
            nameLabel.textColor = .red
        case .none:
            characterImage.layer.borderColor = UIColor.white.cgColor
            nameLabel.textColor = .black
        }
    }
}
