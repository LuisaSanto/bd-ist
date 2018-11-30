import numpy as np
import time
import datetime
import random
from random import randint
import string

tables = np.array(["camara", "video", "segmentoVideo", \
    "local", "vigia", "processoSocorro", "eventoEmergencia", \
    "entidadeMeio", "meio", "meioCombate", "meioApoio",\
    "meioSocorro", "transporta", "alocado", "acciona", \
    "coordenador", "audita", "solicita"])

meios = ["Socorro", "Apoio", "Combate"]


def randomtimes(start, end, frmt, n):
    stime = datetime.datetime.strptime(start, frmt)
    etime = datetime.datetime.strptime(end, frmt)
    td = etime - stime
    dates = [random.random() * td + stime for _ in range(n)]
    dates = sorted(dates)
    return dates


def randomphones(d, n):
    rangestart = 10**(d-1)
    rangeend = (10**d)-1
    numbers = [randint(rangestart, rangeend) for _ in range(n)]
    return random.sample(numbers, 100)


def randomnames(m):
    vowels = "aeiou"
    consonants = "".join(set(string.ascii_lowercase) - set(vowels))
    word = ""
    for i in range(m):
        if i % 2 == 0: 
            word += random.choice(consonants)
        else: 
            word += random.choice(vowels)
    return word


def generatelistname(n):
    names = []
    for i in range(n):
        names += [randomnames(5)]
    return random.sample(names, 100)


def generatelistentity(n):
    baseline = ["bombeiros", "exército", "força aérea", "polícia", "município"]
    names = []
    for i in range(n):
        ind = randint(0, 4)
        names += [ baseline[ind] + "_de_" + randomnames(5)]
    return random.sample(names, 100)


def populatecamara(f, i, j):
    f.write("insert into {} values ({});\n".format(i, j + 1))


def populatevideo(f, i, j, times):
    f.write("insert into {} values ('{}', '{}', {});\n".format(i, times[j].replace(microsecond=0), times[j+1].replace(microsecond=0), j + 1))


def populatesegmentovideo(f, i, j, times):
    interval = times[j+1].replace(microsecond=0) - times[j].replace(microsecond=0)
    f.write("insert into {} values ({}, '{}', '{}', {});\n".format(i, j + 1, interval, times[j].replace(microsecond=0), j + 1))


def populatelocal(f, i, j):
    f.write("insert into {} values ('{}');\n".format(i, "address" + str(j+1)))


def populatevigia(f, i, j):
    f.write("insert into {} values ('{}', {});\n".format(i, "address"+str(j+1), j + 1))


def populateeventoemergencia(f, i, j, numbers, names, times):
    interval = times[j+1].replace(microsecond=0) - times[j].replace(microsecond=0)
    f.write("insert into {} values ({}, '{}', '{}', '{}', {});\n".format(i, \
        numbers[j], interval, names[j], "address"+str(j+1), j + 1))


def populateprocessosocorro(f, i, j):
    f.write("insert into {} values ({});\n".format(i, j + 1))


def populateentidademeio(f, i, j, entities):
    f.write("insert into {} values ('{}');\n".format(i, entities[j]))


def populatemeio(f, i, j, entities, entity_names):
    f.write("insert into {} values ({}, '{}', '{}');\n".format(i, j+1, entity_names[j], entities[j]))


def populatemeiocombate(f, i, j, entities, entity_names):
    if entity_names[j] == "Combate":
        numcombate = j+1
        nomecombate = entities[j]
        f.write("insert into {} values ({}, '{}');\n".format(i, numcombate, nomecombate))


def populatemeioapoio(f, i, j, entities, entity_names):
    if entity_names[j] == "Apoio":
        numcombate = j+1
        nomecombate = entities[j]
        f.write("insert into {} values ({}, '{}');\n".format(i, numcombate, nomecombate))


def populatemeiosocorro(f, i, j, entities, entity_names):
    if entity_names[j] == "Socorro":
        numcombate = j+1
        nomecombate = entities[j]
        f.write("insert into {} values ({}, '{}');\n".format(i, numcombate, nomecombate))


