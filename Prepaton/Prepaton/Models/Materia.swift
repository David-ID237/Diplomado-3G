//
//  Materia.swift
//  Prepaton
//
//  Created by Elektra Natchos on 7/13/19.
//  Copyright © 2019 José Gutiérrez. All rights reserved.
//

import Foundation

class Materia {
    var materia: String
    var imgName: String
    var unidad = [Unidad]()
    
    init() {
        self.materia = String()
        self.imgName = String()
    }
    
    init(materia: String, imageName: String) {
        self.materia = materia
        self.imgName = imageName
    }
}


extension Materia {
    func setInitialModules() -> [Materia]{
        var materias = [Materia]()
        
        //Creates the courses and their images
        materias.append(Materia(materia: "Español", imageName: "spanish"))
        materias.append(Materia(materia: "Matemáticas", imageName: "math"))
        materias.append(Materia(materia: "H. Universal", imageName: "universalh"))
        materias.append(Materia(materia: "Física", imageName: "physics"))
        materias.append(Materia(materia: "Geografía", imageName: "geography"))
        materias.append(Materia(materia: "H. de México", imageName: "mexicanh"))
        materias.append(Materia(materia: "Filosofía", imageName: "philosophy"))
        materias.append(Materia(materia: "Química", imageName: "chemistry"))
        materias.append(Materia(materia: "Biología", imageName: "biology"))
        materias.append(Materia(materia: "Literatura", imageName: "literature"))
        
        
        // Creation of the first Unit for Español
        let referencial = Modulo(moduleName: "Referencial", pregunta: [
            Pregunta(enunciado: "¿Cuáles son los 3 elementos de la comunicación?", opciones: ["Interlocutores, mensaje y canal","Hablante, oyente y lenguaje","Interlocutores, canal y lenguaje","Hablante, oyente y canal"], respuesta: 1),
            Pregunta( enunciado: "¿En cuál de los siguientes enunciados se utiliza la función referencial de la lengua?", opciones: ["En tus ojos peleaban las llamas del crepúsculo.","El arte es el alimento del espíritu.","El pasado martes, el equipo de mecatrónica se hizo acreedor del premio Francisco Gutiérrez.","Querer es poder."], respuesta: 3),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función referencial de la lengua?", opciones: ["Las hojas recogían tu voz lenta y en calma.","No rebase la línea amarilla.","Favor de no fumar.","Hubo 57 heridos a causa del accidente."], respuesta: 4),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función referencial de la lengua?", opciones: ["Favor de no fumar.","Ayuda a la señora, por favor.","Empieza el llanto de la guitarra.","Esa tarde, el joven comió carne y ensalada"], respuesta: 4),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función referencial de la lengua?", opciones: ["No rebase la línea amarilla","El susceso ocurrió el 7 de febrero","Las estrellas dudaron de su belleza","La felicidad es cuestión de actitud"], respuesta: 2),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se presenta un predominio de la función referencial de la lengua?\n\na)Dame, Dorila el vaso,\nlleno de dulce vino;\nque sólo en ver la nieve\nestoy temblando de frío.\nb)Desde luego, no es fácil para el hombre moderno occidental sentir placer independientemente de la orientación de carácter.\nc)Cuando Helena se dio cuenta de lo que había hecho, rompió en llanto y llamó al señor de la casa.\nd)Según los últimos informes, el número de víctimas con riesgo de muerte debido al terremoto de 7.8 grados en la escala de Richter al sur de Ecuador, ha aumentado a más de 275 personas.", opciones: ["A","B", "C","D"], respuesta: 4)])
        
        let poetica = Modulo(moduleName: "Poética", pregunta: [
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función poética de la lengua?", opciones: ["Querer es poder.","Tráeme un vaso con agua.","Cierre la puerta al salir.","Tus dientes de perla."], respuesta: 4),
            Pregunta( enunciado: "¿En cuál de los siguientes enunciados se utiliza la función poética de la lengua?", opciones: ["Eres el sol que ilumina mi día","Cuando subí, ella ya se había ido.","El martes 24 fue encontrado muerto en su cama.","Cierra la puerta, por favor."], respuesta: 1),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función poética de la lengua?", opciones: ["No comas y hables al mismo tiempo.","Hermoso, como el color de tu sonrisa.","Fue entonces que descubrió la mentira.","Apaga la luz."], respuesta: 2),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se presenta un predominio de la función poética de la lengua?\n\n\na)Dame, Dorila el vaso,\nlleno de dulce vino;\nque sólo en ver la nieve\nestoy temblando de frío.\n\nb)Desde luego, no es fácil para el hombre moderno occidental sentir placer independientemente de la orientación de carácter.\n\nc)Cuando Helena se dio cuenta de lo que había hecho, rompió en llanto y llamó al señor de la casa.\n\nd)Según los últimos informes, el número de víctimas con riesgo de muerte debido al terremoto de 7.8 grados en la escala de Richter al sur de Ecuador, ha aumentado a más de 275 personas.", opciones: ["A","B", "C","D"], respuesta: 1)])
        
        let apelativa = Modulo(moduleName: "Apelativa", pregunta: [
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función apelativa de la lengua?", opciones: ["Eres el sol que ilumina mi día.","Se enfrentaron cuatro contra cinco.","Una experiencia nunca es un fracaso, pues viene siempre acompañada de aprendizaje.","El camión giró rápidamente y no lo volví a ver."], respuesta: 3),
            Pregunta( enunciado: "¿En cuál de los siguientes enunciados se utiliza la función apelativa de la lengua?", opciones: ["Cierra la puerta al salir.","Tus cabellos de oro.","Juan pasó a secto año.","Tus labios son pétalos de rosa."], respuesta: 1),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se utiliza la función apelativa de la lengua?", opciones: ["Empieza el llanto de la guitarra.","Ayuda a la señora, por favor.","Se levantó de la mesa y prendió un cigarrillo.","Cuando hubo terminado, se retiró."], respuesta: 2),
            Pregunta(enunciado: "¿En cuál de los siguientes enunciados se presenta un predominio de la función apelativa de la lengua?\n\n\na)El pasado miércoles, la cámara de diputados aunció un recorte de presupuesto a todos sus miembros debido a la crisis financiera que azotó al país el año pasado.\n\nb)De evitar hablársele a los jóvenes del éxito económico como si fuera el principal objetivo de la vida. La razón más importante para trabajar es el placer de trabajar, que radica en la satisfacción de ver los resultados y el saber el benificio que dicho trabajo aporta a la comunidad.\n\nc)Si de mi baja lira\ntanto pudiese el son, que un momento\naplacase la lira\ndel animoso viento,\ny la furia del mar y el movimiento.\n\nd)Al caer la noche, Emily subió sigilosamente a su cuarto y entró en la habitación que tanta curiosidad le provocaba.", opciones: ["A","B", "C","D"], respuesta: 2)])
        let funcionesDeLaLengua = Unidad(unidadName: "Funciones de la lengua", modulo: [referencial, poetica, apelativa])
        
        materias[0].unidad.append(funcionesDeLaLengua)
        
        
        // Creation of the firs Unit for Matematicas
        let sumaYRestaDeNumerosReales = Modulo(moduleName: "Suma y resta de números reales", pregunta: [
            Pregunta(enunciado: "El resultado de 5+2-4+3 es", opciones: ["9","8","6","14"], respuesta: 3),
            Pregunta(enunciado: "El resultado de 12-4-8-3 es", opciones: ["-5","3","8","-3"], respuesta: 4),
            Pregunta(enunciado: "El resultado de -5+7-10+13+5-7 es", opciones: ["3","-6","7","-10"], respuesta: 1),
            Pregunta(enunciado: "El resultado de la suma -10+3-4+7 es", opciones: ["13","-13","10","-7"], respuesta: 2),
            Pregunta(enunciado: "El resultado de sumar -13+7-6+8-5+4 es", opciones: ["-5","5","11","-13"], respuesta: 1)])
        
        let operaciones = Unidad(unidadName: "Operaciones", modulo: [sumaYRestaDeNumerosReales])
        materias[1].unidad.append(operaciones)
        
        
        
        
        //Creation of the first Unit for Historia Universal
        let utilidadDeLaHistoria = Modulo(moduleName: "Utilidad de la historia", pregunta: [
            Pregunta(enunciado: "Relaciona cada una de las corrientes de interpretación históricas con sus representantes.\n\nI. Positivismo\nII. Materialismo Histórico\nIII. Estructuralismo\nIV. Historicismo\nV. Escuela de los Anales\n\nA. Fernand Braudel\nB. Claude Levy-Strauss\nC. August Comté, Emil Durkheim\nD. Karl Marx, Friederich Engels\nE. Dilthey, José Ortega y Gasset", opciones: ["I:B, II:C, III:E, IV: A, V:D","I:A, II:B, III:C, IV: D, V:E","I:C, II:D, III:B, IV: E, V:A","I:E, II:A, III:D, IV: B, V:C"], respuesta: 3),
            Pregunta(enunciado: "Relaciona cada una de las corrientes de interpretación históricas con sus representantes.\n\nI. Positivismo\nII. Materialismo Histórico\nIII. Estructuralismo\nIV. Historicismo\nV. Escuela de los Anales\n\nA. Destacar la importacia del medio geográfico y de la estructura social en el desarrollo de la historia.\nB. Lucha de clases, se usa al estado como instrumento al servicio de la clase explotadora, periodización de acuerdo a los modos de producción.\nC. Las instituciones juegan un papel muy importante en el desarrollo de la historia, formular leyes generales para explicar el desarrollo de la historia.\nD. Explicar la historia desde la metodología de las ciencias experimentales, establecer leyes del desarrollo social\nE. Niega la existencia de leyes históricas, cada hecho histórico sucede de una manera única e irrepetible.", opciones: ["I:D, II:B, III:C, IV:E, V:A","I:B, II:C, III:A, IV:B, V:D","I:E, II:D, III:C, IV:A, V:B","I:A, II:E, III:B, IV:D, V:C"], respuesta: 1),
            Pregunta(enunciado: "Introducir el concepto de la lucha de clases es una idea propuesta por", opciones: ["el historicismo","el materialismo histórico","la escuela de los annales","el estructuralismo"], respuesta: 2),
            Pregunta(enunciado: "Destacar la importancia del medio geográfico y de la estructura social en el desarrollo de la historia es una idea propuesta por", opciones: ["el positivismo","el historicismo","el materialismo histórico","la escuela de los annales"], respuesta: 4),
            Pregunta(enunciado: "Negar la existencia de leyes históricas y postular que los hechos históricos suceden de una manera única e irrepetible es una idea introducida por", opciones: ["el estructuralismo","el historicismo","el materialismo histórico","el positivismo"], respuesta: 2),
            Pregunta(enunciado: "Postular que las instituciones juegan un papel muy importante en el desarrollo de la historia y formular leyes generales para explicar el desarrollo de la historia son producto de", opciones: ["el historicismo","el estructuralismo","la escuela de los annales","el materialismo histórico"], respuesta: 2),
            Pregunta(enunciado: "Explicar la historia desde la metodología de las ciencias experimentales y establecer las leyes del desarrollo social son objetivos de", opciones: ["el positivismo","el historicismo","el materialismo histórico","el estructuralismo"], respuesta: 1)])
        
        let laHistoria = Unidad(unidadName: "La Historia", modulo: [utilidadDeLaHistoria])
        
        //Creation of the second Unit for Historia Universal
        let ilustración = Modulo(moduleName: "Las ideas de la Ilustración", pregunta: [
            Pregunta(enunciado: "Es una de las ideas fundamentales de la ilustración", opciones: ["Utilizar el pensamiento racionalista para entender y conocer el mundo.","Expandir la religión católica y demostrar la autencidad de los evangelios.","Utilizar los castigos físicos en contra de personas que se rebelaran al orden establecido.","Surgimiento del humanismo renacentista."], respuesta: 1),
            Pregunta(enunciado: "Personajes protagonistas del enciclopedismo.", opciones: ["Voltaire, Rousseau, Montesquieu y Diderot.","Platón, Sócrates y Aristóteles","Hittler y Mussolini","George Washington y Thomas Jefferson"], respuesta: 1),
            Pregunta(enunciado: "El movimiento de la ilustración fundamenta su visión del mundo en", opciones: ["el liberalismo.","el imperialismo.","el totalitarismo.","el racionalismo."], respuesta: 4),
            Pregunta(enunciado: "Durante ___ floreció el pensamiento ___ y liberal.", opciones: ["el humanismo - racional","la ilustración - racionalista","el humanismo - religioso", "la ilustración - religioso"], respuesta: 2),
            Pregunta(enunciado: "Nación que fungió como el epicentro de la ilustración.", opciones: ["Suecia","Alemania","Portugal","Francia"], respuesta: 4),
            Pregunta(enunciado: "Movimiento basado en el pensamiento racional que surgió en Francia durante el siglo XVIII.", opciones: ["Renacimiento","Ilustración","Humanismo","Revolución Industrial"], respuesta: 2),
            Pregunta(enunciado: "Movimiento que fundamenta su visión del mundo en el pensamiento racionalista.", opciones: ["Revolución Industrial","Humanismo","Renacimiento","Ilustración"], respuesta: 4),
            Pregunta(enunciado: "Corriente filosófica en la que se basa el movimiento de la ilustración.", opciones: ["Racionalismo", "Idealismo", "Socialismo utópico", "Comunismo"], respuesta: 1),
            Pregunta(enunciado: "El Enciclopedismo tenía como objetivo:", opciones: ["promulgar las doctrinas comunistas.","divulgar el saber de su tiempo, en aras del desarrollo social y económico.","difundir las ideas religiosas del papado.",""], respuesta: 2),
            Pregunta(enunciado: "Movimiento filosófico y pedagógico que se proponía concentrar todo el conocimiento de su tiempo.", opciones: ["Enciclopedismo.","Ludimso.","Renacimiento.","Socialismo."], respuesta: 1)])
        let revolucionesBurguesas = Unidad(unidadName: "Las Revoluciones Burguesas", modulo: [ilustración])
        materias[2].unidad.append(laHistoria)
        materias[2].unidad.append(revolucionesBurguesas)
        
        //Creation of the first Unit for Fisica
        let mru = Modulo(moduleName: "Movimiento Rectilíneo Uniforme", pregunta: [
            Pregunta(enunciado: "Para un objeto que se mueve a velocidad constante la rapidez es", opciones: ["menor a la velocidad del objeto.","igual que la magnitud del vector de su velocidad.","mayor a la velocidad del objeto","la rapidez es igual a cero"], respuesta: 2),
            Pregunta(enunciado: "¿Cuál es la velocidad media de un automóvil que recorre 180 kilómetros en 6 horas?", opciones: ["45 km/h","3 km/h","30 km/h","78 km/h"], respuesta: 3),
            Pregunta(enunciado: "¿Cuál es la velocidad media de una pelota que recorre 40 metros en dos segundos?", opciones: ["20 m/s","80 m/s","8 m/s","40 m/s"], respuesta: 1),
            Pregunta(enunciado: "¿Cuál es la velocidad media de un objeto que recorre 60 kilómetros en 4 horas", opciones: ["24 m/s","150 m/s","2.4 km/h","15 km/h"], respuesta: 4),
            Pregunta(enunciado: "Calcula la distancia que recorre un objeto que viaja a 33 m/s durante 40 segundps", opciones: ["120 m","1320 m","1.5 m","750 m"], respuesta: 2),
            Pregunta(enunciado: "Calcula la distancia que recorre un automóvil que viaja a 25 km/h durante una hora y media", opciones: ["12.5 km","3750 m","37.5 km","35 km"], respuesta: 3),
            Pregunta(enunciado: "Calcula la distancia que recorre un objeto que viaja a 4.5 km/h durante 5 horas.", opciones: ["20 km","250 m","250 km","22.5 km"], respuesta: 4),
            Pregunta(enunciado: "Calcula el tiempo que tarda un objeto en recorrer 150 km si viaja a una razón de 50 km/h.", opciones: ["3 h","30 min","6 h","150 min"], respuesta: 1),
            Pregunta(enunciado: "¿Cuál es el tiempo que tarda un automóvil de carreras en dar la vuelta a una pista de 40 km si su velocidad media durante el trayecto fue de 150 km/h?", opciones: ["3 h","60 min","0.266 h","6 h"], respuesta: 3),
            Pregunta(enunciado: "Calcula el tiempo que tarda un objeto en recorrer 3500 m si viaja a una razón de 70 m/s.", opciones: ["5 min","50 s","500 s","2.5 min"], respuesta: 2)])
        
        let mua = Modulo(moduleName: "Movimiento Uniformemente Acelerado", pregunta: [
            Pregunta(enunciado: "Si un cuerpo que parte del reposo alcanza una velocidad de 50 m/s en 5 segundos, ¿cuál es su aceleración media?", opciones: ["10 m/s^2","5 m/s^2","20 m/s^2","15 m/s^2"], respuesta: 1),
            Pregunta(enunciado: "¿Cuál es la velocidad final de un objeto que comienza a moverse a una razón de 25 m/s con una aceleración de 2 m/s^2 durante 40 segundos?", opciones: ["50 m/s","40 m/s","80 m/s","30 m/s"], respuesta: 3),
            Pregunta(enunciado: "Calcula la distancia que recorre un automóvil en 10 segundos si empezó su movimiento con una velocidad de 30 m/s y una aceleración de 3 m/s^2.", opciones: ["1 km","450 m","4.5 km","200 m"], respuesta: 2),
            Pregunta(enunciado: "¿Cuál es la aceleración de un cuerpo que pasó de moverse a una velocidad de 15 m/s a una velocidad de 60 m/s en 3 segundos", opciones: ["3 m/s^2","10 m/s^2","2 m/s^2","15 m/s^2"], respuesta: 4),
            Pregunta(enunciado: "Una pelota es lanzada hacia arriba con una velocidad de 19.6 m/s. Calcule el tiempo que tarda en alcanzar su punto más alto, considerando la aceleración de la gravedad igual a 9.8 m/s^2 y despreciando la fricción del aire.", opciones: ["4 s","6 s","3.5 s","2 s"], respuesta: 4),
            Pregunta(enunciado: "Un automóvil parte del reposo con una aceleración de 2 m/s^2, ¿cuál es la distancia que recorre después de 15 segundos?", opciones: ["450 m","500 m","225 m","300 m"], respuesta: 3)])
        
        let cinemática = Unidad(unidadName: "Cinemática", modulo: [mru, mua])
        
        materias[3].unidad.append(cinemática)
        
        
        //Creation of the first Unit for Geografia
        let relacionDelHombreConLaNaturaleza = Modulo(moduleName: "Relación del hombre con la naturaleza", pregunta: [
            Pregunta(enunciado: "Se forman lentamente y permanecen de manera visible y estable", opciones: ["Fenómenos naturales","Hechos geográficos","Fenómenos geográficos","Hechos naturales"], respuesta: 2),
            Pregunta(enunciado: "Efectos que producen una modificación al paisaje y son observables", opciones: ["Fenómenos naturales","Hechos geográficos","Fenómenos geográficos","Hechos naturales"], respuesta: 3),
            Pregunta(enunciado: "Líneas imaginarias y paralelas entre sí y perpendiculares al eje terrestre", opciones: ["Meridianos","Paralelos","Vectores terrestres","Ángulos Geográficos"], respuesta: 2),
            Pregunta(enunciado: "Líneas imaginarias que van de polo a polo a través de la superficie terrestre", opciones: ["Meridianos","Paralelos","Vectores terrestres","Ángulos Geográficos"], respuesta: 1),
            Pregunta(enunciado: "Paralelo que divide a la Tierra en sentido horizontal formando los hemisferios norte y sur", opciones: ["Ecuador","Trópico de Cáncer","Trópico de Capricornio","Polar Antártico"], respuesta: 1)])
        
        let laTierra = Unidad(unidadName: "La Tiera", modulo: [relacionDelHombreConLaNaturaleza])
        materias[4].unidad.append(laTierra)
        
        //Creation of the first Unit for Historia de México
        let antecedentes = Modulo(moduleName: "Antecedentes", pregunta: [
            Pregunta(enunciado: "La Venta, San Lorenzo y Tres Zapotes fueron los centros ceremoniales en torno a los cuales se desarrolló la cultura", opciones: ["maya.","olmeca.","tolteca.","zapoteca."], respuesta: 2),
            Pregunta(enunciado: "Durante el período _____, que abarca del año 200 dC al 900 dC, tuvo lugar el esplendor de las civilizaciones mesoamericanas.", opciones: ["clásico","posclásico","histórico","preclásico"], respuesta: 1),
            Pregunta(enunciado: "A la civilizaión teotihuacana, que se estableció en el Valle de México, le debemos la invención de", opciones: ["la alfarería.","el calendario solar y lunar.","el mercado y los barrios.","la piedra del sol."], respuesta: 3),
            Pregunta(enunciado: "La alfarería y el avance en el desarrollo urbanístico son aportaciones de la civilización", opciones: ["zapoteca","olmeca","maya","huasteca-totonaca"], respuesta: 4),
            Pregunta(enunciado: "Relaciona cada una de las civilizaciones con el lugar geográfico en donde se desarrollaron\n\nI. Mayas\nII. Zapotecas\nIII. Mexica-Azteca\nIV. Olmeca\n\nA. Altiplano Central\nB. Valle de Oaxaca\nC. Chiapas, Campeche, Tabasco y Guatemala\nD. Veracruz y Tabasco", opciones: ["I:C, II:B, III:A, IV:D","I:B, II:A, III:D, IV:C","I:D, II:C, III:B, IV:A","I:A, II:D, III:C, IV:B"], respuesta: 1)])
        let descubrimientoYConquista = Modulo(moduleName: "Descubirmiento y conquista de México", pregunta: [
            Pregunta(enunciado: "A la derrota sufrida por Hernán Cortés a manos de los soldados mexicas entre el 30 de junio y la noche del 1 de julio de 1520 se le conoce como:", opciones: ["el día D.","la noche triste.","la conquista.","la venganza de Moctezuma."], respuesta: 2),
            Pregunta(enunciado: "Estado mexicano en el que Hernán Cortés funda el primer ayuntamiento europeo en la América Continental.", opciones: ["Michoacán","Yucatán","Veracruz","Sinaloa"], respuesta: 1),
            Pregunta(enunciado: "Fue el último tlatoani mexica.", opciones: ["Cuauhtémoc","Cuitláhuac","Moctezuma","Chimalpopoca"], respuesta: 1),
            Pregunta(enunciado: "Fecha de la caída de México-Tenochtitlan.", opciones: ["15 de marzo de 1521","12 de octubre de 1492","13 de agosto de 1521","27 de marzo de 1520"], respuesta: 3),
            Pregunta(enunciado: "Pueblo indígena que se alió a Hernán Cortés en contra de México-Tenochtitlán.", opciones: ["Toltecas","Zapotecas","Totonacas","Olmecas"], respuesta: 3),
            Pregunta(enunciado: "Factores que favorecieron a la conquista de Hernán Cortés.", opciones: ["La superioridad física de los españoles y la poca experiencia en guerra del imperio mexica.","La desventaja en número de los mexicas y la superioridad física de los españoles.","La poca experiencia en guerra de los mexicas y el avance tecnológico europeo.","La epidemia de viruela en Mesoamérica y el avance tecnológico europeo."], respuesta: 4),
            Pregunta(enunciado: "Después de la caída de México-Tenochtitlán, el objetivo de los españoles era evangelizar al pueblo indígena, con este fin, llegaron a México los primeros evangelizadores. ¿Cuántos eran y a qué congregación perteneciían?", opciones: ["12 misioneros franciscanos.","25 misioneros agustinos.","10 misioneros jesuítas.","12 misioneros dominicos."], respuesta: 1),
            Pregunta(enunciado: "Órdenes religiosas responsables de la primera evangelización en la Nueva España.", opciones: ["Agustinos, jesuitas y la orden de carmelitas descalzos.","Franciscanos, agustinos y jesuítas.","Franciscanos, agustinos y la orden de carmelitas descalzos.","Dominicos, jesuítas y agustinos."], respuesta: 2),
            Pregunta(enunciado: "Son cronistas de la conquista de México-Tenochtitlán.\nI. Bernal Díaz del Castillo\n Fray Bernardino de Sahagún\n Bartolomé de las Casas\n Manuel Payno\n Gustavo Adolfo Bécquer", opciones: ["I, II  y III","II, IV y V","I, III y IV","II, III y V"], respuesta: 1),
            Pregunta(enunciado: "La conquista de Mesoamérica concluye con la caída de México-Tenochtitlán en el año de ", opciones: ["1519","1492","1521","1534"], respuesta: 3)])
        let laNuevaEspaña = Unidad(unidadName: "La Nueva España", modulo: [antecedentes, descubrimientoYConquista])
        materias[5].unidad.append(laNuevaEspaña)
        
        
        //Creation of the first Unit for Filosofía. This is the same as in Historia
        materias[7].unidad.append(laNuevaEspaña)
        
        //Creation of the first Unit for Quimica. This is the same as in Matematicas
        materias[8].unidad.append(operaciones)
        
        //Creation of the first Unit for Biologia
        let teoriaCelular = Modulo(moduleName: "Teoría Celular", pregunta: [
            Pregunta(enunciado: "Los autores de la teoría celular son", opciones: ["M. Schleiden, T. Schwann y R. Virchow","C. Darwin, R. Virchow y L. Pasteur","C. Linneo, M. Schleiden y A. Flemming","E. Mayr, T. Schwann y C. Darwin"], respuesta: 1),
            Pregunta(enunciado: "Es un postulado de la teoría celular", opciones: ["las células realizan transferencia de calor.","las células necesitan un medio rico en oxígeno para sobrevivr.","todos los seres vivos están formados por células","las células son el organismo encargado de realizar la fotosíntesis"], respuesta: 3),
            Pregunta(enunciado: "Es un postulado de la teoría celular", opciones: ["las células son las encargadas de la respiración.","las funciones vitales de los organismos ocurren dentro de las células","las células sólo se encuentran en los organismo anaerobios","las células sólo se encuentran en organismos aerobios"], respuesta: 2),
            Pregunta(enunciado: "\"Todas las células proceden de células preexistentes\" es un postulado de" , opciones: ["El origen de las especies","Los axiomas celulares","Leyes Howard-Pasteur","La teoría celular"], respuesta: 4),
            Pregunta(enunciado: "¿Cuáles de los siguientes postulados pertenecen a la teoría celular?\n\n1. Las funciones vitales de los organismos ocurren dentro de las células.\n2. Todas las células proceden de células preexistentes.\n3. Todas las células nacen, se reproducen y mueren.\n4. Todos los seres vivos están formados por células.\n5. Las células de los organismos se renuevan cada cierto período", opciones: ["2, 4 y 5","1, 3 y 4","1, 2 y 4","3, 4 y 5"], respuesta: 4)])
        let celula = Unidad(unidadName: "La célula", modulo: [teoriaCelular])
        materias[8].unidad.append(celula)
        
        //Creation of the first Unit for Literature
        let textoPeriodistico = Modulo(moduleName: "El texto periodístico", pregunta: [
            Pregunta(enunciado: "El texto periodístico tiene como objetivo", opciones: ["informar.","motivar.","convencer.","preguntar."], respuesta: 1),
            Pregunta(enunciado: "Informar y narrar acontecimientos recientes de interés general es el principal objetivo del texto", opciones: ["científico.","literario.","periodístico.","poético"], respuesta: 3),
            Pregunta(enunciado: "Función de la lengua que más se utiliza en el texto periodístico.", opciones: ["Poética","Apelativa","Científica","Referencial"], respuesta: 4),
            Pregunta(enunciado: "La función referencial de la lengua es ampliamente utilizada en" , opciones: ["notas periodísticas.","novelas.","poemas.","cuentos."], respuesta: 1),
            Pregunta(enunciado: "Son algunos elementos del texto periodístico\n\nI. Encabezado\nII. Sumario\nIII. Diálogo\nIV. Estrofa\nV. Entrada o lead", opciones: ["II, III y V","I, II y V","I, III y IV","II, III y IV"], respuesta: 2)])
        let elTexto = Unidad(unidadName: "El Texto", modulo: [textoPeriodistico])
        materias[9].unidad.append(elTexto)
        return materias
    }
}

