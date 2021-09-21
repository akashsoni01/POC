//
//  CustomVideoPlayerViewController.swift
//  Custom Video Player
//
//  Created by Akash soni on 07/09/21.
//

import UIKit
import AVFoundation

class CustomVideoPlayerViewController: UIViewController {
    let videoPlayerView = UIView()
    var timeObserver: Any?

    var player: AVPlayer?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var speedRateButton: UIButton!
    var videoTitleStirng = ""
    var videoUrlString = "https://youtu.be/2H8tGt2kkk0"
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = videoTitleStirng
        videoPlayerView.backgroundColor = UIColor.black
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: videoPlayerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: videoPlayerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: videoPlayerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: videoPlayerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)

        view.addSubview(videoPlayerView)
        view.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        view.sendSubviewToBack(videoPlayerView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControls))
        view.addGestureRecognizer(tapGesture)

        NotificationCenter.default.addObserver(
            self,
            selector:  #selector(deviceDidRotate),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    @objc func deviceDidRotate() {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.frame;
        videoPlayerView.layer.addSublayer(playerLayer)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoPlayer()
        resetTimer()
    }
    @objc func toggleControls() {
        playPauseButton.isHidden = !playPauseButton.isHidden
        progressSlider.isHidden = !progressSlider.isHidden
        timeRemainingLabel.isHidden = !timeRemainingLabel.isHidden
        forwardButton.isHidden = !forwardButton.isHidden
        rewindButton.isHidden = !rewindButton.isHidden
        titleLabel.isHidden = !titleLabel.isHidden
        speedRateButton.isHidden = !speedRateButton.isHidden
        resetTimer()
    }

//     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//         return .landscapeLeft
//     }
    func setupVideoPlayer() {
        guard let url = URL(string: videoUrlString) else {
            return
        }
        player = AVPlayer(url: url)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds;
        videoPlayerView.layer.addSublayer(playerLayer)
        player?.play()
        
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
            self.updateVideoPlayerSlider()
        })

    }
    
    @IBAction func playPauseButton(_ sender: Any) {
        guard let player = player else { return }
        if !player.isPlaying {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            player.pause()
        }

    }
    
    @IBAction func playbackSliderValueChanged(_ sender:UISlider)
    {
        guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(sender.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime )
    }
    
    func updateVideoPlayerSlider() {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        progressSlider.value = Float(currentTimeInSeconds)
        if let currentItem = player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
        }
        updateVideoPlayerState()
    }

    func updateVideoPlayerState() {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        progressSlider.value = Float(currentTimeInSeconds)
        if let currentItem = player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))

            // Update time remaining label
            let totalTimeInSeconds = CMTimeGetSeconds(duration)
            let remainingTimeInSeconds = totalTimeInSeconds - currentTimeInSeconds

            let mins = remainingTimeInSeconds / 60
            let secs = remainingTimeInSeconds.truncatingRemainder(dividingBy: 60)
            let timeformatter = NumberFormatter()
            timeformatter.minimumIntegerDigits = 2
            timeformatter.minimumFractionDigits = 0
            timeformatter.roundingMode = .down
            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                return
            }
            timeRemainingLabel.text = "\(minsStr):\(secsStr)"
        }
    }
    @IBAction func jumpForward(_ sender: UIButton) {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSecondsPlus10 =  CMTimeGetSeconds(currentTime).advanced(by: 10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsPlus10), timescale: 1)
        player?.seek(to: seekTime)

    }

    @IBAction func jumpBackward(_ sender: UIButton) {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSecondsMinus10 =  CMTimeGetSeconds(currentTime).advanced(by: -10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
        player?.seek(to: seekTime)

    }
    func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
    }
    @objc func hideControls() {
        playPauseButton.isHidden = true
        progressSlider.isHidden = true
        timeRemainingLabel.isHidden = true
        forwardButton.isHidden = true
        rewindButton.isHidden = true
        titleLabel.isHidden = true
        speedRateButton.isHidden = true
    }
    
    @IBAction func speedRateTapped(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        actionSheet.popoverPresentationController?.permittedArrowDirections = []
        
        let option1 = UIAlertAction(title: "0.5x", style: .default, handler: { (action) -> Void in
            self.player?.rate = 0.5
            self.speedRateButton.setTitle("0.5x", for: .normal)
        })
        let option2 = UIAlertAction(title: "0.75x", style: .default, handler: { (action) -> Void in
            self.player?.rate = 0.75
            self.speedRateButton.setTitle("0.75x", for: .normal)

        })
        
        let option3 = UIAlertAction(title: "Normal", style: .default, handler: { (action) -> Void in
            self.player?.rate = 1
            self.speedRateButton.setTitle("1x", for: .normal)

        })
        let option4 = UIAlertAction(title: "1.25x", style: .default, handler: { (action) -> Void in
            self.player?.rate = 1.25
            self.speedRateButton.setTitle("1.25x", for: .normal)

        })
        let option5 = UIAlertAction(title: "1.5x", style: .default, handler: { (action) -> Void in
            self.player?.rate = 1.5
            self.speedRateButton.setTitle("1.5x", for: .normal)

        })
        let option6 = UIAlertAction(title: "2x", style: .default, handler: { (action) -> Void in
            self.player?.rate = 2
            self.speedRateButton.setTitle("2x", for: .normal)

        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(option3)
        actionSheet.addAction(option4)
        actionSheet.addAction(option5)
        actionSheet.addAction(option6)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)

    }
    
}
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
