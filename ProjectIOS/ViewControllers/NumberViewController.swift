import UIKit
import AVFoundation

class NumberViewController: UITableViewController{
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var play_pauseButton: UIButton!
    @IBOutlet weak var progressbar: UISlider!
    
    var number: Number!
    var error: NSError?
    
    var sound: AVAudioPlayer!
    var updater : CADisplayLink! = nil
    
    override func viewDidLoad() {
        title = number.name
        albumLabel.text = "Album: \(number.album)"
        themeLabel.text = "Theme: \(number.theme)"
        descriptionLabel.text = "Description: \(number.description)"
        imageView.image = UIImage(named: number.partiture)
        //progressbar.value = 0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // let navigationController = segue.destination as! UINavigationController
        let partituurViewController = segue.destination as! PartituurViewController
        partituurViewController.partituurString = number.partiture
        
    }
    
    func initSound() {
        //TODO: Muziekfragment veranderen!!!
        if let path = NSDataAsset(name: "leaving_hogwarts_sound") {
            do {
                try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try! AVAudioSession.sharedInstance().setActive(true)
                try sound = AVAudioPlayer(data: path.data, fileTypeHint: AVFileTypeWAVE)
                self.sound.currentTime = 0;
            } catch {
                print("error initializing AVAudioPlayer")
            }
        }}
    
    @IBAction func playSound(){
        if sound != nil && sound.isPlaying {
            sound.pause()
            play_pauseButton.setTitle("▶️", for:.normal)
        }else {
            if sound == nil {
                initSound()}
            else{
                sound!.play()
                play_pauseButton.setTitle("⏸", for: .normal)
                updater = CADisplayLink(target: self, selector: #selector(NumberViewController.trackAudio))
                updater.preferredFramesPerSecond = 1
                updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
                progressbar.minimumValue = 0
                progressbar.maximumValue = 100
            }
        }}
    
    func trackAudio() {
        if sound != nil {
        let normalizedTime = Float(sound.currentTime * 100.0 / sound.duration)
        progressbar.value = normalizedTime
            if !sound.isPlaying {
                play_pauseButton.setTitle("▶️", for:.normal)
            }
        }
        else {
           progressbar.value = 0
            play_pauseButton.setTitle("▶️", for:.normal)
        }
    }
    
    
    @IBAction func stopSound(){
    if sound != nil {
    sound.stop()
    sound = nil
    }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if splitViewController != nil {
        if !splitViewController!.isCollapsed {
            navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
            }}
    }
}
