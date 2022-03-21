//
//  RateViewController.swift
//  WeGoTrip
//
//  Created by  User on 18.03.2022.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var assistantImage: UIImageView!
    
    @IBOutlet weak var tripRate: UISlider!
    @IBOutlet weak var guideRate: UISlider!
    @IBOutlet weak var infoRate: UISlider!
    @IBOutlet weak var navigationRate: UISlider!
    
    @IBOutlet weak var tripRateEmoji: UILabel!
    @IBOutlet weak var guideRateEmoji: UILabel!
    @IBOutlet weak var infoRateEmoji: UILabel!
    @IBOutlet weak var navigationRateEmoji: UILabel!
    
    let arrayOfEmoji = ["😡", "😑", "😐", "🙂", "😊"]
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(), animated: false)
        switch sender {
        case tripRate:
            tripRateEmoji.text = arrayOfEmoji[Int(sender.value.rounded()) - 1]
        case guideRate:
            guideRateEmoji.text = arrayOfEmoji[Int(sender.value.rounded()) - 1]
        case infoRate:
            infoRateEmoji.text = arrayOfEmoji[Int(sender.value.rounded()) - 1]
        case navigationRate:
            navigationRateEmoji.text = arrayOfEmoji[Int(sender.value.rounded()) - 1]
        default: break
        }
    }
    
    @IBAction func backToRootView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        assistantImage.downloadImage(from: "https://app.wegotrip.com/media/users/1/path32.png")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tripRate.addDots(with: Int(tripRate.maximumValue))
        guideRate.addDots(with: Int(guideRate.maximumValue))
        infoRate.addDots(with: Int(infoRate.maximumValue))
        navigationRate.addDots(with: Int(navigationRate.maximumValue))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReviewScreen" {
            let vc = segue.destination as! ReviewViewController
            vc.tripRate = Int(tripRate.value)
            vc.guideRate = Int(guideRate.value)
            vc.infoRate = Int(infoRate.value)
            vc.navigationRate = Int(navigationRate.value)
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func setRoundedImage(with image: String) {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.image = UIImage(named: image)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage (from str: String) {
        guard let url = URL(string: str) else {
            self.image = UIImage(named: "img")
            return
        }
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
        }
    }
}

extension UISlider {
    func addDots (with number: Int) {
        let spaceBetweenDots = Double(self.frame.width) / Double(number - 1) - 2
        for i in 0..<number {
            let view = UIView(frame: CGRect(x: Double(i) * spaceBetweenDots + (self.center.x - self.frame.width / 2.0), y: self.center.y, width: 8, height: 8))
            view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.90, alpha: 1)
            view.layer.cornerRadius = view.frame.width / 2
            view.clipsToBounds = true
            self.superview?.insertSubview(view, belowSubview: self)
        }
    }
}


