//
//  Countries.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 20/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

struct Country: Equatable {
    let name: String
    let image: UIImage
    
    static func getAllCountries() -> [Country]{
        
        return [
            Country(name: "Afeganistão", image: UIImage(named: "afghanistan")!),
            Country(name: "África do Sul", image: UIImage(named: "south-africa")!),
            Country(name: "Albânia", image: UIImage(named: "albania")!),
            Country(name: "Argélia", image: UIImage(named: "algeria")!),
            Country(name: "Alemanha", image: UIImage(named: "germany")!),
            Country(name: "Andorra", image: UIImage(named: "andorra")!),
            Country(name: "Angola", image: UIImage(named: "angola")!),
            Country(name: "Argentina", image: UIImage(named: "argentina")!),
            Country(name: "Armênia", image: UIImage(named: "armenia")!),
            Country(name: "Austrália", image: UIImage(named: "australia")!),
            Country(name: "Áustria", image: UIImage(named: "austria")!),
            Country(name: "Azerbaijão", image: UIImage(named: "azerbaijan")!),
            Country(name: "Bahamas", image: UIImage(named: "bahamas")!),
            Country(name: "Barém", image: UIImage(named: "bahrain")!),
            Country(name: "Bangladesh", image: UIImage(named: "bangladesh")!),
            Country(name: "Barbados", image: UIImage(named: "barbados")!),
            Country(name: "Belarus", image: UIImage(named: "belarus")!),
            Country(name: "Bélgica", image: UIImage(named: "belgium")!),
            Country(name: "Belize", image: UIImage(named: "belize")!),
            Country(name: "Benin", image: UIImage(named: "benin")!),
            Country(name: "Butão", image: UIImage(named: "bhutan")!),
            Country(name: "Bolívia", image: UIImage(named: "bolivia")!),
            Country(name: "Bósnia e Herzegovina", image: UIImage(named: "bosnia-and-herzegovina")!),
            Country(name: "Botsuana", image: UIImage(named: "botswana")!),
            Country(name: "Brasil", image: UIImage(named: "brazil")!),
            Country(name: "Brunei", image: UIImage(named: "brunei")!),
            Country(name: "Bulgária", image: UIImage(named: "bulgaria")!),
            Country(name: "Burkina", image: UIImage(named: "burkina")!),
            Country(name: "Birmânia", image: UIImage(named: "myanmar")!),
            Country(name: "Burundi", image: UIImage(named: "burundi")!),
            Country(name: "Cabo Verde", image: UIImage(named: "cape-verde")!),
            Country(name: "Camarões", image: UIImage(named: "cameroon")!),
            Country(name: "Catar", image: UIImage(named: "qatar")!),
            Country(name: "Camboja", image: UIImage(named: "cambodia")!),
            Country(name: "Coréia do Norte", image: UIImage(named: "north-korea")!),
            Country(name: "Canadá", image: UIImage(named: "canada")!),
            Country(name: "Chade", image: UIImage(named: "chad")!),
            Country(name: "China", image: UIImage(named: "china")!),
            Country(name: "Chile", image: UIImage(named: "chile")!),
            Country(name: "Colômbia", image: UIImage(named: "colombia")!),
            Country(name: "Costa do Marfim", image: UIImage(named: "ivory-coast")!),
            Country(name: "Comores", image: UIImage(named: "comoros")!),
            Country(name: "Cazaquistão", image: UIImage(named: "kazakhstan")!),
            Country(name: "Costa Rica", image: UIImage(named: "costa-rica")!),
            Country(name: "Croácia", image: UIImage(named: "croatia")!),
            Country(name: "Coréia do Sul", image: UIImage(named: "south-korea")!),
            Country(name: "Cuba", image: UIImage(named: "cuba")!),
            Country(name: "Chipre", image: UIImage(named: "cyprus")!),
            Country(name: "Dinamarca", image: UIImage(named: "denmark")!),
            Country(name: "Djibuti", image: UIImage(named: "djibouti")!),
            Country(name: "Dominica", image: UIImage(named: "dominica")!),
            Country(name: "Equador", image: UIImage(named: "ecuador")!),
            Country(name: "Egito", image: UIImage(named: "egypt")!),
            Country(name: "Espanha", image: UIImage(named: "spain")!),
            Country(name: "Estados Unidos", image: UIImage(named: "united-states-of-america")!),
            Country(name: "Emirados Árabes Unidos", image: UIImage(named: "united-arab-emirates")!),
            Country(name: "El Salvador", image: UIImage(named: "el-salvador")!),
            Country(name: "Eritreia", image: UIImage(named: "eritrea")!),
            Country(name: "Eslováquia", image: UIImage(named: "slovakia")!),
            Country(name: "Estônia", image: UIImage(named: "estonia")!),
            Country(name: "Fiji", image: UIImage(named: "fiji")!),
            Country(name: "Filipinas", image: UIImage(named: "philippines")!),
            Country(name: "Finlândia", image: UIImage(named: "finland")!),
            Country(name: "França", image: UIImage(named: "france")!),
            Country(name: "Gabão", image: UIImage(named: "gabon")!),
            Country(name: "Gâmbia", image: UIImage(named: "gambia")!),
            Country(name: "Geórgia", image: UIImage(named: "georgia")!),
            Country(name: "Granada", image: UIImage(named: "grenada")!),
            Country(name: "Grécia", image: UIImage(named: "greece")!),
            Country(name: "Guatemala", image: UIImage(named: "guatemala")!),
            Country(name: "Guiné Equatorial", image: UIImage(named: "equatorial-guinea")!),
            Country(name: "Guiné", image: UIImage(named: "guinea")!),
            Country(name: "Guiné Bissau", image: UIImage(named: "guinea-bissau")!),
            Country(name: "Haiti", image: UIImage(named: "haiti")!),
            Country(name: "Holanda", image: UIImage(named: "netherlands")!),
            Country(name: "Honduras", image: UIImage(named: "honduras")!),
            Country(name: "Hungria", image: UIImage(named: "hungary")!),
            Country(name: "Iêmen", image: UIImage(named: "yemen")!),
            Country(name: "Islândia", image: UIImage(named: "iceland")!),
            Country(name: "Índia", image: UIImage(named: "india")!),
            Country(name: "Ilhas Salomão", image: UIImage(named: "solomon-islands")!),
            Country(name: "Indonésia", image: UIImage(named: "indonesia")!),
            Country(name: "Irã", image: UIImage(named: "iran")!),
            Country(name: "Irlanda", image: UIImage(named: "ireland")!),
            Country(name: "Israel", image: UIImage(named: "israel")!),
            Country(name: "Itália", image: UIImage(named: "italy")!),
            Country(name: "Jamaica", image: UIImage(named: "jamaica")!),
            Country(name: "Japão", image: UIImage(named: "japan")!),
            Country(name: "Jordânia", image: UIImage(named: "jordan")!),
            Country(name: "Kuwait", image: UIImage(named: "kwait")!),
            Country(name: "Laos", image: UIImage(named: "laos")!),
            Country(name: "Letônia", image: UIImage(named: "latvia")!),
            Country(name: "Líbano", image: UIImage(named: "lebanon")!),
            Country(name: "Lesoto", image: UIImage(named: "lesotho")!),
            Country(name: "Libéria", image: UIImage(named: "liberia")!),
            Country(name: "Liechtenstein", image: UIImage(named: "liechtenstein")!),
            Country(name: "Lituânia", image: UIImage(named: "lithuania")!),
            Country(name: "Luxemburgo", image: UIImage(named: "luxembourg")!),
            Country(name: "Macedônia", image: UIImage(named: "republic-of-macedonia")!),
            Country(name: "Madagascar", image: UIImage(named: "madagascar")!),
            Country(name: "Malásia", image: UIImage(named: "malasya")!),
            Country(name: "Malaui", image: UIImage(named: "malawi")!),
            Country(name: "Maldivas", image: UIImage(named: "maldives")!),
            Country(name: "Máli", image: UIImage(named: "mali")!),
            Country(name: "Malta", image: UIImage(named: "malta")!),
            Country(name: "Maurício", image: UIImage(named: "mauritius")!),
            Country(name: "Mauritânia", image: UIImage(named: "mauritania")!),
            Country(name: "México", image: UIImage(named: "mexico")!),
            Country(name: "Marrocos", image: UIImage(named: "morocco")!),
            Country(name: "Moldávia", image: UIImage(named: "moldova")!),
            Country(name: "Mônaco", image: UIImage(named: "monaco")!),
            Country(name: "Mongólia", image: UIImage(named: "mongolia")!),
            Country(name: "Montenegro", image: UIImage(named: "montenegro")!),
            Country(name: "Moçambique", image: UIImage(named: "mozambique")!),
            Country(name: "Myanmar", image: UIImage(named: "myanmar")!),
            Country(name: "Namíbia", image: UIImage(named: "namibia")!),
            Country(name: "Nepal", image: UIImage(named: "nepal")!),
            Country(name: "Nova Zelândia", image: UIImage(named: "new-zealand")!),
            Country(name: "Nicarágua", image: UIImage(named: "nicaragua")!),
            Country(name: "Níger", image: UIImage(named: "niger")!),
            Country(name: "Nigéria", image: UIImage(named: "nigeria")!),
            Country(name: "Niue", image: UIImage(named: "niue")!),
            Country(name: "Noruega", image: UIImage(named: "norway")!),
            Country(name: "Omã", image: UIImage(named: "oman")!),
            Country(name: "Palestina", image: UIImage(named: "palestine")!),
            Country(name: "Paquistão", image: UIImage(named: "pakistan")!),
            Country(name: "Panamá", image: UIImage(named: "panama")!),
            Country(name: "Papua Nova Guiné", image: UIImage(named: "papua-new-guinea")!),
            Country(name: "Paraguai", image: UIImage(named: "paraguay")!),
            Country(name: "Peru", image: UIImage(named: "peru")!),
            Country(name: "Polônia", image: UIImage(named: "poland")!),
            Country(name: "Portugal", image: UIImage(named: "portugal")!),
            Country(name: "Quênia", image: UIImage(named: "kenya")!),
            Country(name: "Quiribati", image: UIImage(named: "kiribati")!),
            Country(name: "Quirguistão", image: UIImage(named: "kyrgyzstan")!),
            Country(name: "Romênia", image: UIImage(named: "romania")!),
            Country(name: "República Dominicana", image: UIImage(named: "dominican-republic")!),
            Country(name: "República Centro-Africana", image: UIImage(named: "central-african-republic")!),
            Country(name: "República Tcheca", image: UIImage(named: "czech-republic")!),
            Country(name: "República Democrática do Congo", image: UIImage(named: "democratic-republic-of-congo")!),
            Country(name: "Rússia", image: UIImage(named: "russia")!),
            Country(name: "Reino Unido", image: UIImage(named: "united-kingdom")!),
            Country(name: "Ruanda", image: UIImage(named: "rwanda")!),
            Country(name: "Santa Lúcia", image: UIImage(named: "st-lucia")!),
            Country(name: "São Cristóvão e Nevis", image: UIImage(named: "saint-kitts-and-nevis")!),
            Country(name: "São Marino", image: UIImage(named: "san-marino")!),
            Country(name: "São Tomé e Príncipe", image: UIImage(named: "sao-tome-and-prince")!),
            Country(name: "São Vicente e Granadinas", image: UIImage(named: "st-vincent-and-the-grenadines")!),
            Country(name: "Senegal", image: UIImage(named: "senegal")!),
            Country(name: "Sérvia", image: UIImage(named: "serbia")!),
            Country(name: "Seicheles", image: UIImage(named: "seychelles")!),
            Country(name: "Serra Leoa", image: UIImage(named: "sierra-leone")!),
            Country(name: "Singapura", image: UIImage(named: "singapore")!),
            Country(name: "Somália", image: UIImage(named: "somalia")!),
            Country(name: "Sudão do Sul", image: UIImage(named: "south-sudan")!),
            Country(name: "Sri Lanka", image: UIImage(named: "sri-lanka")!),
            Country(name: "Sudão", image: UIImage(named: "sudan")!),
            Country(name: "Suriname", image: UIImage(named: "suriname")!),
            Country(name: "Suazilândia", image: UIImage(named: "swaziland")!),
            Country(name: "Suécia", image: UIImage(named: "sweden")!),
            Country(name: "Suíça", image: UIImage(named: "switzerland")!),
            Country(name: "Síria", image: UIImage(named: "syria")!),
            Country(name: "Tajiquistão", image: UIImage(named: "tajikistan")!),
            Country(name: "Tailândia", image: UIImage(named: "thailand")!),
            Country(name: "Togo", image: UIImage(named: "togo")!),
            Country(name: "Timor Leste", image: UIImage(named: "east-timor")!),
            Country(name: "Trindade e Tobago", image: UIImage(named: "trinidad-and-tobago")!),
            Country(name: "Tunísia", image: UIImage(named: "tunisia")!),
            Country(name: "Turcomenistão", image: UIImage(named: "turkmenistan")!),
            Country(name: "Turquia", image: UIImage(named: "turkey")!),
            Country(name: "Tuvalu", image: UIImage(named: "tuvalu")!),
            Country(name: "Ucrânia", image: UIImage(named: "ukraine")!),
            Country(name: "Uganda", image: UIImage(named: "uganda")!),
            Country(name: "Usbequistão", image: UIImage(named: "uzbekistn")!),
            Country(name: "Vanuatu", image: UIImage(named: "vanuatu")!),
            Country(name: "Venezuela", image: UIImage(named: "venezuela")!),
            Country(name: "Vietnã", image: UIImage(named: "vietnam")!),
            Country(name: "Zâmbia", image: UIImage(named: "zambia")!),
            Country(name: "Zimbábue", image: UIImage(named: "zimbabwe")!)
            ]
    }


