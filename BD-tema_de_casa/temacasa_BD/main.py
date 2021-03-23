from flask import Flask, render_template, request, redirect
import cx_Oracle
from datetime import datetime

try:
    con=cx_Oracle.connect('temabd/temabd@localhost/xe')

    cursor=con.cursor()
    print("S-a putut conecta la baza de date!")
    cursor.execute("SELECT * FROM Pacienti")


except cx_Oracle.DatabaseError as e:
    print("Nu s-a putut conecta la baza de date!", e)


app=Flask(__name__)

#Pacienti
@app.route('/')
@app.route('/index')
def home():
    return render_template('index.html')


@app.route('/Pacienti')
def Pacienti():
    pacienti=[]

    cursor.execute("SELECT * FROM Pacienti")
    for result in cursor:
      pacient={}
      pacient['id_pacient']=result[0]
      pacient['nume_p']=result[1]
      pacient['prenume_p']=result[2]
      pacient['data_nasterii']=datetime.strptime(str(result[3]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
      pacient['CNP']=result[4]
      pacient['varsta']=result[5]
      pacient['gen']=result[6]
      pacient['adresa']=result[7]
      pacienti.append(pacient)
    return render_template('pages/Pacienti.html', Pacienti=pacienti)


@app.route('/delPacient', methods=['POST'])
def delete_pacient():
    try:
        pacient = request.form['id_pacient']
        cur = con.cursor()
        cur.execute('delete from Pacienti where id_pacient=' + pacient)
        cur.execute('commit')
        print('S-a realizat stergerea!')
        return redirect('/Pacienti')
    except:
        print('Nu s-a realizat stergerea! Probleme la baza de date!')
        return redirect('/Pacienti')

@app.route('/Adauga_Pacient')
def Adauga_Pacient():
    return render_template('pages/Adauga_Pacient.html')


@app.route('/Editeaza_Pacient')
def Editeaza_Pacient():
    return render_template('pages/Editeaza_Pacient.html')


@app.route('/addPacient', methods=['POST'])
def addPacient():
    try:
        if request.method=='POST':
            pacient=0
            cursor.execute('SELECT max(id_pacient) FROM Pacienti')

            for result in cursor:
                pacient=result[0]
            pacient+=1

            values=[]
            values.append("'"+str(pacient)+"'")

            if request.form['nume_p'].isdigit():
                print("Numele pacientului contine numere!")
            else:
                print("Numele pacientului nu contine numere!")
                values.append("'" + request.form['nume_p'] + "'")

            if request.form['prenume_p'].isdigit():
                print("Prenumele pacientului contine numere!")
            else:
                print("Prenumele pacientului nu contine numere!")
                values.append("'" + request.form['prenume_p'] + "'")

            values.append("'" + datetime.strptime(str(request.form['data_nasterii']),'%Y-%m-%d').strftime('%d.%b.%y') + "'")
            values.append("'" + request.form['CNP'] + "'")
            values.append("'" + request.form['varsta'] + "'")

            if request.form['gen']=="F":
                values.append("'" + request.form['gen'] + "'")
            elif request.form['gen']=="M":
                values.append("'" + request.form['gen'] + "'")
            else:
                print("Gen invalid!")

            if request.form['adresa'].isdigit():
                print("Adresa pacientului contine numere!")
            else:
                print("Adresa pacientului nu contine numere!")
                values.append("'" + request.form['adresa'] + "'")

            fields=['id_pacient','nume_p','prenume_p','data_nasterii','CNP','varsta','gen','adresa']
            query = 'INSERT INTO %s (%s) VALUES (%s)' % ('Pacienti', ', '.join(fields), ', '.join(values))
            cursor.execute(query)
            cursor.execute('commit')
        print('S-a realizat adaugarea!')
        return redirect('/Pacienti')
    except:
        print('Nu s-a realizat adaugarea! Probleme la baza de date!')
        return redirect('/Pacienti')


@app.route('/editPacient', methods=['POST'])
def editPacient():
    try:
        pacient=0

        nume_p="'"+request.form['nume_p']+"'"
        if nume_p.isdigit():
            print('Numele pacientului contine numere!')
        else:
            print('Numele pacientului nu contine numere!')

        prenume_p= "'" + request.form['prenume_p'] + "'"
        if prenume_p.isdigit():
            print('Prenumele pacientului contine numere!')
        else:
            print('Prenumele pacientului nu contine numere!')

        cursor.execute('SELECT id_pacient FROM Pacienti where nume_p='+nume_p)
        for result in cursor:
            pacient=result[0]

        data_nasterii = "'" + datetime.strptime(str(request.form['data_nasterii']),'%Y-%m-%d').strftime('%d.%b.%y')+"'"
        CNP = "'" + request.form['CNP'] + "'"
        varsta = "'" + request.form['varsta'] + "'"
        gen = "'" + request.form['gen'] + "'"
        adresa = "'" + request.form['adresa'] + "'"
        if adresa.isdigit():
            print("Adresa pacientului contine numere!")
        else:
            print("Adresa pacientului nu contine numere!")

        query='UPDATE Pacienti SET nume_p=%s , prenume_p=%s , data_nasterii=%s , CNP=%s , varsta=%s ,gen=%s ,adresa=%s WHERE id_pacient=%s' % (nume_p, prenume_p, data_nasterii, CNP, varsta, gen, adresa, pacient)
        cursor.execute(query)
        cursor.execute('commit')
        print('S-a realizat modificarea!')
        return redirect('/Pacienti')
    except:
        print('Nu s-a realizat modificarea! Probleme la baza de date!')
        return redirect('/Pacienti')

#Analize
@app.route('/Analize')
def Analize():
    analize=[]

    cursor.execute("SELECT * FROM Analize")
    for result in cursor:
      analiza={}
      analiza['id_analiza']=result[0]
      analiza['tip']=result[1]
      analiza['data_recoltare']=datetime.strptime(str(result[2]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
      analiza['data_rezultat']=datetime.strptime(str(result[3]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
      analiza['Cabinete_id_cabinet']=result[4]
      analiza['Medici_lab_id_medic']=result[5]
      analiza['Asistente_id_asistenta']=result[6]
      analiza['pret']=result[7]

      analize.append(analiza)

    return render_template('pages/Analize.html', Analize=analize)


@app.route('/delAnaliza', methods=['POST'])
def delete_analiza():
    try:
        analiza = request.form['id_analiza']
        cursor.execute('delete from Analize where id_analiza= ' + analiza)
        cursor.execute('commit')
        print('S-a realizat stergerea!')
        return redirect('/Analize')
    except:
        print('Nu s-a realizat stergerea! Probleme la baza de date!')
        return redirect('/Analize')

@app.route('/Detalii/<id>')
def Detalii_Analize(id):
    detalii = []

    cursor.execute("SELECT * FROM Detalii WHERE id_detalii="+id)
    for result in cursor:
        det = {}
        det['id_detalii'] = result[0]
        det['nume_d'] = result[1]
        det['val_min'] = result[2]
        det['val_max'] = result[3]
        det['Analize_id_analiza'] = result[4]
        detalii.append(det)
    return render_template('pages/Detalii.html', Detalii=detalii)


@app.route('/Adauga_analiza')
def Adauga_analiza():
    analize = []

    cursor.execute("SELECT * FROM Analize")
    for result in cursor:
        analiza = {}
        analiza['id_analiza'] = result[0]
        analiza['tip'] = result[1]
        analiza['data_recoltare'] = datetime.strptime(str(result[2]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
        analiza['data_rezultat'] = datetime.strptime(str(result[3]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
        analiza['Cabinete_id_cabinet'] = result[4]
        analiza['Medici_lab_id_medic'] = result[5]
        analiza['Asistente_id_asistenta'] = result[6]
        analiza['pret'] = result[7]

        analize.append(analiza)

    tp = []
    com = []
    md = []
    asis = []

    cursor.execute('select tip from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        tp.append(result[0])

    cursor.execute('select Cabinete_id_cabinet from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        com.append(result[0])

    cursor.execute('select Medici_lab_id_medic from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        md.append(result[0])

    cursor.execute('select Asistente_id_asistenta from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        asis.append(result[0])

    return render_template('pages/Adauga_analiza.html', Analize=analize, analiza=tp, Cabinete=com, Medici=md, Asistente=asis)

@app.route('/Editeaza_Analiza')
def Editeaza_Analiza():
    analize = []

    cursor.execute("SELECT * FROM Analize")
    for result in cursor:
        analiza = {}
        analiza['id_analiza'] = result[0]
        analiza['tip'] = result[1]
        analiza['data_recoltare'] = datetime.strptime(str(result[2]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
        analiza['data_rezultat'] = datetime.strptime(str(result[3]), '%Y-%m-%d %H:%M:%S').strftime('%d.%b.%y')
        analiza['Cabinete_id_cabinet'] = result[4]
        analiza['Medici_lab_id_medic'] = result[5]
        analiza['Asistente_id_asistenta'] = result[6]
        analiza['pret'] = result[7]

        analize.append(analiza)

    tp = []
    com = []
    md = []
    asis = []

    cursor.execute('select tip from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        tp.append(result[0])

    cursor.execute('select Cabinete_id_cabinet from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        com.append(result[0])

    cursor.execute('select Medici_lab_id_medic from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        md.append(result[0])

    cursor.execute('select Asistente_id_asistenta from Analize where Cabinete_id_cabinet=1')
    for result in cursor:
        asis.append(result[0])

    return render_template('pages/Editeaza_Analiza.html', Analize=analize, analiza=tp, Cabinete=com, Medici=md,Asistente=asis)



@app.route('/addAnaliza', methods=['POST'])
def addAnaliza():
    try:
        if request.method=='POST':
            analiza=0
            cursor.execute('SELECT max(id_analiza) FROM Analize')

            for result in cursor:
                analiza=result[0]
            analiza+=1

            values=[]
            values.append("'"+str(analiza)+"'")

            if request.form['tip'].isdigit():
                print("Tipul analizei contine numere!")
            else:
                print("Tipul analizei nu contine numere!")
                values.append("'" + request.form['tip'] + "'")

            values.append("'" + datetime.strptime(str(request.form['data_recoltare']),'%Y-%m-%d').strftime('%d.%b.%y') + "'")
            values.append("'" + datetime.strptime(str(request.form['data_rezultat']),'%Y-%m-%d').strftime('%d.%b.%y') + "'")
            values.append("'" + request.form['Cabinete_id_cabinet'] + "'")
            values.append("'" + request.form['Medici_lab_id_medic'] + "'")
            values.append("'" + request.form['Asistente_id_asistenta'] + "'")
            values.append("'" + request.form['pret'] + "'")

            fields=['id_analiza','tip','data_recoltare','data_rezultat','Cabinete_id_cabinet','Medici_lab_id_medic','Asistente_id_asistenta','pret']
            query = 'INSERT INTO %s (%s) VALUES (%s)' % ('Analize', ', '.join(fields), ', '.join(values))
            cursor.execute(query)
            cursor.execute('commit')
        print('S-a realizat adaugarea!')
        return redirect('/Analize')
    except:
        print('Nu s-a realizat adaugarea! Probleme la baza de date!')
        return redirect('/Analize')


@app.route('/editAnaliza', methods=['POST'])
def editAnaliza():
    try:
        analiza=0

        tip="'"+request.form['tip']+"'"
        if tip.isdigit():
            print("Tipul analizei contine numere!")
        else:
            print("Tipul analizei nu contine numere!")

        cursor.execute('SELECT id_analiza FROM Analize where tip='+ tip)
        for result in cursor:
            analiza=result[0]

        data_recoltare = "'" + datetime.strptime(str(request.form['data_recoltare']),'%Y-%m-%d').strftime('%d.%b.%y')+"'"
        data_rezultat = "'" + datetime.strptime(str(request.form['data_rezultat']),'%Y-%m-%d').strftime('%d.%b.%y')+"'"
        Cabinete_id_cabinet = "'" + request.form['Cabinete_id_cabinet'] + "'"
        Medici_lab_id_medic = "'" + request.form['Medici_lab_id_medic'] + "'"
        Asistente_id_asistenta = "'" + request.form['Asistente_id_asistenta'] + "'"
        pret = "'" + request.form['pret'] + "'"

        query='UPDATE Analize SET tip=%s , data_recoltare=%s , data_rezultat=%s , Cabinete_id_cabinet=%s, Medici_lab_id_medic=%s ,Asistente_id_asistenta=%s ,pret=%s WHERE id_analiza=%s' % (tip, data_recoltare, data_rezultat,Cabinete_id_cabinet, Medici_lab_id_medic, Asistente_id_asistenta, pret, analiza)
        cursor.execute(query)
        cursor.execute('commit')
        print('S-a realizat modificarea!')
        return redirect('/Analize')
    except:
        print('Nu s-a realizat modificarea! Probleme la baza de date!')
        return redirect('/Analize')


#Asistente
@app.route('/Asistente')
def Asistente():
    asistente=[]

    cursor.execute("SELECT * FROM Asistente")
    for result in cursor:
      asistenta={}
      asistenta['id_asistenta']=result[0]
      asistenta['nume_a']=result[1]
      asistenta['prenume_a']=result[2]
      asistenta['Contracte_id_contract'] = result[3]

      asistente.append(asistenta)

    com=[]
    cursor.execute('select id_contract from Contracte ')
    for result in cursor:
        com.append(result[0])

    return render_template('pages/Asistente.html', Asistente=asistente, Contracte=com)


@app.route('/delAsistenta', methods=['POST'])
def delete_asistenta():
    try:
        asistenta = request.form['id_asistenta']
        cursor.execute('delete from Asistente where id_asistenta=' + asistenta)
        cursor.execute('commit')
        return redirect('/Asistente')
    except:
        print('Nu s-a realizat stergerea! Probleme la baza de date!')
        return redirect('Asistente')


@app.route('/Adauga_asistenta')
def Adauga_asistenta():
    return render_template('pages/Asistente.html')

@app.route('/addAsistenta', methods=['POST'])
def addAsistenta():
    try:
        if request.method=='POST':
            asistenta=0
            cursor.execute('SELECT max(id_asistenta) FROM Asistente')

            for result in cursor:
                asistenta=result[0]
            asistenta+=1

            values=[]
            values.append("'"+str(asistenta)+"'")

            values.append("'"+request.form['nume_a']+"'")
            values.append("'" + request.form['prenume_a'] + "'")
            values.append("'" + request.form['Contracte_id_contract'] + "'")

            fields=['id_asistenta','nume_a','prenume_a', 'Contracte_id_contract']
            query = 'INSERT INTO %s (%s) VALUES (%s)' % ('Asistente', ', '.join(fields), ', '.join(values))
            cursor.execute(query)
            cursor.execute('commit')
        return redirect('/Asistente')
    except:
        print('Nu s-a realizat adaugarea! Probleme la baza de date!')
        return redirect('/Asistente')


#Medici_laborator
@app.route('/Medici_laborator')
def Medici_laborator():
    medici=[]

    cursor.execute("SELECT * FROM Medici_lab")
    for result in cursor:
      medic={}
      medic['id_medic']=result[0]
      medic['nume_m']=result[1]
      medic['prenume_m']=result[2]
      medic['Contracte_id_contract'] = result[3]
      medici.append(medic)

    com = []
    cursor.execute('select id_contract from Contracte ')
    for result in cursor:
        com.append(result[0])

    return render_template('pages/Medici_laborator.html', Medici_laborator=medici, Contracte=com)


@app.route('/delMedic', methods=['POST'])
def delete_medic():
    try:
        medic = request.form['id_medic']
        cursor.execute('delete from Medici_lab where id_medic='+medic)
        cursor.execute('commit')
        return redirect('/Medici_laborator')
    except:
        print('Nu s-a realizat modificarea! Probleme la baza de date!')
        return redirect('Medici_laborator')


@app.route('/Adauga_Medic')
def Adauga_Medic():
    return render_template('pages/Medici_laborator.html')


@app.route('/addMedic', methods=['POST'])
def addMedic():
    try:
        if request.method=='POST':
            id_contract={}
            medic=0
            cursor.execute('SELECT max(id_medic) FROM Medici_lab')
            for result in cursor:
                medic=result[0]
            medic+=1

            values=[]
            values.append("'"+str(medic)+"'")

            values.append("'"+request.form['nume_m']+"'")
            values.append("'" + request.form['prenume_m'] + "'")
            values.append("'" + request.form['Contracte_id_contract'] + "'")

            fields=['id_medic','nume_m','prenume_m', 'Contracte_id_contract']
            query = 'INSERT INTO %s (%s) VALUES (%s)' % ('Medici_lab', ', '.join(fields), ', '.join(values))
            cursor.execute(query)
            cursor.execute('commit')
        return redirect('/Medici_laborator')
    except:
        print('Nu s-a realizat stergerea! Probleme la baza de date!')
        return redirect('/Medici_laborator')

if __name__ == '__main__':
    app.run(debug=True)
    con.close()



