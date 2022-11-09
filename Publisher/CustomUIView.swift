//
//  CustomUIView.swift
//  Publisher
//
//  Created by npc on 2022/11/09.
//

import UIKit
import Combine

class CustomUIView: UIView {
    
    @IBOutlet private weak var messageLabel: UILabel!
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: ContentViewModel? {
        didSet {
            if oldValue !== viewModel {
                guard let viewModel else { return }
                viewModel.$displayingLabel
                    .map { Optional($0) }
                    .receive(on: DispatchQueue.main)
                    .assign(to: \UILabel.text, on: messageLabel)
                    .store(in: &cancellables)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        if let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    @IBAction private func tappedChangeMessage(_ sender: UIButton) {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        let now = Date()
        
        
        guard let viewModel else { return }
        viewModel.displayingLabel = formatter.string(from: now)
    }
    
}
