//
//  ReviewViewController.swift
//  WeGoTrip
//
//  Created by  User on 19.03.2022.
//

import UIKit
import CoreData

class ReviewViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var assistantImage: UIImageView!
    @IBOutlet weak var wowEffect: UITextView!
    @IBOutlet weak var improveView: UITextView!
    
    var tripRate: Int!
    var guideRate: Int!
    var infoRate: Int!
    var navigationRate: Int!
    
    
    @IBAction func goBack(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAll(_ sender: UIButton) {
        guard let url = URL(string: "https://webhook.site/c8f2041c-c57e-433f-853f-1ef739702903") else {print("Cann't save values"); return}
        var request = URLRequest(url: url)
        let body = Review(context: context)
        body.idTrip = Int32(Int.random(in: 1..<1000))
        body.tripRate = Int32(tripRate)
        body.guideRate = Int32(guideRate)
        body.infoRate = Int32(infoRate)
        body.navigationRate = Int32(navigationRate)
        body.wowEffect = wowEffect.text
        body.improveView = improveView.text
        ad.saveContext()
        let bodyData = try? JSONSerialization.data(withJSONObject: body.dictionaryWithValues(forKeys: ["idTrip", "tripRate", "guideRate", "infoRate", "navigationRate", "wowEffect", "improveView"]), options: [])
        request.httpMethod = "POST"
        request.httpBody = bodyData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                print(data)
            } else {
                print(request)
            }
        }.resume()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assistantImage.setRoundedImage(with: "img")
        assistantImage.downloadImage(from: "https://app.wegotrip.com/media/users/1/path32.png")
        wowEffect.isEditable = true
        improveView.isEditable = true
        wowEffect.delegate = self
        improveView.delegate = self
        addDoneButton(to: wowEffect)
        addDoneButton(to: improveView)
    
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addDoneButton(to textView: UITextView){
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissMyKeyboard))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }
}