def populatetransporta(f, i, j, entities, entity_names):
    if entity_names[j] == "Socorro":
        numcombate = j+1
        nomecombate = entities[j]
        f.write("insert into {} values ({}, '{}', {}, {});\n".format(i, numcombate, nomecombate, \
            randint(1, 100), j + 1))


def populatealocado(f, i, j, entities, entity_names):
    if entity_names[j] == "Apoio":
        numcombate = j+1
        nomecombate = entities[j]
        f.write("insert into {} values ({}, '{}', {}, {});\n".format(i, numcombate, nomecombate, \
            randint(1, 60), j + 1))


def populateacciona(f, i, j, entities):
    f.write("insert into {} values ({}, '{}', {});\n".format(i, j+1, entities[j], j+1))


def populatecoordenador(f, i, j):
    f.write("insert into {} values ({});\n".format(i, j + 1))


def populateaudita(f, i, j, entities, entity_names):
    times_h = randomtimes("13:28:00 2019-01-01", "08:50:34 2019-03-02", '%H:%M:%S %Y-%m-%d', 101)
    f.write("insert into {} values ({}, {}, '{}', {}, '{}', '{}', '{}','{}');\n".format(i, j+1, j+1, \
        entities[j], j+1, \
        times_h[j].replace(microsecond=0), \
        times_h[j+1].replace(microsecond=0), \
        str(times_h[j].replace(microsecond=0))[:10], \
        "Auditoria do processo " + str(j+1) + " que comecou no dia " + str(times_h[j].replace(microsecond=0)) \
        + " e acabou no dia " + str(times_h[j+1].replace(microsecond=0)) + " da entidade " + \
        str(entities[j]) + " do Meio de " + str(entity_names[j]) ))


def populatesolicita(f, i, j, times):
    times_h = randomtimes("13:28:00 2019-02-01", "08:50:34 2019-03-02", '%H:%M:%S %Y-%m-%d', 101)
    f.write("insert into {} values ({}, '{}', {}, '{}', '{}');\n".format(i, j+1, times[j].replace(microsecond=0), \
        j+1, times_h[j].replace(microsecond=0), times_h[j+1].replace(microsecond=0)))


def main():
    frmt = '%H:%M:%S %Y-%m-%d'
    times = randomtimes("13:30:00 2018-01-20", "04:50:34 2018-01-30", frmt, 101)
    numbers = randomphones(9, 1000)
    names = generatelistname(1000)
    entities = generatelistentity(1000)
    entity_names = [meios[randint(0, 2)] for _ in range(100)]
    f = open("populate.sql", "w+")
    for i in tables:
        for j in range(100):
            if i == "camara": populatecamara(f, i, j)
            if i == "video": populatevideo(f, i, j, times)
            if i == "segmentoVideo": populatesegmentovideo(f, i, j, times)
            if i == "local": populatelocal(f, i, j)
            if i == "vigia": populatevigia(f, i, j)
            if i == "eventoEmergencia": populateeventoemergencia(f, i, j, numbers, names, times)
            if i == "processoSocorro": populateprocessosocorro(f, i, j)
            if i == "entidadeMeio": populateentidademeio(f, i, j, entities)
            if i == "meio": populatemeio(f, i, j, entities, entity_names)
            if i == "meioCombate": populatemeiocombate(f, i, j, entities, entity_names)
            if i == "meioApoio": populatemeioapoio(f, i, j, entities, entity_names)
            if i == "meioSocorro": populatemeiosocorro(f, i, j, entities, entity_names)
            if i == "transporta": populatetransporta(f, i, j, entities, entity_names)
            if i == "alocado": populatealocado(f, i, j, entities, entity_names)
            if i == "acciona": populateacciona(f, i, j, entities)
            if i == "coordenador": populatecoordenador(f, i, j)
            if i == "audita": populateaudita(f, i, j, entities, entity_names)
            if i == "solicita": populatesolicita(f, i, j, times)
        f.write("\n")
    f.close()


if __name__ == "__main__":
    main()
