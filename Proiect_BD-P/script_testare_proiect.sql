--Ce pret are un tip de analize primit de data de intrare
SELECT a.id_analiza,a.tip, a.pret from analize a WHERE a.tip='Hematologie';


--Ce tip de analize are pretul mai mare decat 150
SELECT a.tip, a.pret from analize a WHERE a.pret>150;


--Afisarea detaliilor analizelor care au pretul intre 50 si 150
SELECT a.id_analiza, a.pret,d.id_detalii,d.nume_d, d.val_min, d.val_max, pd.rezultat from analize a, detalii d, pacienti_detalii pd WHERE a.pret BETWEEN 50 AND 150;


--Cate cabinete se afla la aceeasi adresa primita ca data de intrare
SELECT COUNT(adresa) from cabinete WHERE adresa='BOTOSANI';


--Afisarea numelor si prenumelor medicilor concatenate prin '->'
SELECT m.nume_m|| '->' || m.prenume_m as "Nume si prenume medici" from medici_lab m;


--Afisarea numelui si prenumelui medicilor si data cand au semnat contractul cu cabinetul unde id-ul cabinetului este egal cu 4
SELECT m.nume_m, m.prenume_m, c.id_contract, c.data_start from medici_lab m, contracte c WHERE c.id_contract=4;


--Afisarea datelor pacientului cu numele MIHALACHE
SELECT p.id_pacient, p.nume_p, p.prenume_p,p.data_nasterii, p.CNP, p.varsta, p.gen, p.adresa from pacienti p WHERE p.nume_p='MIHALACHE';


--Afisarea asistentelor al caror id este 2, 3 sau 5
SELECT a.id_asistenta, a.nume_a, a.prenume_a from asistente a WHERE a.id_asistenta IN(2,3,5);


--Afisarea pacientilor a caror prenume incepe cu S
SELECT nume_p, prenume_p from pacienti WHERE prenume_p LIKE 'S%';


--Afisarea in ordine alfabetica a detaliilor analizelor dupa nume al caror rezultat este mai mic sau egal cu 40
SELECT d.id_detalii, d.nume_d from detalii d, pacienti_detalii pd WHERE pd.rezultat <= 40 ORDER BY d.nume_d asc; 


--Afisarea analizelor care au aceeasi data pentru recoltare si pentru rezultat
SELECT id_analiza, tip, data_recoltare, data_rezultat from analize WHERE data_recoltare=data_rezultat;


--Care este data de recoltare a pacientului cu varsta data de intrare
SELECT a.tip, p.nume_p, a.data_recoltare from analize a, pacienti p, Pacienti_Analize pa WHERE a.id_analiza=pa.Analize_id_analiza AND pa.pacienti_id_pacient=p.id_pacient AND p.varsta=20;


--Ce medici sunt angajati si care este perioada angajarii in saptamani ce au id-ul 3
SELECT m.nume_m, (SYSDATE-c.data_start)/7 perioada_angajarii from medici_lab m, contracte c WHERE m.id_medic=3;


--Care sunt asistentele care au fost angajate inainte de 27.06.2016
SELECT a.nume_a, a.prenume_a, c.data_start from asistente a, contracte c WHERE c.data_start<TO_DATE('27.06.2016', 'DD.MM.YYYY');

--Afisarea pretului tuturor analizelor scumpite cu 20
SELECT a.tip, a.pret, d.nume_d, a.pret+20 as scumpire_pret from analize a, detalii d ;    


--Toate detaliile legate de asistente si pacienti
SELECT nume_a, prenume_a, nume_p, prenume_p from asistente, pacienti WHERE id_pacient=id_asistenta;


--Modificarea campului pret
ALTER TABLE analize MODIFY pret number(4);


--Cate femei sunt din totalitatea pacientilor
SELECT COUNT(gen) from pacienti WHERE gen='F';


--Care medic a realizat analiza de tipul Imunologie
SELECT m.id_medic,m.nume_m,m.prenume_m, a.tip from medici_lab m, analize a WHERE m.id_medic=a.id_analiza AND a.tip='Imunologie'; 


--Afisarea detaliilor analizelor facute de pacientul cu numele POPESCU
SELECT p.nume_p, p.nume_p, d.nume_d, d.val_min, d.val_max, pd.rezultat, a.tip from pacienti p,Pacienti_Detalii pd, detalii d, analize a WHERE p.id_pacient=pd.pacienti_id_pacient AND d.id_detalii=pd.detalii_id_detalii AND a.id_analiza=d.id_detalii AND p.nume_p='POPESCU';


--Cat a platit pacientul POPESCU pentru analize
SELECT a.tip, a.pret, p.nume_p from analize a, pacienti p, Pacienti_Analize pa WHERE a.id_analiza=pa.Analize_id_analiza AND pa.pacienti_id_pacient=p.id_pacient AND p.nume_p='POPESCU';


