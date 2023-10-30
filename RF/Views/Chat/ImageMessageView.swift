//
//  ImageMessageView.swift
//  RF
//
//  Created by 이정동 on 10/18/23.
//

import UIKit
import SnapKit

class ImageMessageView: UIView {

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    weak var delegate: MessageTableViewCellDelegate?
    
    var indexPath: IndexPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(imageView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addTargets() {
        
    }
    
    func updateMessageImage(_ message: RealmMessage) {
        if let data = message.imageData {
            imageView.image = UIImage(data: data)
        } else {
            imageView.image = UIImage(resource: .MORNING_HUMAN)
        }
        
        guard let image = imageView.image else { return }
        let ratio = image.size.height / image.size.width
        
        self.imageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(ratio)
        }
    }
    
}
