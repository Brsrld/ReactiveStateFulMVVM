//
//  ViewController.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellableSet: Set<AnyCancellable> = []
    private let service :ServiceGenerator = Services()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = NetworkRequest(url: "https://rickandmortyapi.com/api/character", httpMethod: .GET)
        service.fetchCharacters(req: req)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                print("got my response here \(response)")
            }
            .store(in: &cancellableSet)
    }
}
