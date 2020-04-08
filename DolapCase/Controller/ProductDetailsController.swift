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
    
    let COUNTER_CYCLE = 60
    
    var remainingTime = 0
    
    var product : Product?
    var socials : ProductSocials?
    
    var socialInfoError = false
    var productInfoError = false
    
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
        remainingTime = COUNTER_CYCLE
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // Reduces remaining time and updates the ui accordingly.
    // Fetches new social info. if the time has come
    @objc func updateCounter() {
        remainingTime -= 1
        counterLabel.text = "\(remainingTime)"
        counterView.updateCounterPercent(percentage: Double((COUNTER_CYCLE - remainingTime))/Double(COUNTER_CYCLE))
        
        if remainingTime == 0 {
            remainingTime += COUNTER_CYCLE
            getSocials()
        }
    }
    
    // Called every 60 seconds to read social info from Social.json
    func getSocials(){
        let path = Bundle.main.path(forResource: "Social", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            socials = try JSONDecoder().decode(ProductSocials.self, from: data)
        } catch {
            showInfoFetchError()
            return
        }
        
        updateSocialView()
    }
    
    // Reads product info from Product.json
    func getProduct() {
        let path = Bundle.main.path(forResource: "Product", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            product =  try JSONDecoder().decode(Product.self, from: data)
        }catch {
            showInfoFetchError()
            return
        }
        
        updateProductView()
    }
    
    // Informs the user about the error
    func showInfoFetchError() {
        let alertController = UIAlertController(title: NSLocalizedString("error_loading_product_info", comment: ""), message:
            nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("okay", comment: ""), style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Uses the product info to update relevant ui components
    func updateProductView() {
        let imageURL = URL(string: product!.image)!
        
        // Display network image
        DispatchQueue.main.async {
            let imageData = try! Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            self.productImage.image = image
        }
        
        productTitle.text = product!.name
        productDesc.text = product!.desc
        productPrice.text = "\(product!.price.value) \(product!.price.currency)"
    }
    
    // Uses the social info to update relevant ui components
    func updateSocialView() {
        socialCommentRating.text = "\(socials!.commentCounts.averageRating)"
        socialCommentCount.text = "(\(socials!.commentCounts.anonymousCommentsCount + socials!.commentCounts.memberCommentsCount) \(NSLocalizedString("comments", comment: "")))"
        socialLikeLabel.text = "\(socials!.likeCount)"
        
        // Set star images
        var rating = socials!.commentCounts.averageRating
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
