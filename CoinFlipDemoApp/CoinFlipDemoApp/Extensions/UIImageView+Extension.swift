//
//  UIImageView+Extension.swift
//  CoinFlipDemoApp
//
//  Created by Ashish Singh on 2/26/23.
//

import UIKit

extension UIImageView {
    
    /*===================================================================================
     Method to download image from URL and call completion handler once downloaded
     =====================================================================================*/
    
    func downloadImageFrom(url:String, withCompletionHandler: @escaping (UIImage?)->Void) {
        // check if url is valid then proceed else removed activity indicator
        guard let imageUrl = URL(string:url) else { return }

        // show activity indicator till imaged getting loaded
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        //indicator.backgroundColor = .white
        self.addSubview(indicator)

        // set autolayout for activity indicator
        indicator.translatesAutoresizingMaskIntoConstraints = false
        [indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)].forEach {
            $0.isActive = true
         }
        
        indicator.startAnimating()
        
        let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        // start downloading of image
        URLSession.shared.dataTask( with: request, completionHandler: {
            (data, response, error) -> Void in
            
            // once data is received set it to ImageView
            DispatchQueue.main.async {
                self.contentMode =  .scaleAspectFit
                if let data = data {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    withCompletionHandler(UIImage(data: data))
                }
            }
        }).resume()
    }
}
