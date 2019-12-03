//
//  ExamenesViewController.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/14/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import UIKit

class ExamenesViewController: UIViewController {
  
    @IBOutlet weak var MateriasCollectionView: UICollectionView!
    @IBOutlet weak var UnitsTableView: UITableView!
    
    var materias = [Materia]()
    var selectedCourse = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Esconde la barra de navegación
        self.navigationController?.isNavigationBarHidden = true
        //Carga los modulos iniciales
        self.materias = Materia().setInitialModules()
        //Asigna el DataSource y el Delegate para el MateriasCollectionView y UnitsTableView
        self.MateriasCollectionView.dataSource = self
        self.MateriasCollectionView.delegate = self
        self.UnitsTableView.delegate = self
        self.UnitsTableView.dataSource = self

        //Configuración del MateriasCollectionView y del UnitsTableView
        self.MateriasCollectionView.backgroundColor = .gray
        self.UnitsTableView.rowHeight = 90
        self.UnitsTableView.separatorColor = .clear
    }
    //Oculta la barra de estado
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//Configuración del CollectionView donde se muestran las materias
extension ExamenesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MateriasCollectionView.dequeueReusableCell(withReuseIdentifier: "MateriasCollectionViewCellEx", for: indexPath) as! MateriasCollectionViewCellEx
        
        cell.materiasNameLabel.text = materias[indexPath.row].materia
        cell.materiasImage.image = UIImage(named: materias[indexPath.row].imgName)
        if cell.isSelected{
            cell.backgroundColor = .white
        }
        else{
            cell.backgroundColor = .gray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        for cellIndex in 0 ... materias.count {
            if cellIndex == indexPath.row {
                let cell = self.MateriasCollectionView.cellForItem(at: IndexPath(item: cellIndex, section: 0)) as? MateriasCollectionViewCellEx
                cell?.backgroundColor = .white
                cell?.isSelected = true
            }
            else{
                let cell = self.MateriasCollectionView.cellForItem(at: IndexPath(item: cellIndex, section: 0)) as? MateriasCollectionViewCellEx
                cell?.backgroundColor = .gray
                cell?.isSelected = false
            }
        }
        self.selectedCourse = indexPath.row
        self.UnitsTableView.reloadData()
    }
}

//Configuración de UnitsTableView
extension ExamenesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias[selectedCourse].unidad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.UnitsTableView.dequeueReusableCell(withIdentifier: "unitsCell", for: indexPath) as! UnitsCell
        cell.backgroundColor = .clear
        cell.unitNameLbl.text = materias[selectedCourse].unidad[indexPath.row].unidadName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    }
    
}
