//
//  ViewController.swift
//  Hammer
//
//  Created by Dorian Rousse on 20/02/2024.
//
import CoreData
import UIKit
import AVFoundation
import CoreMotion

class ViewController: UIViewController {
    
    var audioPlayer1: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    var audioPlayer3: AVAudioPlayer?
    var audioPlayer4: AVAudioPlayer?
    var audioPlayer5: AVAudioPlayer?
    var audioPlayer6: AVAudioPlayer?
    
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
    
    func playstoneSound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "stone4", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer2 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer2?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }
    
    func playlevelupSound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "levelup", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer3 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer3?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }
    
    func playyes1Sound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "yes1", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer4 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer4?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }
    func playsone1Sound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "stone1", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer5 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer5?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }
    
    func playsay2Sound() {
            // Charger le fichier audio "click.wav"
            if let soundURL = Bundle.main.url(forResource: "say2", withExtension: "wav") {
                do {
                    // Créer une instance de AVAudioPlayer pour le son
                    audioPlayer6 = try AVAudioPlayer(contentsOf: soundURL)
                    // Jouer le son
                    audioPlayer6?.play()
                } catch {
                    print("Erreur lors de la lecture du son:", error.localizedDescription)
                }
            } else {
                print("Impossible de charger le fichier audio 'click.wav'")
            }
        }

    @IBOutlet var imageViewcoble: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBlockImage()
        // Do any additional setup after loading the view.
    }
    
    var blockState: Int = 0
    var motionManager : CMMotionManager!;
    var timer: Timer!
    var nbVal: Int = 0
    var donnees: [Double] = []
    var score : Int = 0
    var score2 : Double = 0.0
    var joueurAAssigner : Joueur?
    var nbBlocksMined: Int = 0
    
    @IBOutlet var message : UILabel?
    @IBOutlet var boutonGo : UIButton?
    @IBOutlet var boutonScores : UIButton?
    @IBOutlet var slider1 : UISlider?
    @IBOutlet var slider2 : UISlider?
    @IBOutlet var labelblocmined: UILabel!
    
    func updateBlockImage() {
        playsone1Sound()
            // Charger l'image correspondant à l'état actuel du bloc
            if let image = UIImage(named: "coble\(blockState)") {
                imageViewcoble.image = image
                if blockState == 1 {
                                playstoneSound()
                                nbBlocksMined += 1 // Incrémenter le nombre de blocs minés
                                labelblocmined.text = "Nombre de blocs minés : \(nbBlocksMined)"
                            }
            }
        }

    @objc func changeBlockState() {
            // Incrémenter l'état du bloc (ou revenir à 1 si on est déjà à 4)
            blockState = blockState < 4 ? blockState + 1 : 1

            // Mettre à jour l'image du bloc avec la nouvelle état
            updateBlockImage()
        }
    
    
    
    @IBAction func GoGoGo(_ sender : UIButton) {
        //var controller: UIAlertController
        playClickSound()
        nbVal = 0
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager . startAccelerometerUpdates ()
        donnees = [Double](repeating: 0, count: 500)
        
        //controller = UIAlertController(title: "Score", message: "donnees[nbVal].description" , preferredStyle : .alert )
        
        // ici : décoration pour faire une jolie animation avec des chiffres
        // possiblement parler : classe AVSpeechVoiceSynthesis : https://developer.apple.com/documentation/avfaudio/avspeechsynthesisvoice
        
        boutonGo? .isEnabled = false
        boutonScores? .isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self , selector: #selector(mesureDonnees) , userInfo : nil , repeats : true)
        
        //self.present ( controller , animated : true , completion : nil )
        
    }
    
    @objc func mesureDonnees(timer: Timer) {
        if(nbVal >= 500) {
            motionManager.stopAccelerometerUpdates()
            timer.invalidate()
            motionManager = nil
            self.calculScore()
            boutonGo? .isEnabled = true
            boutonScores? .isEnabled = true
            self.performSegue(withIdentifier: "segueSelectionJoueur", sender: self)
        }
        else {
            if(motionManager == nil) {
                return
            }
            if let acceleration = motionManager.accelerometerData?.acceleration {
                        donnees[nbVal] = sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
                        print("acceleration:\(donnees[nbVal])")
                        print("Acquisition:\(nbVal)")
                
                if donnees[nbVal] > 3 {
                            // Passer à l'image suivante du bloc (s'il en reste)
                            if blockState < 4 {
                                blockState += 1
                            } else {
                                // Réinitialiser l'état du bloc à 1 si nous avons atteint la dernière image
                                blockState = 1
                            }
                            if blockState == 1 {
                                        self.perform(#selector(changeBlockState), with: nil, afterDelay: 0.1)
                                    }
                            // Mettre à jour l'image du bloc en fonction de l'état actuel
                            updateBlockImage()
                    
                    
                        }
                
                
                        nbVal += 1
                    }
        }
    }
    
    func calculScore() {
        /*var max = 0.0
        for i in donnees {
            if i >= max{
                max = i
            }
        }
                score = max
         */
        score = nbBlocksMined
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueSelectionJoueur"){
            ((segue.destination as! UINavigationController).topViewController as! TableViewController).estAppeleeParSelection = true
            ((segue.destination as! UINavigationController).topViewController as! TableViewController).appelant = self
        }
    }
    
    func saveScore() {
        let max1: Double = sqrt(192) // Si 8g max par axe...
        if(score > 90) {
            playlevelupSound()
            message?.text = "BIEN"
        }
        else if(score > 50) {
            playyes1Sound()
            message?.text = "Pas Mal"
        }
        else{
            playsay2Sound()
            message?.text = "Loser!"
        }
        
        //slider1?.value = Float(score/max1)
        //slider2?.value = Float(score/max1)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let s: Scores = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: managerContext) as! Scores
        
        s.score = Int16(score)
        s.date = Date()
        s.quelJoueur = joueurAAssigner
        
        if(joueurAAssigner?.ensembleDesScores == nil) {
            let setScores = NSSet.init(object: s)
            joueurAAssigner?.ensembleDesScores = setScores
        }
        else {
            joueurAAssigner?.addToEnsembleDesScores (s)
        }
        do {
            try managerContext.save()
            print ("Ajout ok")
        } catch {
            let fetchError = error as NSError
            print( "Impossible d'ajouter" )
            print ("\(fetchError),\(fetchError.localizedDescription )")
        }
    }
    
    @IBAction func voirScoresButtonPressed(_ sender: UIButton) {
            //playClickSound()
        }


    
    

}

