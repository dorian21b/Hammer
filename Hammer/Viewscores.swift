//
//  Viewscores.swift
//  Hammer
//
//  Created by Dorian Rousse on 20/02/2024.
//

import CoreData
import UIKit
import CoreMotion
import AVFoundation

class Viewscores: UIViewController {
    
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

    var JoueurEnCours : Joueur?
    
    @IBOutlet var textAAfficher : UILabel?
    var texte : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        afficherJoueur()
        textAAfficher?.text = texte
    }
    
    func afficherJoueur() {
        print("Fonction afficherJoueur appelée")
        
        if(JoueurEnCours == nil) {
            print("Aucun joueur en cours")
            return
        }
        
        if(JoueurEnCours?.ensembleDesScores == nil || JoueurEnCours?.ensembleDesScores?.count == 0) {
            let j : Joueur = JoueurEnCours!
            texte = "Aucun score pour le moment pour \(j.nom!) \(j.prenom!)"
            print("Aucun score pour le joueur \(j.nom!) \(j.prenom!)")
        }
        else {
            let j : Joueur = JoueurEnCours!
            let ensembleScores:NSArray = j.ensembleDesScores!.allObjects as NSArray
            texte = "Joueur \(j.nom!) \(j.prenom!):\n"
            
            print("Scores pour le joueur \(j.nom!) \(j.prenom!):")
            
            for index in 0..<ensembleScores.count-1 {
                let s = ensembleScores.object(at: index) as! Scores
                texte += "Le \(s.date!)-->\(s.score)"
                print("Score: \(s.score) - Date: \(s.date!)\n")
            }
            
            let s = ensembleScores.object(at: ensembleScores.count-1) as! Scores
            texte += "Le\(s.date!)-->\(s.score)."
            print("Dernier score: \(s.score) - Date: \(s.date!)\n")
        }
        textAAfficher?.text = texte
        print("Affichage terminé")
    }
    
    @IBAction func cancelviewscores(_ sender: UIButton) {
        playClickSound()
        self.dismiss(animated: true, completion: nil)
    }

}
