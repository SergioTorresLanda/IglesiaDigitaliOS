//
//  ModalWebViewController.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 17/11/21.
//

import UIKit
import WebKit
import AVKit
import AVFoundation

open class ModalWebViewController: UIViewController {

// MARK: @IBOUTLET -
    //GENERAL
    @IBOutlet weak var iconCross: UIImageView!
    @IBOutlet weak var viewContentButton: UIView!
    @IBOutlet weak var seeMoreBtn: UIButton!
    //WEB
    @IBOutlet weak var webSV: UIStackView!
    @IBOutlet weak var myWebView: WKWebView!
    //AUDIO
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rewindBtn: UIImageView!
    @IBOutlet weak var back5Btn: UIImageView!
    @IBOutlet weak var playBtn: UIImageView!
    @IBOutlet weak var fwd15Btn: UIImageView!
    @IBOutlet weak var forwindBtn: UIImageView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var progressVW: NSLayoutConstraint!
    //IMAGE
    @IBOutlet weak var imageV: UIView!
    @IBOutlet weak var imageImg: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    //VIDEO
    @IBOutlet weak var videoTitle: UILabel!
    // MARK: GLOBAL VARS -
    var url = ""
    var titlex = ""
    var viewType = ""
    //VIDEO
    var playerVid: AVPlayer!
    var playerViewController: AVPlayerViewController!
    //AUDIO
    var player = AVAudioPlayer()
    var isplaying=false
    var isPlayer=false
    var timerTest : Timer?
    var secPlayed=0
    var tenSecPlayed=0
    var minsPlayed=0
    var audioDuration=1
    var timePlayed = 0
    var audioDataG:Data?
    var secPlayedx=0
    var tenSecPlayedx=0
    var minsPlayedx=0
    var secPlayedxO=0
    var tenSecPlayedxO=0
    var minsPlayedxO=0
// MARK: LIFE CYCLE FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        viewContentButton.isHidden = true
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        preValidateTypeModal(type: viewType)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        validateTypeModal(type: viewType)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        secPlayed=0
        tenSecPlayed=0
        minsPlayed=0
        secPlayedx=secPlayedxO
        tenSecPlayedx=tenSecPlayedxO
        minsPlayedx=minsPlayedxO
        timePlayed=0
        player.stop()
        isplaying=false
    }
    // MARK: PRIVATE FUNCTIONS -
    func startTimer () {
      guard timerTest == nil else { return }
        isPlayer=true
        timerTest = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){(_) in
          
            if self.isplaying{
                print("playing")
                self.timePlayed+=1
                self.setPlayedMins()
                self.setProgressWidth()
                self.setToPlayMins()
            }else{
                print("pausa")
            }
        }
    }
    
    func stopTimer() {
      timerTest?.invalidate()
      timerTest = nil
    }
    
    func setPlayedMins(){
        if self.secPlayed==9 && self.tenSecPlayed==5{
            self.secPlayed=0
            self.tenSecPlayed=0
            self.minsPlayed+=1
        }else{
            if self.secPlayed==9{
                self.secPlayed=0
                self.tenSecPlayed+=1
            }else{
                self.secPlayed+=1
            }
        }
        self.startTime.text="\(self.minsPlayed):\(self.tenSecPlayed)\(self.secPlayed)"
    }
    
    func setToPlayMins(){
        if self.secPlayedx==0 && self.tenSecPlayedx==0{
            self.secPlayedx=9
            self.tenSecPlayedx=5
            self.minsPlayedx-=1
        }else{
            if self.secPlayedx==0{
                self.secPlayedx=9
                self.tenSecPlayedx-=1
            }else{
                self.secPlayedx-=1
            }
        }
        self.endTime.text="\(self.minsPlayedx):\(self.tenSecPlayedx)\(self.secPlayedx)"
    }
    
    func setProgressWidth(){
        let factor = Double(self.timePlayed)/Double(self.audioDuration)
        self.progressVW.constant=CGFloat(Int(250.0*factor))
    }
    
    private func setupWebView(webURL: String) {
        webSV.isHidden=false
        myWebView.contentMode = .scaleToFill
        myWebView.load(NSURLRequest(url: NSURL(string: webURL)! as URL) as URLRequest)
        seeMoreBtn.layer.cornerRadius = 8
        if #available(iOS 15.0, *) {
            myWebView.setAllMediaPlaybackSuspended(true) { }
        }
    }
    
    private func setupWebViewVideo(webURL: String) {
        guard let url = URL(string: webURL) else {
            return
        }
        webSV.isHidden=false
        myWebView.contentMode = .scaleAspectFit
        myWebView.load(URLRequest(url: url))
    }

    private func preValidateTypeModal(type: String) {
        print("VWA TYPE ::::")
        switch type {
        case "AUDIO":
            print("VWA AUDIO")
            titleLbl.text=titlex
            audioView.isHidden=false
        case "VIDEO":
            videoTitle.isHidden=false
            videoTitle.text=titlex
            print("VWA VIDEO")
        case "FILE":
            print("VWA FILE")
        case "IMAGE":
            print("VWA IMAGE")
            imageV.isHidden=false
            imageTitle.text=titlex
            imageImg.loadS(urlS: url)
        default:
            print(type)
        }
    }
    
    private func validateTypeModal(type: String) {
        print("SE ABRIO EL TYPE ::::")
        
        switch type {
        case "VIDEO":
            print("VIDEO")
            playVideo(s: url)
        case "AUDIO":
            print("AUDIO")
            play(s: url)
            startTimer()
        case "IMAGE":
            print("imagen nada q hacer")
        default:
            setupWebView(webURL: url)
            print(type)
        }
    }
    
    func downloadFileFromURL(s:String){
        guard let url = URL(string: s) else {
            return
        }
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            print("todo bien al 100")
           // self?.play(URL)
        })
        downloadTask.resume()
    }
    
    func playVideo(s:String) {
        print("play video \(s)")
        if s.contains("youtube"){
            let s2=s.embedYoutubeURL()
            print("will play video \(s2)")
            setupWebViewVideo(webURL: s2)
            videoTitle.isHidden=true
          return
        }
        guard let url = URL(string: s) else {
            return
        }
        playerVid = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController.player = playerVid
        playerViewController.view.frame = self.view.frame
        //playerViewController.player?.pause()
        self.view.addSubview(playerViewController.view)
        playerViewController.view.frame = view.bounds
        playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerViewController.view.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height-160)
        print("playing DO ::")
        playerVid.play()
    }
    
    func play(s:String) {
        print("playing audio \(s)")
        guard let url = URL(string: s) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let audioData = try? Data(contentsOf: url) {
                do {
                    print("playing DO ::")
                    self!.audioDataG=audioData
                    self!.player = try AVAudioPlayer(data: audioData)
                    self!.player.prepareToPlay()
                    self!.player.volume = 2.0
                    self!.player.play() // si funciona
                  
                    let ts = Int(self!.player.duration)
                    self!.audioDuration=ts
                    var secs = Int(ts % 60)
                    let min = Int(ts/60)
                    var tsecs=0
                    if secs>9{
                        tsecs=Int(secs/10)
                        secs=Int(secs % 10)
                    }
                    self!.endTime.text = "\(min):\(tsecs)\(secs)"
                    self!.secPlayedx=secs
                    self!.minsPlayedx=min
                    self!.tenSecPlayedx=tsecs
                    self!.secPlayedxO=secs
                    self!.minsPlayedxO=min
                    self!.tenSecPlayedxO=tsecs
                    self!.isplaying=true
                } catch let error as NSError {
                    //self.player = nil
                    print(error.localizedDescription)
                } catch {
                    print("AVAudioPlayer init failed")
                }
                /*if let loadedImage = UIImage(data: audioData) {
                }*/
            }else{
                print("no audio data")
            }
        }
    }
    
