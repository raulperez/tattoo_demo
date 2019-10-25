//
//  DetailViewController.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // Module Properties and Methods
    internal private(set) var presenter: DetailPresenterProtocol?
    internal private(set) var router: DetailRouterProtocol?

    private func instanceModule() {
        guard self.router == nil, self.presenter == nil else { return }
        
        // Create layers
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let viewController = self
        
        // Connect layers
        presenter.interactor = interactor
        presenter.router = router
        presenter.viewController = viewController
        viewController.presenter = presenter
        viewController.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        router.viewController = viewController
    }

    // IBOutlets
    @IBOutlet weak var tattooImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var upperSeparatorView: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsImage: UIImageView!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var lowerSeparatorView: UIView!

    
    // Class Properties
    var tattoo: Tattoo?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addObservers()
    }
    
    deinit {
        removeObservers()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        instanceModule()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        retrieveData()
        populate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTheme()
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
    
    private func setup() {
        self.artistImage.layer.cornerRadius = self.artistImage.frame.size.width / 2
    }
    
    private func setupTheme() {
        self.artistName?.textColor = Theme.current.secondaryColor
        self.descriptionLabel?.textColor = Theme.current.secondaryColor
        self.shareButton?.setTitleColor(Theme.current.secondaryColor, for: .normal)
        self.commentsLabel?.textColor = Theme.current.secondaryColor
        self.likesLabel?.textColor = Theme.current.secondaryColor
        self.view?.backgroundColor = Theme.current.backgroundColor
        self.tattooImage?.backgroundColor = Theme.current.backgroundColor
        self.artistImage?.backgroundColor = Theme.current.backgroundColor
        
        self.commentsImage?.image = UIImage.init(named: "comment")?.withRenderingMode(.alwaysTemplate)
        self.commentsImage?.tintColor = Theme.current.secondaryColor

        self.likesImage?.image = UIImage.init(named: "like")?.withRenderingMode(.alwaysTemplate)
        self.likesImage?.tintColor = Theme.current.secondaryColor
    }
    
    private func retrieveData() {
        
        if let url = tattoo?.image?.url { presenter?.downloadTattooImage(with: url) }
        if let url = tattoo?.artist?.image_url { presenter?.downloadArtistImage(with: url) }
    }
    
    private func populate() {
        // Update the user interface for the detail item.
        guard let tattoo = tattoo else { return }

        self.tattooImage?.alpha = 0
        self.artistImage?.alpha = 0
        
        self.artistName?.text = tattoo.artist?.name?.uppercased() ?? ""
        self.descriptionLabel?.text = tattoo.description ?? ""
        self.commentsLabel?.text = String(tattoo.counts?.comments ?? 0)
        self.likesLabel?.text = String(tattoo.counts?.likes ?? 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func didPressShareButton(_ sender: Any) {
        guard let text = self.tattoo?.description else { return }
        guard let image = self.tattooImage.image else { return }
        guard let share_url = self.tattoo?.share_url else { return }

        let params = [text, image, share_url] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: params, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension DetailViewController : DetailViewControllerProtocol {
    
    func populateTattooImage(with image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                [unowned self] in
                  
                self.tattooImage?.image = image
                
                UIView.animate(withDuration: 1) {
                    self.tattooImage.alpha = 1
                }
            }
        }
    }

    func populateArtistImage(with image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                [unowned self] in
                  
                self.artistImage?.image = image
                
                UIView.animate(withDuration: 1) {
                    self.artistImage.alpha = 1
                }
            }
        }
    }
}
