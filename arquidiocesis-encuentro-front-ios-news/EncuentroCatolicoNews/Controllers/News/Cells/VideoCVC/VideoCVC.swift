//
//  VideoCVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 14/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import MediaPlayer

public protocol VideosDelegate: class {
    func presentFullScreenVideo(videoURL: String?)
}

public class VideoCVC: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var videoPlayer: UIView!
    @IBOutlet public weak var playImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "play".getImage()
        
        return imageView
    }()
    
    //MARK: - Properties
    public weak var delegate: VideosDelegate?
    private var player: AVPlayer?
//    private var isVideoPlaying = false
    public var videoURL: String? {
        didSet {
            if let videoURL = videoURL, let url = URL(string: videoURL) {
                player = AVPlayer(url: url)
                let playerLayer = AVPlayerLayer(player: player)
                videoPlayer.frame = self.frame
                playerLayer.frame = videoPlayer.frame
                videoPlayer.layer.addSublayer(playerLayer)
            }
        }
    }
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func prepareForReuse() {
        if videoPlayer.layer.sublayers?.last is AVPlayerLayer {
            videoPlayer.layer.sublayers?.last?.removeFromSuperlayer()
        }
        
        videoURL = nil
        player = nil
    }
    
//    deinit {
//        player?.pause()
//    }
    
    //MARK: - Methods
//    private func videoControls() {
//        playImage.isHidden = isVideoPlaying
//        if isVideoPlaying {
//            player?.play()
//        } else {
//            player?.pause()
//        }
//    }
    
    //MARK: - Actions
    @IBAction func playVideo(_ sender: UIButton) {
        delegate?.presentFullScreenVideo(videoURL: videoURL)
    }
}
