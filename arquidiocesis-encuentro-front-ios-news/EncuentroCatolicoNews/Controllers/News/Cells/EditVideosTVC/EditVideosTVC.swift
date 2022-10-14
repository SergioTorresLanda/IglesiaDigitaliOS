//
//  EditVideosTVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 22/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import MediaPlayer

public protocol EditVideosDelegate: class {
    func presentFullScreenVideo(videoURL: URL?)
}

public class EditVideosTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var videoPlayer: UIView!
    @IBOutlet public weak var deleteButton: UIButton!
    @IBOutlet public weak var playImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "play".getImage()
        
        return imageView
    }()
    
    @IBOutlet public weak var videoImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "videoCameraIcon".getImage()
        
        return imageView
    }()
    
    @IBOutlet public weak var deleteImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "deleteCircleIcon".getImage()
        
        return imageView
    }()
    
    //MARK: - Properties
    public weak var delegate: EditVideosDelegate?
    private var player: AVPlayer?
    private var isVideoPlaying = false
    private var screenSize = UIScreen.main.bounds
    public var videoURL: URL? {
        didSet {
            if let url = videoURL {
                player = AVPlayer(url: url)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 300)
                videoPlayer.layer.addSublayer(playerLayer)
            }
        }
    }
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        if videoPlayer.layer.sublayers?.last is AVPlayerLayer {
            videoPlayer.layer.sublayers?.last?.removeFromSuperlayer()
        }
        
        videoURL = nil
        player = nil
    }
    
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
