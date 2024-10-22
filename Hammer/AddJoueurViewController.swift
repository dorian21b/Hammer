//
//  AddJoueurViewController.swift
//  Hammer
//
//  Created by Dorian Rousse on 29/02/2024.
//

import CoreData
import UIKit
import CoreMotion
import AVFoundation

class AddJoueurViewController: UIViewController {
    
    var audioPlayer1: AVAudioPlayer?
    func playClickSound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "click", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer1 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer1?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }
    
    @IBOutlet var nom: UITextField?
    @IBOutlet var prenom: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ok(_ sender : UIButton) {
        playClickSound()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let j: Joueur = NSEntityDescription.insertNewObject(forEntityName: "Joueur", into:managerContext ) as! Joueur
        
        j.nom = nom?.text
        j.prenom = prenom?.text
        j.ensembleDesScores = nil
        do {
            try managerContext.save()
            print ("Ajout ok")
        } catch {
            let fetchError = error as NSError
            print("Impossible d'ajouter")
            print ("\(fetchError), \(fetchError.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
    }
        
    @IBAction func canceladdview(_ sender: UIButton) {
        playClickSound()
        self.dismiss(animated: true, completion: nil)
    }
}
