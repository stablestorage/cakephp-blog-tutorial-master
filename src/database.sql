# noinspection SqlNoDataSourceInspectionForFile
        SET FOREIGN_KEY_CHECKS=0;
        DROP TABLE IF EXISTS `lobbies_users`, `lobbies`, `chat_messages`, `users`, `roles`, `countries`, `continents`, `ranks`;
        SET FOREIGN_KEY_CHECKS=1;

        /**
        * Country names, continent names and ISO-3166 codes.
        *
        * @updated  2016-09-29
        * @link     http://www.geekality.net/?p=1182
        * @link     https://bitbucket.org/svish/iso-3166-country-codes
        *
        */
        CREATE TABLE IF NOT EXISTS `continents` (
        `code` CHAR(2) NOT NULL COMMENT 'Continent code',
        `name` VARCHAR(255),
        PRIMARY KEY (`code`)
        ) ENGINE=InnoDB;

        INSERT INTO `continents` VALUES
        ('AF', 'Africa'),
        ('AS', 'Asia'),
        ('EU', 'Europe'),
        ('NA', 'North America'),
        ('SA', 'South America'),
        ('OC', 'Oceania'),
        ('AN', 'Antarctica');


        CREATE TABLE IF NOT EXISTS `countries` (
        `code` CHAR(2) NOT NULL COMMENT 'Two-letter country code (ISO 3166-1 alpha-2)',
        `name` VARCHAR(255) NOT NULL COMMENT 'English country name',
        `full_name` VARCHAR(255) NOT NULL COMMENT 'Full English country name',
        `iso3` CHAR(3) NOT NULL COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
        `number` SMALLINT(3) ZEROFILL NOT NULL COMMENT 'Three-digit country number (ISO 3166-1 numeric)',
        `continent_code` CHAR(2) NOT NULL,
        PRIMARY KEY (`code`),
        KEY `continent_code` (`continent_code`),
        CONSTRAINT `fk_countries_continents` FOREIGN KEY (`continent_code`) REFERENCES `continents` (`code`)
        ) ENGINE=InnoDB;

        INSERT INTO `countries` (`code`, `continent_code`, `name`, `iso3`, `number`, `full_name`) VALUES
        ('AF', 'AS', "Afghanistan", 'AFG', '004', "Islamic Republic of Afghanistan"),
        ('AX', 'EU', "Åland Islands", 'ALA', '248', "Åland Islands"),
        ('AL', 'EU', "Albania", 'ALB', '008', "Republic of Albania"),
        ('DZ', 'AF', "Algeria", 'DZA', '012', "People's Democratic Republic of Algeria"),
        ('AS', 'OC', "American Samoa", 'ASM', '016', "American Samoa"),
        ('AD', 'EU', "Andorra", 'AND', '020', "Principality of Andorra"),
        ('AO', 'AF', "Angola", 'AGO', '024', "Republic of Angola"),
        ('AI', 'NA', "Anguilla", 'AIA', '660', "Anguilla"),
        ('AQ', 'AN', "Antarctica", 'ATA', '010', "Antarctica (the territory South of 60 deg S)"),
        ('AG', 'NA', "Antigua and Barbuda", 'ATG', '028', "Antigua and Barbuda"),
        ('AR', 'SA', "Argentina", 'ARG', '032', "Argentine Republic"),
        ('AM', 'AS', "Armenia", 'ARM', '051', "Republic of Armenia"),
        ('AW', 'NA', "Aruba", 'ABW', '533', "Aruba"),
        ('AU', 'OC', "Australia", 'AUS', '036', "Commonwealth of Australia"),
        ('AT', 'EU', "Austria", 'AUT', '040', "Republic of Austria"),
        ('AZ', 'AS', "Azerbaijan", 'AZE', '031', "Republic of Azerbaijan"),
        ('BS', 'NA', "Bahamas", 'BHS', '044', "Commonwealth of the Bahamas"),
        ('BH', 'AS', "Bahrain", 'BHR', '048', "Kingdom of Bahrain"),
        ('BD', 'AS', "Bangladesh", 'BGD', '050', "People's Republic of Bangladesh"),
        ('BB', 'NA', "Barbados", 'BRB', '052', "Barbados"),
        ('BY', 'EU', "Belarus", 'BLR', '112', "Republic of Belarus"),
        ('BE', 'EU', "Belgium", 'BEL', '056', "Kingdom of Belgium"),
        ('BZ', 'NA', "Belize", 'BLZ', '084', "Belize"),
        ('BJ', 'AF', "Benin", 'BEN', '204', "Republic of Benin"),
        ('BM', 'NA', "Bermuda", 'BMU', '060', "Bermuda"),
        ('BT', 'AS', "Bhutan", 'BTN', '064', "Kingdom of Bhutan"),
        ('BO', 'SA', "Bolivia", 'BOL', '068', "Plurinational State of Bolivia"),
        ('BQ', 'NA', "Bonaire, Sint Eustatius and Saba", 'BES', '535', "Bonaire, Sint Eustatius and Saba"),
        ('BA', 'EU', "Bosnia and Herzegovina", 'BIH', '070', "Bosnia and Herzegovina"),
        ('BW', 'AF', "Botswana", 'BWA', '072', "Republic of Botswana"),
        ('BV', 'AN', "Bouvet Island (Bouvetøya)", 'BVT', '074', "Bouvet Island (Bouvetøya)"),
        ('BR', 'SA', "Brazil", 'BRA', '076', "Federative Republic of Brazil"),
        ('IO', 'AS', "British Indian Ocean Territory (Chagos Archipelago)", 'IOT', '086', "British Indian Ocean Territory (Chagos Archipelago)"),
        ('VG', 'NA', "British Virgin Islands", 'VGB', '092', "British Virgin Islands"),
        ('BN', 'AS', "Brunei Darussalam", 'BRN', '096', "Brunei Darussalam"),
        ('BG', 'EU', "Bulgaria", 'BGR', '100', "Republic of Bulgaria"),
        ('BF', 'AF', "Burkina Faso", 'BFA', '854', "Burkina Faso"),
        ('BI', 'AF', "Burundi", 'BDI', '108', "Republic of Burundi"),
        ('KH', 'AS', "Cambodia", 'KHM', '116', "Kingdom of Cambodia"),
        ('CM', 'AF', "Cameroon", 'CMR', '120', "Republic of Cameroon"),
        ('CA', 'NA', "Canada", 'CAN', '124', "Canada"),
        ('CV', 'AF', "Cabo Verde", 'CPV', '132', "Republic of Cabo Verde"),
        ('KY', 'NA', "Cayman Islands", 'CYM', '136', "Cayman Islands"),
        ('CF', 'AF', "Central African Republic", 'CAF', '140', "Central African Republic"),
        ('TD', 'AF', "Chad", 'TCD', '148', "Republic of Chad"),
        ('CL', 'SA', "Chile", 'CHL', '152', "Republic of Chile"),
        ('CN', 'AS', "China", 'CHN', '156', "People's Republic of China"),
        ('CX', 'AS', "Christmas Island", 'CXR', '162', "Christmas Island"),
        ('CC', 'AS', "Cocos (Keeling) Islands", 'CCK', '166', "Cocos (Keeling) Islands"),
        ('CO', 'SA', "Colombia", 'COL', '170', "Republic of Colombia"),
        ('KM', 'AF', "Comoros", 'COM', '174', "Union of the Comoros"),
        ('CD', 'AF', "Congo", 'COD', '180', "Democratic Republic of the Congo"),
        ('CG', 'AF', "Congo", 'COG', '178', "Republic of the Congo"),
        ('CK', 'OC', "Cook Islands", 'COK', '184', "Cook Islands"),
        ('CR', 'NA', "Costa Rica", 'CRI', '188', "Republic of Costa Rica"),
        ('CI', 'AF', "Cote d'Ivoire", 'CIV', '384', "Republic of Cote d'Ivoire"),
        ('HR', 'EU', "Croatia", 'HRV', '191', "Republic of Croatia"),
        ('CU', 'NA', "Cuba", 'CUB', '192', "Republic of Cuba"),
        ('CW', 'NA', "Curaçao", 'CUW', '531', "Curaçao"),
        ('CY', 'AS', "Cyprus", 'CYP', '196', "Republic of Cyprus"),
        ('CZ', 'EU', "Czechia", 'CZE', '203', "Czech Republic"),
        ('DK', 'EU', "Denmark", 'DNK', '208', "Kingdom of Denmark"),
        ('DJ', 'AF', "Djibouti", 'DJI', '262', "Republic of Djibouti"),
        ('DM', 'NA', "Dominica", 'DMA', '212', "Commonwealth of Dominica"),
        ('DO', 'NA', "Dominican Republic", 'DOM', '214', "Dominican Republic"),
        ('EC', 'SA', "Ecuador", 'ECU', '218', "Republic of Ecuador"),
        ('EG', 'AF', "Egypt", 'EGY', '818', "Arab Republic of Egypt"),
        ('SV', 'NA', "El Salvador", 'SLV', '222', "Republic of El Salvador"),
        ('GQ', 'AF', "Equatorial Guinea", 'GNQ', '226', "Republic of Equatorial Guinea"),
        ('ER', 'AF', "Eritrea", 'ERI', '232', "State of Eritrea"),
        ('EE', 'EU', "Estonia", 'EST', '233', "Republic of Estonia"),
        ('ET', 'AF', "Ethiopia", 'ETH', '231', "Federal Democratic Republic of Ethiopia"),
        ('FO', 'EU', "Faroe Islands", 'FRO', '234', "Faroe Islands"),
        ('FK', 'SA', "Falkland Islands (Malvinas)", 'FLK', '238', "Falkland Islands (Malvinas)"),
        ('FJ', 'OC', "Fiji", 'FJI', '242', "Republic of Fiji"),
        ('FI', 'EU', "Finland", 'FIN', '246', "Republic of Finland"),
        ('FR', 'EU', "France", 'FRA', '250', "French Republic"),
        ('GF', 'SA', "French Guiana", 'GUF', '254', "French Guiana"),
        ('PF', 'OC', "French Polynesia", 'PYF', '258', "French Polynesia"),
        ('TF', 'AN', "French Southern Territories", 'ATF', '260', "French Southern Territories"),
        ('GA', 'AF', "Gabon", 'GAB', '266', "Gabonese Republic"),
        ('GM', 'AF', "Gambia", 'GMB', '270', "Islamic Republic of the Gambia"),
        ('GE', 'AS', "Georgia", 'GEO', '268', "Georgia"),
        ('DE', 'EU', "Germany", 'DEU', '276', "Federal Republic of Germany"),
        ('GH', 'AF', "Ghana", 'GHA', '288', "Republic of Ghana"),
        ('GI', 'EU', "Gibraltar", 'GIB', '292', "Gibraltar"),
        ('GR', 'EU', "Greece", 'GRC', '300', "Hellenic Republic of Greece"),
        ('GL', 'NA', "Greenland", 'GRL', '304', "Greenland"),
        ('GD', 'NA', "Grenada", 'GRD', '308', "Grenada"),
        ('GP', 'NA', "Guadeloupe", 'GLP', '312', "Guadeloupe"),
        ('GU', 'OC', "Guam", 'GUM', '316', "Guam"),
        ('GT', 'NA', "Guatemala", 'GTM', '320', "Republic of Guatemala"),
        ('GG', 'EU', "Guernsey", 'GGY', '831', "Bailiwick of Guernsey"),
        ('GN', 'AF', "Guinea", 'GIN', '324', "Republic of Guinea"),
        ('GW', 'AF', "Guinea-Bissau", 'GNB', '624', "Republic of Guinea-Bissau"),
        ('GY', 'SA', "Guyana", 'GUY', '328', "Co-operative Republic of Guyana"),
        ('HT', 'NA', "Haiti", 'HTI', '332', "Republic of Haiti"),
        ('HM', 'AN', "Heard Island and McDonald Islands", 'HMD', '334', "Heard Island and McDonald Islands"),
        ('VA', 'EU', "Holy See (Vatican City State)", 'VAT', '336', "Holy See (Vatican City State)"),
        ('HN', 'NA', "Honduras", 'HND', '340', "Republic of Honduras"),
        ('HK', 'AS', "Hong Kong", 'HKG', '344', "Hong Kong Special Administrative Region of China"),
        ('HU', 'EU', "Hungary", 'HUN', '348', "Hungary"),
        ('IS', 'EU', "Iceland", 'ISL', '352', "Republic of Iceland"),
        ('IN', 'AS', "India", 'IND', '356', "Republic of India"),
        ('ID', 'AS', "Indonesia", 'IDN', '360', "Republic of Indonesia"),
        ('IR', 'AS', "Iran", 'IRN', '364', "Islamic Republic of Iran"),
        ('IQ', 'AS', "Iraq", 'IRQ', '368', "Republic of Iraq"),
        ('IE', 'EU', "Ireland", 'IRL', '372', "Ireland"),
        ('IM', 'EU', "Isle of Man", 'IMN', '833', "Isle of Man"),
        ('IL', 'AS', "Israel", 'ISR', '376', "State of Israel"),
        ('IT', 'EU', "Italy", 'ITA', '380', "Italian Republic"),
        ('JM', 'NA', "Jamaica", 'JAM', '388', "Jamaica"),
        ('JP', 'AS', "Japan", 'JPN', '392', "Japan"),
        ('JE', 'EU', "Jersey", 'JEY', '832', "Bailiwick of Jersey"),
        ('JO', 'AS', "Jordan", 'JOR', '400', "Hashemite Kingdom of Jordan"),
        ('KZ', 'AS', "Kazakhstan", 'KAZ', '398', "Republic of Kazakhstan"),
        ('KE', 'AF', "Kenya", 'KEN', '404', "Republic of Kenya"),
        ('KI', 'OC', "Kiribati", 'KIR', '296', "Republic of Kiribati"),
        ('KP', 'AS', "Korea", 'PRK', '408', "Democratic People's Republic of Korea"),
        ('KR', 'AS', "Korea", 'KOR', '410', "Republic of Korea"),
        ('KW', 'AS', "Kuwait", 'KWT', '414', "State of Kuwait"),
        ('KG', 'AS', "Kyrgyz Republic", 'KGZ', '417', "Kyrgyz Republic"),
        ('LA', 'AS', "Lao People's Democratic Republic", 'LAO', '418', "Lao People's Democratic Republic"),
        ('LV', 'EU', "Latvia", 'LVA', '428', "Republic of Latvia"),
        ('LB', 'AS', "Lebanon", 'LBN', '422', "Lebanese Republic"),
        ('LS', 'AF', "Lesotho", 'LSO', '426', "Kingdom of Lesotho"),
        ('LR', 'AF', "Liberia", 'LBR', '430', "Republic of Liberia"),
        ('LY', 'AF', "Libya", 'LBY', '434', "Libya"),
        ('LI', 'EU', "Liechtenstein", 'LIE', '438', "Principality of Liechtenstein"),
        ('LT', 'EU', "Lithuania", 'LTU', '440', "Republic of Lithuania"),
        ('LU', 'EU', "Luxembourg", 'LUX', '442', "Grand Duchy of Luxembourg"),
        ('MO', 'AS', "Macao", 'MAC', '446', "Macao Special Administrative Region of China"),
        ('MK', 'EU', "Macedonia", 'MKD', '807', "Republic of Macedonia"),
        ('MG', 'AF', "Madagascar", 'MDG', '450', "Republic of Madagascar"),
        ('MW', 'AF', "Malawi", 'MWI', '454', "Republic of Malawi"),
        ('MY', 'AS', "Malaysia", 'MYS', '458', "Malaysia"),
        ('MV', 'AS', "Maldives", 'MDV', '462', "Republic of Maldives"),
        ('ML', 'AF', "Mali", 'MLI', '466', "Republic of Mali"),
        ('MT', 'EU', "Malta", 'MLT', '470', "Republic of Malta"),
        ('MH', 'OC', "Marshall Islands", 'MHL', '584', "Republic of the Marshall Islands"),
        ('MQ', 'NA', "Martinique", 'MTQ', '474', "Martinique"),
        ('MR', 'AF', "Mauritania", 'MRT', '478', "Islamic Republic of Mauritania"),
        ('MU', 'AF', "Mauritius", 'MUS', '480', "Republic of Mauritius"),
        ('YT', 'AF', "Mayotte", 'MYT', '175', "Mayotte"),
        ('MX', 'NA', "Mexico", 'MEX', '484', "United Mexican States"),
        ('FM', 'OC', "Micronesia", 'FSM', '583', "Federated States of Micronesia"),
        ('MD', 'EU', "Moldova", 'MDA', '498', "Republic of Moldova"),
        ('MC', 'EU', "Monaco", 'MCO', '492', "Principality of Monaco"),
        ('MN', 'AS', "Mongolia", 'MNG', '496', "Mongolia"),
        ('ME', 'EU', "Montenegro", 'MNE', '499', "Montenegro"),
        ('MS', 'NA', "Montserrat", 'MSR', '500', "Montserrat"),
        ('MA', 'AF', "Morocco", 'MAR', '504', "Kingdom of Morocco"),
        ('MZ', 'AF', "Mozambique", 'MOZ', '508', "Republic of Mozambique"),
        ('MM', 'AS', "Myanmar", 'MMR', '104', "Republic of the Union of Myanmar"),
        ('NA', 'AF', "Namibia", 'NAM', '516', "Republic of Namibia"),
        ('NR', 'OC', "Nauru", 'NRU', '520', "Republic of Nauru"),
        ('NP', 'AS', "Nepal", 'NPL', '524', "Federal Democratic Republic of Nepal"),
        ('NL', 'EU', "Netherlands", 'NLD', '528', "Kingdom of the Netherlands"),
        ('NC', 'OC', "New Caledonia", 'NCL', '540', "New Caledonia"),
        ('NZ', 'OC', "New Zealand", 'NZL', '554', "New Zealand"),
        ('NI', 'NA', "Nicaragua", 'NIC', '558', "Republic of Nicaragua"),
        ('NE', 'AF', "Niger", 'NER', '562', "Republic of Niger"),
        ('NG', 'AF', "Nigeria", 'NGA', '566', "Federal Republic of Nigeria"),
        ('NU', 'OC', "Niue", 'NIU', '570', "Niue"),
        ('NF', 'OC', "Norfolk Island", 'NFK', '574', "Norfolk Island"),
        ('MP', 'OC', "Northern Mariana Islands", 'MNP', '580', "Commonwealth of the Northern Mariana Islands"),
        ('NO', 'EU', "Norway", 'NOR', '578', "Kingdom of Norway"),
        ('OM', 'AS', "Oman", 'OMN', '512', "Sultanate of Oman"),
        ('PK', 'AS', "Pakistan", 'PAK', '586', "Islamic Republic of Pakistan"),
        ('PW', 'OC', "Palau", 'PLW', '585', "Republic of Palau"),
        ('PS', 'AS', "Palestine", 'PSE', '275', "State of Palestine"),
        ('PA', 'NA', "Panama", 'PAN', '591', "Republic of Panama"),
        ('PG', 'OC', "Papua New Guinea", 'PNG', '598', "Independent State of Papua New Guinea"),
        ('PY', 'SA', "Paraguay", 'PRY', '600', "Republic of Paraguay"),
        ('PE', 'SA', "Peru", 'PER', '604', "Republic of Peru"),
        ('PH', 'AS', "Philippines", 'PHL', '608', "Republic of the Philippines"),
        ('PN', 'OC', "Pitcairn Islands", 'PCN', '612', "Pitcairn Islands"),
        ('PL', 'EU', "Poland", 'POL', '616', "Republic of Poland"),
        ('PT', 'EU', "Portugal", 'PRT', '620', "Portuguese Republic"),
        ('PR', 'NA', "Puerto Rico", 'PRI', '630', "Commonwealth of Puerto Rico"),
        ('QA', 'AS', "Qatar", 'QAT', '634', "State of Qatar"),
        ('RE', 'AF', "Réunion", 'REU', '638', "Réunion"),
        ('RO', 'EU', "Romania", 'ROU', '642', "Romania"),
        ('RU', 'EU', "Russian Federation", 'RUS', '643', "Russian Federation"),
        ('RW', 'AF', "Rwanda", 'RWA', '646', "Republic of Rwanda"),
        ('BL', 'NA', "Saint Barthélemy", 'BLM', '652', "Saint Barthélemy"),
        ('SH', 'AF', "Saint Helena, Ascension and Tristan da Cunha", 'SHN', '654', "Saint Helena, Ascension and Tristan da Cunha"),
        ('KN', 'NA', "Saint Kitts and Nevis", 'KNA', '659', "Federation of Saint Kitts and Nevis"),
        ('LC', 'NA', "Saint Lucia", 'LCA', '662', "Saint Lucia"),
        ('MF', 'NA', "Saint Martin", 'MAF', '663', "Saint Martin (French part)"),
        ('PM', 'NA', "Saint Pierre and Miquelon", 'SPM', '666', "Saint Pierre and Miquelon"),
        ('VC', 'NA', "Saint Vincent and the Grenadines", 'VCT', '670', "Saint Vincent and the Grenadines"),
        ('WS', 'OC', "Samoa", 'WSM', '882', "Independent State of Samoa"),
        ('SM', 'EU', "San Marino", 'SMR', '674', "Republic of San Marino"),
        ('ST', 'AF', "Sao Tome and Principe", 'STP', '678', "Democratic Republic of Sao Tome and Principe"),
        ('SA', 'AS', "Saudi Arabia", 'SAU', '682', "Kingdom of Saudi Arabia"),
        ('SN', 'AF', "Senegal", 'SEN', '686', "Republic of Senegal"),
        ('RS', 'EU', "Serbia", 'SRB', '688', "Republic of Serbia"),
        ('SC', 'AF', "Seychelles", 'SYC', '690', "Republic of Seychelles"),
        ('SL', 'AF', "Sierra Leone", 'SLE', '694', "Republic of Sierra Leone"),
        ('SG', 'AS', "Singapore", 'SGP', '702', "Republic of Singapore"),
        ('SX', 'NA', "Sint Maarten (Dutch part)", 'SXM', '534', "Sint Maarten (Dutch part)"),
        ('SK', 'EU', "Slovakia (Slovak Republic)", 'SVK', '703', "Slovakia (Slovak Republic)"),
        ('SI', 'EU', "Slovenia", 'SVN', '705', "Republic of Slovenia"),
        ('SB', 'OC', "Solomon Islands", 'SLB', '090', "Solomon Islands"),
        ('SO', 'AF', "Somalia", 'SOM', '706', "Federal Republic of Somalia"),
        ('ZA', 'AF', "South Africa", 'ZAF', '710', "Republic of South Africa"),
        ('GS', 'AN', "South Georgia and the South Sandwich Islands", 'SGS', '239', "South Georgia and the South Sandwich Islands"),
        ('SS', 'AF', "South Sudan", 'SSD', '728', "Republic of South Sudan"),
        ('ES', 'EU', "Spain", 'ESP', '724', "Kingdom of Spain"),
        ('LK', 'AS', "Sri Lanka", 'LKA', '144', "Democratic Socialist Republic of Sri Lanka"),
        ('SD', 'AF', "Sudan", 'SDN', '729', "Republic of Sudan"),
        ('SR', 'SA', "Suriname", 'SUR', '740', "Republic of Suriname"),
        ('SJ', 'EU', "Svalbard & Jan Mayen Islands", 'SJM', '744', "Svalbard & Jan Mayen Islands"),
        ('SZ', 'AF', "Swaziland", 'SWZ', '748', "Kingdom of Swaziland"),
        ('SE', 'EU', "Sweden", 'SWE', '752', "Kingdom of Sweden"),
        ('CH', 'EU', "Switzerland", 'CHE', '756', "Swiss Confederation"),
        ('SY', 'AS', "Syrian Arab Republic", 'SYR', '760', "Syrian Arab Republic"),
        ('TW', 'AS', "Taiwan", 'TWN', '158', "Taiwan, Province of China"),
        ('TJ', 'AS', "Tajikistan", 'TJK', '762', "Republic of Tajikistan"),
        ('TZ', 'AF', "Tanzania", 'TZA', '834', "United Republic of Tanzania"),
        ('TH', 'AS', "Thailand", 'THA', '764', "Kingdom of Thailand"),
        ('TL', 'AS', "Timor-Leste", 'TLS', '626', "Democratic Republic of Timor-Leste"),
        ('TG', 'AF', "Togo", 'TGO', '768', "Togolese Republic"),
        ('TK', 'OC', "Tokelau", 'TKL', '772', "Tokelau"),
        ('TO', 'OC', "Tonga", 'TON', '776', "Kingdom of Tonga"),
        ('TT', 'NA', "Trinidad and Tobago", 'TTO', '780', "Republic of Trinidad and Tobago"),
        ('TN', 'AF', "Tunisia", 'TUN', '788', "Tunisian Republic"),
        ('TR', 'AS', "Turkey", 'TUR', '792', "Republic of Turkey"),
        ('TM', 'AS', "Turkmenistan", 'TKM', '795', "Turkmenistan"),
        ('TC', 'NA', "Turks and Caicos Islands", 'TCA', '796', "Turks and Caicos Islands"),
        ('TV', 'OC', "Tuvalu", 'TUV', '798', "Tuvalu"),
        ('UG', 'AF', "Uganda", 'UGA', '800', "Republic of Uganda"),
        ('UA', 'EU', "Ukraine", 'UKR', '804', "Ukraine"),
        ('AE', 'AS', "United Arab Emirates", 'ARE', '784', "United Arab Emirates"),
        ('GB', 'EU', "United Kingdom of Great Britain & Northern Ireland", 'GBR', '826', "United Kingdom of Great Britain & Northern Ireland"),
        ('US', 'NA', "United States of America", 'USA', '840', "United States of America"),
        ('UM', 'OC', "United States Minor Outlying Islands", 'UMI', '581', "United States Minor Outlying Islands"),
        ('VI', 'NA', "United States Virgin Islands", 'VIR', '850', "United States Virgin Islands"),
        ('UY', 'SA', "Uruguay", 'URY', '858', "Eastern Republic of Uruguay"),
        ('UZ', 'AS', "Uzbekistan", 'UZB', '860', "Republic of Uzbekistan"),
        ('VU', 'OC', "Vanuatu", 'VUT', '548', "Republic of Vanuatu"),
        ('VE', 'SA', "Venezuela", 'VEN', '862', "Bolivarian Republic of Venezuela"),
        ('VN', 'AS', "Vietnam", 'VNM', '704', "Socialist Republic of Vietnam"),
        ('WF', 'OC', "Wallis and Futuna", 'WLF', '876', "Wallis and Futuna"),
        ('EH', 'AF', "Western Sahara", 'ESH', '732', "Western Sahara"),
        ('YE', 'AS', "Yemen", 'YEM', '887', "Yemen"),
        ('ZM', 'AF', "Zambia", 'ZMB', '894', "Republic of Zambia"),
        ('ZW', 'AF', "Zimbabwe", 'ZWE', '716', "Republic of Zimbabwe");

        CREATE TABLE IF NOT EXISTS `roles` (
        role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(30),
        description VARCHAR(50)
        );

        CREATE TABLE IF NOT EXISTS `ranks` (
        rank_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        abbr VARCHAR(30),
        img_path VARCHAR(255)
        );

        CREATE TABLE IF NOT EXISTS `users` (
        user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        steam_id VARCHAR(255) UNIQUE,
        country_code CHAR(2),
        age_range VARCHAR(10),
        avatar VARCHAR(255),
        avatarmedium VARCHAR(255),
        avatarfull VARCHAR(255),
        personaname VARCHAR(255),
        profileurl VARCHAR(255),
        playtime INT,
        role_id INT UNSIGNED DEFAULT 1,
        rank_id INT UNSIGNED,
        upvotes INT DEFAULT 0,
        downvotes INT DEFAULT 0,
        created DATETIME DEFAULT NULL,
        modified DATETIME DEFAULT NULL,
        microphone BOOL DEFAULT false,
        teamspeak BOOL DEFAULT false,
        /* DELETE USERNAME AND PW BEFORE DEPLOYING */
        username VARCHAR(255),
        password VARCHAR(255),
        FOREIGN KEY (country_code) REFERENCES countries(code) ON DELETE CASCADE,
        FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE,
        FOREIGN KEY (rank_id) REFERENCES ranks(rank_id) ON DELETE CASCADE
        );
