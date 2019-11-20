//
//  IndividualProductViewController.swift
//  shopapp
//
//  Created by David on 7/23/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class IndividualProductViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbnailsScrollView: UIScrollView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var slides:[SlideProductView] = [];
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor.ShopApp.backgroundPage
        priceLabel.textColor = UIColor.ShopApp.textImportant
        thumbnailsScrollView.delegate = self
        
        updateView()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        guard let unwrapping = self.product else { return }
        priceLabel.text = "$ \(unwrapping.price)"
        nameLabel.text = unwrapping.name
        descriptionTextView.text = "Description:\n\(unwrapping.description)"
        preloadImgs()
    }
    
    func setUpConstraints() {
        descriptionTextView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }

    func preloadImgs() {
        guard let unwrapping = self.product else { return }
        ProductClient.shared.listThumbnails(productId: unwrapping.id) { (listImgs) in
            for img in listImgs {
                let slide:SlideProductView = Bundle.main.loadNibNamed("SlideProductView", owner: self, options: nil)?.first as! SlideProductView
                slide.slideImageView.getImageFromUrl(url: Config.host.value! + "/" + img.url)
                self.slides.append(slide)
            }
            self.setupSlideScrollView()
        }
    }
    
    func setupSlideScrollView() {
        thumbnailsScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        thumbnailsScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 1.0)
        
        thumbnailsScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 300)
            thumbnailsScrollView.addSubview(slides[i])
        }
        
        slidePageControl.numberOfPages = slides.count
        slidePageControl.currentPage = 0
        view.bringSubviewToFront(slidePageControl)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        slidePageControl.currentPage = Int(pageIndex)
    }
    
    @IBAction func addProductBtnAction(_ sender: UIButton) {
        guard let product = self.product else { return }
        ShopCart.shared.products.append(product)
        if let tabItems = tabBarController?.tabBar.items, let navigation = navigationController {
            let tabItem = tabItems[2]
            tabItem.badgeValue = "\(ShopCart.shared.products.count)"
            navigation.popViewController(animated: true)
        }
        
    }
    
}
