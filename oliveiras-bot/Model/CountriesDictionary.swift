//
//  CountriesDictionary.swift
//  oliveiras-bot
//
//  Created by Julia Conti Mestre on 21/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import Foundation

class Countries {
    let countryDictionary = ["Afeganistão" : "Afghanistan",
                            "Albânia" : "Albania",
                            "Argélia" : "Algeria",
                            "Andorra" : "Andorra",
                            "Angola" : "Angola",
                            "Argentina" : "Argentina",
                            "Armênia" : "Armenia",
                            "Austrália" : "Australia",
                            "Áustria" : "Austria",
                            "Azerbaijão" : "Azerbaijan",
                            "Bahamas" : "Bahamas",
                            "Barém" : "Bahrain",
                            "Bangladesh" : "Bangladesh",
                            "Barbados" : "Barbados",
                            "Belarus" : "Belarus",
                            "Bélgica" : "Belgium",
                            "Belize" : "Belize",
                            "Benin" : "Benin",
                            "Butão" : "Bhutan",
                            "Bolívia" : "Bolivia",
                            "Bósnia e Herzegovina" : "Bosnia and Herzegovina",
                            "Botsuana" : "Botswana",
                            "Brasil" : "Brazil",
                            "Brunei" : "Brunei",
                            "Bulgária" : "Bulgaria",
                            "Burkina" : "Burkina Faso",
                            "Birmânia" : "Burma",
                            "Burundi" : "Burundi",
                            "Camboja" : "Cambodia",
                            "Camarões" : "Cameroon",
                            "Canadá" : "Canada",
                            "Cabo Verde" : "Cape Verde",
                            "Chade" : "Chad",
                            "República Centro-Africana" : "Central African Republic",
                            "Chile" : "Chile",
                            "China" : "China",
                            "Colômbia" : "Colombia",
                            "Camaroes" : "Comoros",
                            "Congo (Brazzaville)" : "Congo Brazzaville",
                            "Congo (Kinshasa)" : "Congo Kinshasa",
                            "Costa Rica" : "Costa Rica",
                            "Costa do Marfim" : "Cote d'Ivoire",
                            "Croácia" : "Croatia",
                            "Cuba" : "Cuba",
                            "Chipre" : "Cyprus",
                            "República Checa" : "Czechia",
                            "Dinamarca" : "Denmark",
                            "Diamond Princess" : "Diamond Princess",
                            "Djibuti" : "Djibouti",
                            "Dominica" : "Dominica",
                            "República Dominicana" : "Dominican Republic",
                            "Equador" : "Ecuador",
                            "Egito" : "Egypt",
                            "El Salvador" : "El Salvador",
                            "Guiné Equatorial" : "Equatorial Guinea",
                            "Inglaterra" : "England",
                            "Eritréia" : "Eritrea",
                            "Estônia" : "Estonia",
                            "Etiópia" : "Ethiopia",
                            "Fiji" : "Fiji",
                            "Finlândia" : "Finland",
                            "França" : "France",
                            "Gabão" : "Gabon",
                            "Gâmbia" : "Gambia",
                            "Georgia" : "Georgia",
                            "Alemanha" : "Germany",
                            "Gana" : "Ghana",
                            "Grã Bretanha" : "Great Britain",
                            "Grécia" : "Greece",
                            "Grenada" : "Grenada",
                            "Guatemala" : "Guatemala",
                            "Guiné" : "Guinea",
                            "Guiné-Bissau" : "Guinea-Bissau",
                            "Guiana" : "Guyana",
                            "Haiti" : "Haiti",
                            "Holanda" : "Holland",
                            "Honduras" : "Honduras",
                            "Hungria" : "Hungary",
                            "Islândia" : "Iceland",
                            "Índia" : "India",
                            "Indonésia" : "Indonesia",
                            "Irã" : "Iran",
                            "Iraque" : "Iraq",
                            "Irlanda" : "Ireland",
                            "Israel" : "Israel",
                            "Itália" : "Italy",
                            "Japão" : "Japan",
                            "Jamaica" : "Jamaica",
                            "Jordânia" : "Jordan",
                            "Cazaquistão" : "Kazakhstan",
                            "Quênia" : "Kenya",
                            "Kosovo" : "Kosovo",
                            "Quirguistão" : "Kyrgyzstan",
                            "Kuwait" : "Kuwait",
                            "Laos" : "Laos",
                            "Letônia" : "Latvia",
                            "Líbano" : "Lebanon",
                            "Lesoto" : "Lesotho",
                            "Libéria" : "Liberia",
                            "Líbia" : "Libya",
                            "Liechtenstein" : "Liechtenstein",
                            "Lituânia" : "Lithuania",
                            "Luxemburgo" : "Luxembourg",
                            "Macedônia" : "Macedonia",
                            "Madagascar" : "Madagascar",
                            "Malawi" : "Malawi",
                            "Malásia" : "Malaysia",
                            "Mali" : "Mali",
                            "Malta" : "Malta",
                            "Ilhas Maldivas" : "Maldives",
                            "Mauritânia" : "Mauritania",
                            "Maurício" : "Mauritius",
                            "México" : "Mexico",
                            "Moldávia" : "Moldova",
                            "Mônaco" : "Monaco",
                            "Mongólia" : "Mongolia",
                            "Montenegro" : "Montenegro",
                            "Marrocos" : "Morocco",
                            "Moçambique" : "Mozambique",
                            "MS Zaandam" : "MS Zaandam",
                            "Namíbia" : "Namibia",
                            "Nepal" : "Nepal",
                            "Países Baixos": "Netherlands",
                            "Nova Zelândia" : "New Zealand",
                            "Nicarágua" : "Nicaragua",
                            "Níger" : "Niger",
                            "Nigéria" : "Nigeria",
                            "Coreia do Norte" : "North Korea",
                            "Noruega" : "Norway",
                            "Omã" : "Oman",
                            "Paquistão" : "Pakistan",
                            "Panamá" : "Panama",
                            "Papua Nova Guiné" : "Papua New Guinea",
                            "Paraguai" : "Paraguay",
                            "Peru" : "Peru",
                            "Filipinas" : "Philippines",
                            "Polônia" : "Poland",
                            "Portugal" : "Portugal",
                            "Porto Rico" : "Puerto Rico",
                            "Catar" : "Qatar",
                            "Romênia" : "Romania",
                            "Rússia" : "Russia",
                            "Ruanda" : "Rwanda",
                            "São Cristóvão e Névis" : "Saint Kitts and Nevis",
                            "Santa Lúcia" : "Saint Lucia",
                            "São Vicente e Granadinas" : "Saint Vincent and the Grenadines",
                            "San Marino" : "San Marino",
                            "São Tomé e Príncipe" : "Sao Tome and Principe",
                            "Arábia Saudita" : "Saudi Arabia",
                            "Escócia" : "Scotland",
                            "Senegal" : "Senegal",
                            "Sérvia" : "Serbia",
                            "Seychelles" : "Seychelles",
                            "Serra Leoa" : "Sierra Leone",
                            "Cingapura" : "Singapore",
                            "Eslováquia" : "Slovakia",
                            "Eslovênia" : "Slovenia",
                            "Ilhas Salomão" : "Solomon Islands",
                            "Somália" : "Somalia",
                            "África do Sul" : "South Africa",
                            "Sudão do Sul" : "South Sudan",
                            "Coréia do Sul" : "South Korea",
                            "Espanha" : "Spain",
                            "Sri Lanka" : "Sri Lanka",
                            "Sudão" : "Sudan",
                            "Suriname" : "Suriname",
                            "Suazilândia" : "Swaziland",
                            "Suécia" : "Sweden",
                            "Suíça" : "Switzerland",
                            "Síria" : "Syria",
                            "Taiwan" : "Taiwan",
                            "Tajiquistão" : "Tajikistan",
                            "Tanzânia" : "Tanzania",
                            "Tailândia" : "Thailand",
                            "Timor-Leste" : "Timor-Leste",
                            "Togo" : "Togo",
                            "Trindade e Tobago" : "Trinidad and Tobago",
                            "Tunísia" : "Tunisia",
                            "Turquia" : "Turkey",
                            "Turcomenistão" : "Turkmenistan",
                            "Tuvalu" : "Tuvalu",
                            "Uganda" : "Uganda",
                            "Ucrânia" : "Ukraine",
                            "Emirados Árabes Unidos" : "United Arab Emirates",
                            "Reino Unido" : "United Kingdom",
                            "RU" : "UK",
                            "Estados Unidos da América" : "united states",
                            "EUA" : "USA",
                            "Uruguai" : "Uruguay",
                            "Uzbequistão" : "Uzbekistan",
                            "Vanuatu" : "Vanuatu",
                            "Vaticano" : "Vatican",
                            "Venezuela" : "Venezuela",
                            "Vietnã" : "Vietnam",
                            "Samoa Ocidental" : "Western Samoa",
                            "Saara Ocidental" : "Western Sahara",
                            "Territórios Palestinos" : "West Bank and Gaza",
                            "Iémen" : "Yemen",
                            "Jugoslávia" : "Yugoslavia ",
                            "Zaire" : "Zaire",
                            "Zâmbia" : "Zambia",
                            "Zimbábue" : "Zimbabwe"]
    
    func countryBRtoUS(countryNameBR: String) -> String {
        let worldStr = "Mundo"
        
        if countryDictionary[countryNameBR] != nil {
            let countryUS = countryDictionary[countryNameBR] ?? worldStr
            return countryUS
        } else {
            print("Error while translation country")
            return worldStr
        }
    }
    
    func countryToSlugAPI(countryNameUS: String) -> String {
        var countrySlugUS: String = ""
        if countryNameUS.contains(" ") {
            countrySlugUS = countryNameUS.replacingOccurrences(of: " ", with: "-")
        } else {
            countrySlugUS = countryNameUS
        }
        
        countrySlugUS = countrySlugUS.lowercased()
        return countrySlugUS
    }
}