    static func getNames() -> [String]{
        let countries = getAllCountries()
        var names: [String] = []
        for item in countries{
            names.append(item.name)
        }
        return names
    }
    
    static func alphaDictionary() -> Dictionary<String, [Country]>{
        let countries = getAllCountries()
        
        let a = Array(countries[0..<12])
        let b = Array(countries[12..<30])
        let c = Array(countries[30..<48])
        let d = Array(countries[48..<51])
        let e = Array(countries[51..<60])
        let f = Array(countries[60..<64])
        let g = Array(countries[64..<73])
        let h = Array(countries[73..<77])
        let i = Array(countries[77..<86])
        let j = Array(countries[86..<89])
        let k = Array(countries[89..<90])
        let l = Array(countries[90..<98])
        let m = Array(countries[98..<115])
        let n = Array(countries[115..<123])
        let o = Array(countries[123..<124])
        let p = Array(countries[124..<132])
        let q = Array(countries[132..<135])
        let r = Array(countries[135..<143])
        let s = Array(countries[143..<162])
        let t = Array(countries[162..<171])
        let u = Array(countries[171..<174])
        let v = Array(countries[174..<177])
        let z = Array(countries[177..<179])
        
        
        
        let dict = ["A": a,
                    "B": b,
                    "C": c,
                    "D": d,
                    "E": e,
                    "F": f,
                    "G": g,
                    "H": h,
                    "I": i,
                    "J": j,
                    "K": k,
                    "L": l,
                    "M": m,
                    "N": n,
                    "O": o,
                    "P": p,
                    "Q": q,
                    "R": r,
                    "S": s,
                    "T": t,
                    "U": u,
                    "V": v,
                    "Z": z]
        
        return dict
    }
}