--Care este data de recoltare a pacientului POPESCU
SELECT a.tip, p.nume_p,p.prenume_p, a.data_recoltare from analize a, pacienti p, Pacienti_Analize pa WHERE a.id_analiza=pa.Analize_id_analiza AND pa.pacienti_id_pacient=p.id_pacient AND p.nume_p='POPESCU';


--Care este data rezultatului pacientului POPESCU
SELECT a.tip, p.nume_p, a.data_rezultat from analize a, pacienti p, Pacienti_Analize pa WHERE a.id_analiza=pa.Analize_id_analiza AND pa.pacienti_id_pacient=p.id_pacient AND p.nume_p='POPESCU';


--La ce cabinet si-a facut pacientul POPESCU analizele 
SELECT c.denumire from Cabinete c, pacienti p, Pacienti_Analize pa, analize a WHERE p.id_pacient=pa.pacienti_id_pacient AND a.id_analiza=pa.analize_id_analiza AND a.cabinete_id_cabinet=c.id_cabinet AND p.nume_p='POPESCU';


--Ce medic s-a ocupat de analiza pacientului POPESCU
SELECT m.nume_m, m.prenume_m, a.tip, p.nume_p, p.prenume_p from medici_lab m, analize a, pacienti p,  Pacienti_Analize pa WHERE p.id_pacient=pa.pacienti_id_pacient AND a.id_analiza=pa.analize_id_analiza
AND m.id_medic=a.medici_lab_id_medic AND p.nume_p='POPESCU';


--Care a fost pretul platit pentru analizele facute de catre pacientul data de intrare
SELECT a.pret,a.tip, p.nume_p, p.prenume_p from analize a , pacienti p, Pacienti_Analize pa WHERE a.id_analiza=pa.analize_id_analiza AND p.id_pacient=pa.pacienti_id_pacient AND p.nume_p='ROSU';


--Afisarea tipului de analize realizate de un cabinet ca data de intrare
SELECT a.tip, c.denumire from analize a, cabinete c WHERE c.id_cabinet=a.cabinete_id_cabinet AND c.denumire='ECOMED';


--Care este asistenta care s-a ocupat cu recoltarea analizei de la pacientul cu numele ca data de intrare
SELECT a.nume_a,a.prenume_a, p.nume_p, p.prenume_p from asistente a, pacienti p,analize an, Pacienti_Analize pa  WHERE a.id_asistenta=an.asistente_id_asistenta  AND an.id_analiza=pa.analize_id_analiza AND pa.pacienti_id_pacient=p.id_pacient AND p.nume_p='SCRIPCARU';


--Afisati valorile de minim si maxim pentru o analiza ca data de intrare
SELECT val_min, val_max,nume_d from detalii WHERE nume_d='Albumine'; 

--Modificati numarul de telefon al cabinetului MEDLIFE in 0231588612
UPDATE cabinete SET nr_telefon=0231588612 WHERE denumire='MEDLIFE'; 


--Modificati in STROIESCU MONICA numele asistentei care are id-ul egal cu 2
UPDATE asistente SET nume_a='STROIESCU', prenume_a='MONICA' WHERE id_asistenta=(SELECT id_asistenta from asistente WHERE id_asistenta=2);


--Care este analiza cea mai ieftina
SELECT tip, pret from analize where pret=(select min(pret) from analize); 


--Introduceti o noua inregistrare in tabela pacienti
INSERT INTO pacienti VALUES(NULL, 'FRUNZA', 'EMILIAN', TO_DATE('14.03.2008', 'DD.MM.YYYY'), '0803140700230', 3, 'M','BOTOSANI');


--Stergeti inregistarea facuta
DELETE from Pacienti WHERE nume_p='FRUNZA';


--Afisarea numelui analizei impreuna cu tipul (categoria) din care aceasta face parte
SELECT nume_d, tip FROM Detalii CROSS JOIN Analize;


--Afisati numele si prenumele si cabinetul une lucreaza pentru asistenta ca data de intrare
SELECT a.nume_a, a.prenume_a,ca.denumire from asistente a,cabinete ca, contracte c where a.id_asistenta=c.id_contract and ca.id_cabinet=c.id_contract and a.nume_a='CAUNIC'; 


--Inserati o noua inregistrare in tabela cabinete
INSERT INTO Cabinete VALUES(NULL, 'TEAMED', 'CRAIOVA' , '0235134509');

--Modificati inregistrarii anterioare adresa in TIMISOARA
UPDATE cabinete SET adresa='TIMISOARA' WHERE adresa='CRAIOVA'; 











