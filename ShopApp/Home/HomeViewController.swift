//
//  HomeViewController.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    var slidePages: [SlideHomeView] = [SlideHomeView]()
    var products: [Product] = [Product]()
    let  identifierCell = "reuse"
    @IBOutlet weak var productsCollectionView: ProductsCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setUpUIForDefaultView()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        sliderScrollView.delegate = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: "ProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifierCell)
        let logoNavImg = UIImageView(image: UIImage(named: "logo"))
        logoNavImg.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoNavImg
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: Selector("toSearchController"))
        preloadImgs()
        getData()
    }
    
    func getData() {
        ProductClient.shared.list { [weak self] (products) in
            self?.products = products
            self?.productsCollectionView.reloadData()
        }
    }

    
    func preloadImgs() {
        PromotionClient.shared.list(success: { [weak self] (list) in
            guard let strongSelf = self else { return }
            for prom in list {
                let slide:SlideHomeView = Bundle.main.loadNibNamed("SlideHomeView", owner: self, options: nil)?.first as! SlideHomeView
                slide.imgSlider.getImageFromUrl(url: Config.host.value! + "/" + prom.thumbnailUrl, contentModeFinal: .scaleAspectFit)
                slide.promotion = prom
                strongSelf.slidePages.append(slide)
            }
            strongSelf.setupSlideScrollView()
        })
    }
    
    func setupSlideScrollView() {
        sliderScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        sliderScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slidePages.count), height: 1.0)
        
        sliderScrollView.isPagingEnabled = true
        
        for i in 0 ..< slidePages.count {
            slidePages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 150)
            sliderScrollView.addSubview(slidePages[i])
        }
        
        sliderPageControl.numberOfPages = slidePages.count
        sliderPageControl.currentPage = 0
        view.bringSubviewToFront(sliderPageControl)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        sliderPageControl.currentPage = Int(pageIndex)
    }

    @objc func toSearchController() {
        let next = SearchViewController(nibName: "SearchViewController", bundle: nil)
        navigationController?.pushViewController(next, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as? ProductsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.product = products[indexPath.row]
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 4
        let totalSpacing = (2 * productsCollectionView.spacingCell) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing - productsCollectionView.spacingCell)/numberOfItemsPerRow
        return CGSize(width: width, height: 230)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let next = IndividualProductViewController(nibName: "IndividualProductViewController", bundle: nil)
        next.product = products[indexPath.row]
        navigationController?.pushViewController(next, animated: true)
    }
    

    
}
