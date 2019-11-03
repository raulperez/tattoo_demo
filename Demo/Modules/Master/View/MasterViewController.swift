//
//  MasterViewController.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // Module Properties and Methods
    internal private(set) var presenter: MasterPresenterProtocol?
    internal private(set) var router: MasterRouterProtocol?

    private func instanceModule() {
        guard self.router == nil, self.presenter == nil else { return }
        
        // Create layers
        let router = MasterRouter()
        let presenter = MasterPresenter()
        let interactor = MasterInteractor()
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
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var dayNighView: DayNightView!
    
    // Class Properties
    private var textField: UITextField? = nil
    private var tattooFeed: TattooFeed? = nil
    private var isLoadingNewPage = false
    internal private(set) var tattoos = [Tattoo]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        presenter?.retrieveTattooFeed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTheme()
    }
    
    private func setup() {
        addObservers()
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
        UIApplication.shared.delegate?.window??.tintColor = Theme.current.secondaryColor
        navigationController?.navigationBar.barStyle = Theme.current.barStyle
        navigationController?.navigationBar.backgroundColor = Theme.current.primaryColor
        navigationController?.navigationBar.barTintColor = Theme.current.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Theme.current.secondaryColor]

        collectionView.backgroundColor = Theme.current.backgroundColor
        self.view.backgroundColor = Theme.current.backgroundColor

        collectionView.reloadData()
        
        dayNighView.updateTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }
}

// MARK: - Collection View Delegate

extension MasterViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TattooFeedCollectionViewCell

        let tattoo = tattoos[indexPath.row]
        
        if let imageURL = tattoo.image?.url { cell.downloadImage(with: imageURL) }
        
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout

extension MasterViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.bounds.width / 2, height: self.collectionView.bounds.width / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Collection View Data Source

extension MasterViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tattoos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tattoo = tattoos[indexPath.row]
        
        guard let identifier = tattoo.id else { return }

        presenter?.retrieveTattoo(with: String(identifier))
    }
}

// MARK: - Master View Controller Protocol

extension MasterViewController : MasterViewControllerProtocol {
    func populate(_ tattooFeed: TattooFeed) {
        self.tattooFeed = tattooFeed

        if let tattoos = tattooFeed.data {
            isLoadingNewPage = false
            self.tattoos.append(contentsOf: tattoos)
        }
        
        DispatchQueue.main.async {
            [unowned self] in
            
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - UIScrollViewDelegate

extension MasterViewController : UIScrollViewDelegate {
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset

        if distanceFromBottom <= height,
            let tattooFeed = tattooFeed,
            let pagination = tattooFeed.meta?.pagination,
            let currentPage = pagination.current_page,
            let totalPages = pagination.total_pages,
            currentPage < totalPages,
            !isLoadingNewPage {
                     
            isLoadingNewPage = true
            
            presenter?.retrieveTattooFeed(page: currentPage + 1)
        }
    }
}