INSERT INTO `ranks` (rank_id, abbr, img_path) VALUES
        (1,'S1', 'ranks/1.png'),
        (2,'S2', 'ranks/2.png'),
        (3,'S3', 'ranks/3.png'),
        (4,'S4', 'ranks/4.png'),
        (5,'SE', 'ranks/5.png'),
        (6,'SEM', 'ranks/6.png'),
        (7,'GN1', 'ranks/7.png'),
        (8,'GN2', 'ranks/8.png'),
        (9,'GN3', 'ranks/9.png'),
        (10,'GNM', 'ranks/10.png'),
        (11,'MG1', 'ranks/11.png'),
        (12,'MG2', 'ranks/12.png'),
        (13,'MGE', 'ranks/13.png'),
        (14,'DMG', 'ranks/14.png'),
        (15,'LE', 'ranks/15.png'),
        (16,'LEM', 'ranks/16.png'),
        (17,'SMFC', 'ranks/17.png'),
        (18,'GE', 'ranks/18.png');

        CREATE TABLE IF NOT EXISTS `chat_messages` (
        message_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        sent_by INT UNSIGNED NOT NULL,
        message VARCHAR(50) NOT NULL,
        created DATETIME DEFAULT NULL,
        FOREIGN KEY (sent_by) REFERENCES users(user_id) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS `lobbies` (
        lobby_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        owned_by INT UNSIGNED NOT NULL,
        free_slots INT DEFAULT 4,
        url VARCHAR(255) NOT NULL UNIQUE,
        created DATETIME DEFAULT NULL,
        modified DATETIME DEFAULT NULL,
        microphone_req BOOL DEFAULT false,
        prime_req BOOL DEFAULT false,
        min_age INT,
        teamspeak_req BOOL DEFAULT false,
        teamspeak_ip VARCHAR(100) DEFAULT NULL,
        rank_from VARCHAR(20),
        rank_to VARCHAR(20),
        min_playtime INT,
        region CHAR(2),
        language CHAR(6),
        min_upvotes INT DEFAULT NULL,
        max_downvotes INT DEFAULT NULL,
        users_count INT,
        FOREIGN KEY (owned_by) REFERENCES users(user_id) ON DELETE CASCADE,
        FOREIGN KEY (region) REFERENCES continents(code) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS `lobbies_users` (
        lobbies_users_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        lobby_id INT UNSIGNED,
        user_id INT UNSIGNED,
        FOREIGN KEY (lobby_id) REFERENCES lobbies(lobby_id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
        );

        /* INIT SCRIPT */
        /* INSERT REQUIRED DATA HERE TO SETUP THE APPLICATION */

        /* TEST DATA */
        INSERT INTO `roles` (name) VALUES ('default');
        INSERT INTO `roles` (name) VALUES ('admin');
        INSERT INTO `roles` (name) VALUES ('mod');
        /* 0000 */
        INSERT INTO `users` (
        `user_id`, `steam_id`, `country_code`, `age_range`, avatar, avatarmedium, avatarfull, personaname, profileurl, playtime, `role_id`, `rank_id`, `upvotes`, `downvotes`, `microphone`, `teamspeak`, `username`, `password`) VALUES
        (1, '76561198126151407', 'DE', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor', 'http://steamcommunity.com/id/stablestorage/', 1402, 1, 18, 100, 10, 1, 1, 'user1', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei'),
        (2, '76561198126151406', 'IN', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor1', 'http://steamcommunity.com/id/stablestorage/', 900, 1, 17, 10, 100, 0, 0, 'user2', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei'),
        (3, '76561198126151405', 'CH', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor2', 'http://steamcommunity.com/id/stablestorage/', 1402, 1, 5, 100, 10, 1, 1, 'user3', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei'),
        (4, '76561198126151404', 'GB', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor3', 'http://steamcommunity.com/id/stablestorage/', 900, 1, 10, 10, 100, 0, 0, 'user4', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei'),
        (5, '76561198126151403', 'US', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor4', 'http://steamcommunity.com/id/stablestorage/', 1402, 1, 11, 100, 10, 1, 1, 'user5', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei'),
        (6, '76561198126151402', 'DE', '20-90', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_medium.jpg', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f0/f045e851a26a02eb4069842bec5f491d6779e194_full.jpg', 'Semaphor5', 'http://steamcommunity.com/id/stablestorage/', 900, 1, 15, 10, 10, 0, 0, 'user6', '$2y$10$rSAzv08D1E9yhu8JV4bCIOf2rV6wwt5BP0ZKWiCpw.uKRRVGZ56ei');

        INSERT INTO `lobbies` (`lobby_id`, `owned_by`, `free_slots`, `url`, `created`, `modified`, `microphone_req`, `min_age`, `teamspeak_req`, `rank_to`, `rank_from`, `min_playtime`, region, `language`, `min_upvotes`, `max_downvotes`) VALUES
        (1, 1, 4, 'test', NULL, NULL, 1, 12, 0, '18', '16', 1000, 'EU', 'de', 0, 0),
        (2, 2, 4, 'test2', NULL, NULL, 0, 18, 0, '18', '10', 500, 'EU', 'de', 0, 0),
        (3, 3, 4, 'test3', NULL, NULL, 1, 12, 1, '17', '1', 0, 'NA', 'de', 0, 0),
        (4, 4, 4, 'test4', NULL, NULL, 0, 12, 0, '18', '16', 1000, 'EU', 'de', 0, 0),
        (5, 5, 4, 'test5', NULL, NULL, 1, 12, 0, '18', '16', 1100, 'EU', 'en', 0, 0),
        (6, 1, 4, 'test6', NULL, NULL, 0, 12, 0, '18', '16', 1500, 'EU', 'de', 0, 0),
        (7, 1, 4, 'test7', NULL, NULL, 1, 12, 0, '18', '16', 1200, 'EU', 'de', 0, 0),
        (8, 2, 4, 'test8', NULL, NULL, 0, 100, 0, '18', '16', 1000, 'EU', 'de', 0, 0);


        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (1,1);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (1,2);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (2,1);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (2,2);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (2,3);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (2,4);
        INSERT INTO `lobbies_users` (lobby_id, user_id) VALUES (2,5);

        INSERT INTO `chat_messages` (sent_by, message) VALUES (1, 'Hi');
        INSERT INTO `chat_messages` (sent_by, message) VALUES (2, 'Hi there.');

