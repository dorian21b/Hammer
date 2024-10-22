//
//  TableViewController.swift
//  Hammer
//
//  Created by Dorian Rousse on 20/02/2024.
//
import CoreData
import UIKit
import CoreMotion
import AVFoundation

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
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
    
    var estAppeleeParSelection = false
    var appelant: UIViewController?
    var JoueurEnCours: Joueur?
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
            playClickSound()
            // Autres actions à effectuer lorsque le bouton + est pressé...
        }

    
    @IBAction func UIRetourRootViewController(_ sender: UIButton) {
        playClickSound()
        self.dismiss(animated: true, completion: nil)
    }

    let persistentContainer = NSPersistentContainer.init(name: "Hammer")
    
    lazy var fetchedResultsController : NSFetchedResultsController<Joueur> = {
        let fetchRequest: NSFetchRequest<Joueur> = Joueur.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: false)]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managerContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    func chargerDonnees() {
        persistentContainer.loadPersistentStores { (persistentStoreDescription , error) in
            if let error = error {
                print("Impossible de charger le magasin persistant")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Impossible d'effectuer la demande de récupération")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chargerDonnees()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let joueurs = fetchedResultsController.fetchedObjects else { return 0 }
        return joueurs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        playClickSound()
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleJeu", for: indexPath)
        let joueur = fetchedResultsController.object(at: indexPath) as Joueur
        
        cell.textLabel?.text = joueur.nom
        cell.detailTextLabel?.text = joueur.prenom
        
        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let managedObject = fetchedResultsController.object(at: indexPath) as NSManagedObject
            managedObjectContext.delete(managedObject)
            do {
                try managedObjectContext.save()
            } catch {
                // Gérer l'erreur...
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.estAppeleeParSelection {
            guard let viewController = self.appelant as? ViewController else {
                print("Erreur: Le contrôleur appelant n'est pas ViewController")
                return
            }
            viewController.joueurAAssigner = fetchedResultsController.object(at: indexPath) as Joueur
            self.dismiss(animated: true) {
                viewController.saveScore()
            }
        } else {
            guard let joueur = fetchedResultsController.object(at: indexPath) as? Joueur else {
                print("Erreur: Impossible de récupérer le joueur sélectionné")
                return
            }
            JoueurEnCours = joueur
            print("Joueur sélectionné : \(joueur.nom ?? "Nom du joueur non défini")")
            if !(self.presentedViewController is Viewscores) {
                self.performSegue(withIdentifier: "segueDetail", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            (segue.destination as! Viewscores).JoueurEnCours = JoueurEnCours
        }
    }
    
}
