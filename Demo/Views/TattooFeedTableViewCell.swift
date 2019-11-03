//
//  TattooFeedCollectionViewCell.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

class TattooFeedCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addObservers()
        setupTheme()
        reset()
    }
    
    deinit {
        removeObservers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDayNighTheme(notification:)), name: .dayNighToggle, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func toggleDayNighTheme(notification: Notification) {
        setupTheme()
    }
    
    private func setupTheme() {
        self.backgroundColor = Theme.current.backgroundColor
    }
    
    private func reset() {
        self.imageView.alpha = 0
        self.imageView.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let preferredLayoutAttributes = layoutAttributes

        var fittingSize = UIView.layoutFittingCompressedSize
        fittingSize.width = preferredLayoutAttributes.size.width
        let size = systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        var adjustedFrame = preferredLayoutAttributes.frame
        adjustedFrame.size.height = ceil(size.height)
        preferredLayoutAttributes.frame = adjustedFrame

        return preferredLayoutAttributes
    }
    
    func downloadImage(with url: String) {
        ConnectionManager.downloadImage(with: url) {
            (image, error, cached) in
            
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    [unowned self] in
                      
                    guard let image = image else { return }
                    
                    /*
                    let newSize = CGSize(width: 207, height: 207)
                    let renderer = UIGraphicsImageRenderer(size: newSize)
                    let imageResized = renderer.image { _ in
                        image.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
                    }
*/
                    
                    self.imageView?.image = image //Resized
                    
                    if !cached {
                        self.imageView.alpha = 0

                        UIView.animate(withDuration: 1) {
                            self.imageView.alpha = 1
                        }
                    } else {
                        self.imageView.alpha = 1
                    }
                }
            }
        }
    }
}
