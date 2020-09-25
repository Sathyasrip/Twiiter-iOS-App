//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sathya Sri Pasham on 9/17/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    var favorited:Bool = false
    func setFavorite(_isFavorited:Bool){
       favorited = _isFavorited
        if(favorited){
            favButton.setImage(UIImage(named : "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
           favButton.setImage(UIImage(named : "favor-icon-1"), for: UIControl.State.normal)
        }
    }
    var tweetId:Int = -1
    
    
    func setRetweeted(_isRetweeted:Bool){
        if(_isRetweeted){
            retweetButton.setImage(UIImage(named : "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named : "retweet-icon"), for: UIControl.State.normal)
                       retweetButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(_isRetweeted: true)
        }, failure: {
            (error) in
            print("error while retweeting \(error)")
        })
        
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: true)
            }, failure: {
                (error) in
                print("error message \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: false)
            }, failure: {
                (error) in
                print("error message \(error)")
            })
        }
    }
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
