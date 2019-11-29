//
//  Common.swift
//  CCE
//
//  Created by Carlos Ramírez on 8/10/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Foundation


struct NavigationTitle {
    static let newStudent = "Nuevo Alumno"
    static let home = "School Check"
    static let paymentHistory = "Historial de Pagos"
    static let assignPay = "Asignación de Pagos"
    
}


struct SegueIdentifiers {
    static let toPaymentRecord = "segueToPaymentRecord"
    static let addNewStudent = "segueAddNew"
    static let toNavigationController = "segueNavigation"
    static let toPay = "segueGoToPay"
}

struct Message {
    static let allowEdit = "Ya se puede editar los campos"
    static let saveDataSuccess = "Los datos capturados han sido guardados con éxito"
    static let emptyFields = "Favor de llenar todo los campos"
    static let wrongFields = "Usuario o contraseña incorrectos"
    static let errorUploading = "No se pudo guardar la información, vuelva a intentarlo."
    static let wrongEmail = "El email no es valido"
    static let loading = "Cargando"
    static let saving = "Guardando"
}

struct Title {
    static let allowEdit = "Edición Activada"
    static let saveDataSuccess = "Datos Guardados"
    static let titleUps = "Uuuppss..."
}


struct FirebaseCollection {
    static let studentData = "students_data"
    static let studentsDataPaymentHistory = "students_data_payment_history"
    static let userAccess = "Users_Access"
}



//A2D8C7 color de fondo
//B8FFF2 color de fonde de txtField
// El Chido!
