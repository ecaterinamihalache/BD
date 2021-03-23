--Inserare in tabela Cabinete
INSERT INTO Cabinete VALUES(NULL, 'MEDLIFE', 'BOTOSANI', 0231567877);
INSERT INTO Cabinete VALUES(NULL, 'CABINETMEDICAL', 'IASI', 0233455876);
INSERT INTO Cabinete VALUES(NULL, 'ECOMED', 'BRASOV', 0734567685);
INSERT INTO Cabinete VALUES(NULL, 'DORIMED', 'SUCEAVA', 0324657487);
INSERT INTO Cabinete VALUES(NULL, 'ERDOMED', 'CLUJ', 0231588567);
INSERT INTO Cabinete VALUES(NULL, 'ORIMED', 'BOTOSANI', 0231567802);
INSERT INTO Cabinete VALUES(NULL, 'MEDICAL', 'ARAD', 0231455876);
INSERT INTO Cabinete VALUES(NULL, 'ECOMEDICINA', 'CRAIOVA', 0734599685);

--Inserare in tabela Contracte
INSERT INTO Contracte VALUES(NULL, TO_DATE('06.12.2020', 'DD.MM.YYYY'), NULL, 12, (select id_cabinet FROM Cabinete WHERE denumire='MEDLIFE'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('24.07.2016', 'DD.MM.YYYY'), NULL, 30, (select id_cabinet FROM Cabinete WHERE denumire='ECOMED'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('11.11.2019', 'DD.MM.YYYY'), NULL, 18, (select id_cabinet FROM Cabinete WHERE denumire='CABINETMEDICAL'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('13.01.2007', 'DD.MM.YYYY'), NULL, 24, (select id_cabinet FROM Cabinete WHERE denumire='ERDOMED'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('07.05.2003', 'DD.MM.YYYY'), NULL, 60, (select id_cabinet FROM Cabinete WHERE denumire='DORIMED'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('07.05.2003', 'DD.MM.YYYY'), NULL, 36, (select id_cabinet FROM Cabinete WHERE denumire='MEDICAL'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('07.05.2005', 'DD.MM.YYYY'), NULL, 42, (select id_cabinet FROM Cabinete WHERE denumire='MEDICAL'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('03.01.2005', 'DD.MM.YYYY'),TO_DATE('03.07.2005', 'DD.MM.YYYY') , 66, (select id_cabinet FROM Cabinete WHERE denumire='ECOMEDICINA'));
INSERT INTO Contracte VALUES(NULL, TO_DATE('21.01.2012', 'DD.MM.YYYY'),TO_DATE('21.07.2012', 'DD.MM.YYYY') , 48, (select id_cabinet FROM Cabinete WHERE denumire='ORIMED'));

--Inserare in tabela Asistente
INSERT INTO Asistente VALUES(NULL, 'IORDACHE','SIMONA',(SELECT id_contract FROM Contracte WHERE nr_luni=24));
INSERT INTO Asistente VALUES(NULL, 'PIRVU','LARISA',(SELECT id_contract FROM Contracte WHERE nr_luni=18));
INSERT INTO Asistente VALUES(NULL, 'CAUNIC','GABRIELA',(SELECT id_contract FROM Contracte WHERE nr_luni=60));
INSERT INTO Asistente VALUES(NULL, 'ROTARU','ANA',(SELECT id_contract FROM Contracte WHERE nr_luni=30));
INSERT INTO Asistente VALUES(NULL, 'MELINTE','DOINA',(SELECT id_contract FROM Contracte WHERE nr_luni=36));
INSERT INTO Asistente VALUES(NULL, 'PARVULESCU','DORINA',(SELECT id_contract FROM Contracte WHERE nr_luni=66));
INSERT INTO Asistente VALUES(NULL, 'NICHITA','LACRAMIOARA',(SELECT id_contract FROM Contracte WHERE nr_luni=42));
INSERT INTO Asistente VALUES(NULL, 'SANDU','DIANA',(SELECT id_contract FROM Contracte WHERE nr_luni=48));

--Inserare in tabela Medici_lab
INSERT INTO Medici_lab VALUES(NULL, 'PETRESCU', 'IOAN', (select id_contract FROM Contracte WHERE nr_luni=60));
INSERT INTO Medici_lab VALUES(NULL, 'RUSU', 'MARIANA', (select id_contract FROM Contracte WHERE nr_luni=30));
INSERT INTO Medici_lab VALUES(NULL, 'DANILIUC', 'ADRIAN', (select id_contract FROM Contracte WHERE nr_luni=36));
INSERT INTO Medici_lab VALUES(NULL, 'BALAN', 'IONELA', (select id_contract FROM Contracte WHERE nr_luni=24));
INSERT INTO Medici_lab VALUES(NULL, 'DUMITRESCU', 'FLORINA', (select id_contract FROM Contracte WHERE nr_luni=18));
INSERT INTO Medici_lab VALUES(NULL, 'POROSNIUC', 'DANIEL', (select id_contract FROM Contracte WHERE nr_luni=66));
INSERT INTO Medici_lab VALUES(NULL, 'BALAUCA', 'CRISTINA', (select id_contract FROM Contracte WHERE nr_luni=42));
INSERT INTO Medici_lab VALUES(NULL, 'PUIU', 'ANA', (select id_contract FROM Contracte WHERE nr_luni=48));

--Inserare in tabela Analize
INSERT INTO Analize VALUES(NULL, 'Biochimie', TO_DATE('06.12.2020', 'DD.MM.YYYY'), TO_DATE('06.12.2020', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='MEDLIFE'),(SELECT id_medic FROM Medici_lab WHERE nume_m='PETRESCU'),(SELECT id_asistenta FROM Asistente WHERE nume_a='IORDACHE'),110);
INSERT INTO Analize VALUES(NULL, 'Standard',  TO_DATE('23.09.2019', 'DD.MM.YYYY'), TO_DATE('24.09.2019', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='CABINETMEDICAL'),(SELECT id_medic FROM Medici_lab WHERE nume_m='RUSU'),(SELECT id_asistenta FROM Asistente WHERE nume_a='PIRVU'),80);
INSERT INTO Analize VALUES(NULL, 'Hematologie', TO_DATE('11.03.2018', 'DD.MM.YYYY'), TO_DATE('12.03.2018', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='ECOMED'),(SELECT id_medic FROM Medici_lab WHERE nume_m='DANILIUC'),(SELECT id_asistenta FROM Asistente WHERE nume_a='CAUNIC'),95);
INSERT INTO Analize VALUES(NULL, 'Imunologie', TO_DATE('29.06.2020', 'DD.MM.YYYY'), TO_DATE('29.06.2020', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='DORIMED'),(SELECT id_medic FROM Medici_lab WHERE nume_m='BALAN'),(SELECT id_asistenta FROM Asistente WHERE nume_a='ROTARU'),150);
INSERT INTO Analize VALUES(NULL, 'Electroforeza',  TO_DATE('30.05.2017', 'DD.MM.YYYY'), TO_DATE('30.05.2017', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='ERDOMED'),(SELECT id_medic FROM Medici_lab WHERE nume_m='DUMITRESCU'),(SELECT id_asistenta FROM Asistente WHERE nume_a='MELINTE'),170);
INSERT INTO Analize VALUES(NULL, 'Hepatice', TO_DATE('14.11.2017', 'DD.MM.YYYY'), TO_DATE('15.11.2017', 'DD.MM.YYYY'),(SELECT id_cabinet FROM Cabinete WHERE denumire='ORIMED'),(SELECT id_medic FROM Medici_lab WHERE nume_m='POROSNIUC'),(SELECT id_asistenta FROM Asistente WHERE nume_a='PARVULESCU'),40);
INSERT INTO Analize VALUES(NULL, 'Generale', TO_DATE('24.03.2019', 'DD.MM.YYYY'), TO_DATE('24.03.2019', 'DD.MM.YYYY'), (SELECT id_cabinet FROM Cabinete WHERE denumire='MEDICAL'),(SELECT id_medic FROM Medici_lab WHERE nume_m='BALAUCA'),(SELECT id_asistenta FROM Asistente WHERE nume_a='NICHITA'),90);
INSERT INTO Analize VALUES(NULL, 'Anemie', TO_DATE('11.05.2015', 'DD.MM.YYYY'), TO_DATE('12.05.2015', 'DD.MM.YYYY'), (SELECT id_cabinet FROM Cabinete WHERE denumire='ECOMEDICINA'),(SELECT id_medic FROM Medici_lab WHERE nume_m='PUIU'),(SELECT id_asistenta FROM Asistente WHERE nume_a='SANDU'),60);


----Inserare in tabela Pacienti
INSERT INTO Pacienti VALUES(NULL, 'MIHALACHE', 'NICOLETA', TO_DATE('06.12.1998', 'DD.MM.YYYY'), 1234567891234, 21, 'F', 'BOTOSANI');
INSERT INTO Pacienti VALUES(NULL, 'ROSU', 'MIHAI', TO_DATE('23.06.1972', 'DD.MM.YYYY'), 1234536251234, 43, 'M', 'SUCEAVA');
INSERT INTO Pacienti VALUES(NULL, 'POPESCU', 'LAVINIA', TO_DATE('14.09.2001', 'DD.MM.YYYY'), 1234590791234, 20, 'F', 'BOTOSANI');
INSERT INTO Pacienti VALUES(NULL, 'SCRIPCARU', 'SEBASTIAN', TO_DATE('27.05.1999', 'DD.MM.YYYY'), 1234567856723, 19, 'M', 'BUCURESTI');
INSERT INTO Pacienti VALUES(NULL, 'IONESCU', 'GIGI', TO_DATE('04.03.1998', 'DD.MM.YYYY'), 2345676543478, 25, 'M', 'IASI');
INSERT INTO Pacienti VALUES(NULL, 'PUSCASU', 'ANDREEA', TO_DATE('23.07.1999', 'DD.MM.YYYY'), 1234227891234, 22, 'F', 'SIBIU');
INSERT INTO Pacienti VALUES(NULL, 'DANILIUC', 'STEFAN', TO_DATE('21.03.1997', 'DD.MM.YYYY'), 1234536251200, 47, 'M', 'BRASOV');
INSERT INTO Pacienti VALUES(NULL, 'APETREI', 'BIANCA', TO_DATE('14.10.2004', 'DD.MM.YYYY'), 1234590735234, 28, 'F','BACAU');
INSERT INTO Pacienti VALUES(NULL, 'IRIMIA', 'COSMIN', TO_DATE('23.10.1998', 'DD.MM.YYYY'), 1984590753234, 28, 'M','BACAU');
INSERT INTO Pacienti VALUES(NULL, 'IRIMIA', 'COSMINA', TO_DATE('23.10.1999', 'DD.MM.YYYY'), 1984590753424, 28, 'F','BRASOV');


--Inserare in tabela Detalii
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'ASLO', 0, 34, (SELECT id_analiza FROM Analize WHERE tip='Imunologie'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'Glicemie', 20, 132, (SELECT id_analiza FROM Analize WHERE tip='Biochimie'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'Hematocit', 36,42,  (SELECT id_analiza FROM Analize WHERE tip='Hematologie'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'VSH', 6, 13, (SELECT id_analiza FROM Analize WHERE tip='Standard'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'Albumine',52,62, (SELECT id_analiza FROM Analize WHERE tip='Electroforeza'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'Calciu', 3, 5,  (SELECT id_analiza FROM Analize WHERE tip='Anemie'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'Fier', 37,145,  (SELECT id_analiza FROM Analize WHERE tip='Generale'));
INSERT INTO Detalii(id_detalii, nume_d, val_min, val_max, analize_id_analiza) VALUES(NULL, 'TGO', 0,37,  (SELECT id_analiza FROM Analize WHERE tip='Hepatice'));

--Inserare in tabela Pacienti_Analize
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='MIHALACHE'),(SELECT id_analiza FROM Analize WHERE tip='Biochimie'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='ROSU'),(SELECT id_analiza FROM Analize WHERE tip='Standard'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='POPESCU'),(SELECT id_analiza FROM Analize WHERE tip='Hematologie'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='SCRIPCARU'),(SELECT id_analiza FROM Analize WHERE tip='Imunologie'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='IONESCU'),(SELECT id_analiza FROM Analize WHERE tip='Electroforeza'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='DANILIUC'),(SELECT id_analiza FROM Analize WHERE tip='Generale'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='APETREI'),(SELECT id_analiza FROM Analize WHERE tip='Anemie'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='PUSCASU'),(SELECT id_analiza FROM Analize WHERE tip='Hepatice'));
INSERT INTO Pacienti_Analize VALUES((SELECT id_pacient FROM Pacienti WHERE nume_p='POPESCU'),(SELECT id_analiza FROM Analize WHERE tip='Anemie'));

--Inserare in tabela Pacienti_Detalii
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='ASLO'),(SELECT id_pacient FROM Pacienti WHERE nume_p='ROSU'),32);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='Glicemie'),(SELECT id_pacient FROM Pacienti WHERE nume_p='SCRIPCARU'),132);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='Hematocit'),(SELECT id_pacient FROM Pacienti WHERE nume_p='POPESCU'),38);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='Albumine'),(SELECT id_pacient FROM Pacienti WHERE nume_p='MIHALACHE'),58);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='VSH'),(SELECT id_pacient FROM Pacienti WHERE nume_p='IONESCU'),12);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='TGO'),(SELECT id_pacient FROM Pacienti WHERE nume_p='APETREI'),35);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='Fier'),(SELECT id_pacient FROM Pacienti WHERE nume_p='DANILIUC'),123);
INSERT INTO Pacienti_Detalii VALUES((SELECT id_detalii FROM Detalii WHERE nume_d='Calciu'),(SELECT id_pacient FROM Pacienti WHERE nume_p='POPESCU'),4);















