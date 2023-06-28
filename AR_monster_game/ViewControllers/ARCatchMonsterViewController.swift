//
//  ViewController.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit
import SceneKit
import ARKit
import MapKit
import CoreData
import Foundation

class ARCatchMonsterViewController: UIViewController {
    
    let arView = ARSCNView()
    var monster: MKAnnotation!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var viewModel:MonstersInMap!
    
    lazy var catchMonsterButton = {
        let button = UIButton()
        button.setTitle("Поймать монстра", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(catchMonsterButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.text = monster?.title!
        text.textAlignment = .center
        text.tintColor = .white
        text.backgroundColor = .systemGray
        
        return text
    }()
    
    lazy var levelLabel: UILabel = {
        let text = UILabel()
        let newStr = self.monster.subtitle!! as String
        let endOfSentence = newStr.firstIndex(of: ",")!
        let firstSentence = newStr[...endOfSentence]
        text.text = String(firstSentence)
        text.textAlignment = .center
        text.tintColor = .white
        text.backgroundColor = .systemGray
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstarints()
        guard let unwarpedName = monster?.title else {return}
        arView.delegate = self
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backAction(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        if (unwarpedName != nil) {
            let scene = SCNScene(named: "Models.scnassets/\(unwarpedName!)/\(unwarpedName!).scn")!
            arView.scene = scene
        } else {
            let scene = SCNScene(named: "Models.scnassets/Rob/Rob.scn")!
            arView.scene = scene
        }
    }
    private func makeConstarints() {
        view.addSubview(arView)
        view.addSubview(catchMonsterButton)
        view.addSubview(nameLabel)
        view.addSubview(levelLabel)
        
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        arView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        arView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        catchMonsterButton.translatesAutoresizingMaskIntoConstraints = false
        catchMonsterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        catchMonsterButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        catchMonsterButton.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        catchMonsterButton.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.catchMonsterButton.topAnchor, constant: -20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        levelLabel.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor, constant: -5).isActive = true
        levelLabel.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        levelLabel.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
    }
    
    @objc func backAction(sender: UIBarButtonItem) {

        let alertController = UIAlertController(title: "Вы уверены?", message: "Если вы уйдете, то монстр сбежит!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (result : UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    @objc func catchMonsterButtonAction() {
        let randomNum = Int.random(in: 1...100)
        switch randomNum {
        case 1...20:
            systemPop(title: "Ура", message: "Вы поймали монстра \(monster?.title! ?? "Anna") в свою команду", num: randomNum)
            addEntity()
            self.navigationController?.popViewController(animated: false)
        case 20...50:
            systemPop(title: "Трус!", message: "Монстр убежал!", num: randomNum)
            self.navigationController?.popViewController(animated: false)
            
        case 50...100:
            systemPop(title: "Не вышло:(", message: "Попробуйте поймать еще раз!", num: randomNum)
        default:
            break
        }
    }
    
    private func addEntity() {
        let newOne = Entity(context: context)
        newOne.name = monster?.title!
        guard let unwarpedName = monster?.subtitle else {return}
        let endOfSentence = unwarpedName!.firstIndex(of: ",")!
        let firstSentence = unwarpedName![...endOfSentence]
        newOne.level = String(firstSentence)
        newOne.image = monster?.title!
        appDelegate.saveContext()
    }
    
    private func systemPop(title: String, message: String, num: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        switch num {
        case 1...20:
            alert.addAction(UIAlertAction(title: "Вернуться на карту", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: false)
            }))
        case 20...50:
            alert.addAction(UIAlertAction(title: "Вернуться на карту", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: false)
            }))
        case 50...100:
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func removeMonster() {
        if let index = viewModel?.mosterAnnotations.firstIndex(where: { $0 === monster }) {
            viewModel?.mosterAnnotations.remove(at: index)
            print("\(viewModel.mosterAnnotations.count) monster after remove")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}

extension ARCatchMonsterViewController: ARSCNViewDelegate {
    
}

