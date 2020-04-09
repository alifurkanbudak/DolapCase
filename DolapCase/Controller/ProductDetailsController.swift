//
//  ViewController.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 7.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import UIKit

class ProductDetailsController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    
    @IBOutlet weak var socialLikeImage: UIImageView!
    @IBOutlet weak var socialLikeLabel: UILabel!
    
    @IBOutlet weak var socialCommentRating: UILabel!
    @IBOutlet weak var socialCommentCount: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    
    // This will be used while filling stars according to average rating
    var stars : Array<UIImageView> = []
    let emptyStar = UIImage(systemName: "star")!.withTintColor(UIColor.lightGray.withAlphaComponent(0.3),renderingMode: .alwaysOriginal)
    let halfStar = UIImage(systemName: "star.lefthalf.fill")
    let fullStar = UIImage(systemName: "star.fill")
    
    var remainingTime : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize circular progress bar for counter
        counterView.addCounter(percentage: 0, size: 34, thickness: 5)
        
        //Create stars array for looping purposes
        stars = [star1Image, star2Image, star3Image, star4Image, star5Image]
        
        //Set images
        socialLikeImage.image = UIImage(systemName: "heart.fill")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Fetch initial info
        // Fetching inital info happens after view appears. The reason is to show an alert dialog if there is an error while fetching the info.
        getProduct()
        getSocials()
        
        //Initialize periodic function calls with timer
        remainingTime = Constants.counterCycle
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // Reduces remaining time and updates the ui accordingly.
    // Fetches new social info. if the time has come
    @objc func updateCounter() {
        remainingTime -= 1
        counterLabel.text = "\(remainingTime!)"
        counterView.updateCounterPercent(percentage: Double((Constants.counterCycle - remainingTime))/Double(Constants.counterCycle))
        
        if remainingTime == 0 {
            remainingTime += Constants.counterCycle
            getSocials()
        }
    }
    
    // Called every 60 seconds to read social info from Social.json
    func getSocials(){
        if let socials = ProductService.getSocials(VC: self) {
            updateSocialView(socials: socials)
        }
    }
    
    // Reads product info from Product.json
    func getProduct() {
        if let product = ProductService.getProduct(VC: self) {
            updateProductView(product: product)
        }
    }
    
    // Uses the product info to update relevant ui components
    func updateProductView(product: Product) {
        let imageURL = URL(string: product.image)!
        
        // Display network image
        DispatchQueue.main.async {
            let imageData = try! Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            self.productImage.image = image
        }
        
        productTitle.text = product.name
        productDesc.text = product.desc
        productPrice.text = "\(product.price.value) \(product.price.currency)"
    }
    
    // Uses the social info to update relevant ui components
    func updateSocialView(socials: ProductSocials) {
        socialCommentRating.text = "\(socials.commentCounts.averageRating)"
        socialCommentCount.text = "(\(socials.commentCounts.anonymousCommentsCount + socials.commentCounts.memberCommentsCount) \(NSLocalizedString("comments", comment: "")))"
        socialLikeLabel.text = "\(socials.likeCount)"
        
        // Set star images
        var rating = socials.commentCounts.averageRating
        for star in stars {
            switch rating {
            case ..<0.25:
                star.image = emptyStar
            case 0.25..<0.75:
                star.image = halfStar
            default:
                star.image = fullStar
            }
            rating -= 1
        }
    }
}
