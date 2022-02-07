//
//  detailsVC.swift
//  ArtBookProject
//
//  Created by Ahmed Hajıyev on 05.02.22.
//

import UIKit
import CoreData

class detailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        if chosenPainting != "" {
            
            saveButton.isHidden = true
            nameText.isEnabled = false
            artistText.isEnabled = false
            yearText.isEnabled = false
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchRequest.returnsObjectsAsFaults = false
            
            let idStirng = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idStirng!)
            
            
            do {
                           let results = try context.fetch(fetchRequest)
                            
                            if results.count > 0 {
                                
                                for result in results as! [NSManagedObject] {
                                    
                                    if let name = result.value(forKey: "name") as? String {
                                        nameText.text = name
                                    }

                                    if let artist = result.value(forKey: "artist") as? String {
                                        artistText.text = artist
                                    }
                                    
                                    if let year = result.value(forKey: "year") as? Int {
                                        yearText.text = String(year)
                                    }
                                    
                                    if let imageData = result.value(forKey: "image") as? Data {
                                        let image = UIImage(data: imageData)
                                        imageView.image = image
                                    }
                                    
                                }
                            }

                        } catch{
                            print("error")
                        }
            
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
        }
        
        
        
        //Recognizers
        let gestureRecornizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecornizer)
        
        
        
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
        
    }
    
    @objc func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self 
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(UUID(), forKey: "id")
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        
        do{
            try context.save()
            print("success")
        }catch {
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
