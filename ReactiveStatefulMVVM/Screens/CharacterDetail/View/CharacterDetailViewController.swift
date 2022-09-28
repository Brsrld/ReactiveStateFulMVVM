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
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    public var viewModel: CharacterDetailViewModel!
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleStates()
    }
    
    private func handleStates() {
        let stateValueHandler: (CharacterDetailState) -> Void = { [weak self] state in
            switch state {
            case .ready:
                self?.fillContent()
            }
        }
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    
    private func fillContent() {
        if let imageUrl = viewModel.characterDetail.image{
            characterImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        nameLabel.text = viewModel?.characterDetail.name
        speciesLabel.text = viewModel?.characterDetail.species?.rawValue
        genderLabel.text = viewModel?.characterDetail.gender?.rawValue
        originLabel.text = viewModel?.characterDetail.origin?.name
        locationLabel.text = viewModel?.characterDetail.location?.name
        
        switch viewModel?.characterDetail.status {
        case .unknown:
            view.backgroundColor = .gray
        case .alive:
            view.backgroundColor = .green
        case .dead:
            view.backgroundColor = .red
        case .none:
            view.backgroundColor = .white
        }
    }
}