// MARK: @IBACTIONS -
    @IBAction func seeMoreAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func TapBack() {
        if isPlayer{
            player.stop()
            stopTimer()
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func TapRewind() {
        print("tapp rewind")
        secPlayed=0
        tenSecPlayed=0
        minsPlayed=0
        secPlayedx=secPlayedxO
        tenSecPlayedx=tenSecPlayedxO
        minsPlayedx=minsPlayedxO
        timePlayed=0
        player.stop()
        do{
            player = try AVAudioPlayer(data: audioDataG!)
            player.prepareToPlay()
            player.volume = 2.0
            player.play()
            isplaying=true
            playBtn.image=UIImage(named: "pause", in: Bundle(for: ModalWebViewController.self), compatibleWith: nil)
        }catch{
            print("AVAudioPlayer init failed dataglobal nil")
        }
    }
    
    @objc func TapPlay() {
        print("tap play")
        if player.isPlaying{
            isplaying=false
            player.pause()
            playBtn.image=UIImage(named: "playxxx", in: Bundle(for: ModalWebViewController.self), compatibleWith: nil)
        }else{
            isplaying=true
            player.play()
            playBtn.image=UIImage(named: "pause", in: Bundle(for: ModalWebViewController.self), compatibleWith: nil)
        }
    }
    
    @objc func TapFwd15() {
        print("tap fwd15")
    }
    
    @objc func TapForwind() {
        print("tap forwind")
    }
    
    @objc func TapBack5() {
        print("tap back5")
    }
    
    
    //MARK: - Formats
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        iconCross.addGestureRecognizer(tapBack)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(TapRewind))
        rewindBtn.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(TapBack5))
        back5Btn.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(TapPlay))
        playBtn.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(TapFwd15))
        fwd15Btn.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(TapForwind))
        forwindBtn.addGestureRecognizer(tap5)
    }
    

//MARK: - Inicialización
    class public func showWebModal(url: String, type: String, title:String) -> ModalWebViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ModalWebViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "webViewModal") as! ModalWebViewController
        
        view.url = url
        view.viewType = type
        view.titlex = title
        
        return view
    }
    
}
