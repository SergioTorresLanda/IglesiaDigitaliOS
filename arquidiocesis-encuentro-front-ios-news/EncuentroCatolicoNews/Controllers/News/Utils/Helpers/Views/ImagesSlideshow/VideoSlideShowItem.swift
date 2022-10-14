//
//  VideoSlideShowItem.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 18/11/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import MediaPlayer

public class VideoSlideShowItem: UIScrollView {
    
    //MARK: - Properties
    private var videoPlayer: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    public var playVideoButton: UIButton! = {
        let button = UIButton()
        button.setImage("play".getImage(), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private var player: AVPlayer?
    
    
    //MARK: - Life cycle
    init(frame: CGRect, videoURL: String?) {
        super.init(frame: frame)
        
        videoPlayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(videoPlayer)
        
        if let videoURL = videoURL, let url = URL(string: videoURL) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = videoPlayer.frame
            videoPlayer.layer.addSublayer(playerLayer)
            videoPlayer.addSubview(playVideoButton)
        }
        
        activateConstraints()
        self.addSubview(playVideoButton)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func activateConstraints() {
        playVideoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playVideoButton.heightAnchor.constraint(equalToConstant: 100),
            playVideoButton.widthAnchor.constraint(equalToConstant: 100),
            playVideoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playVideoButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
