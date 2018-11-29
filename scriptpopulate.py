import numpy as np
import names

tables = np.array(["camara", "video", "segmentoVideo", "\
		local", "vigia", "eventoEmergencia", "processoSocorro", "\
		entidadeMeio", "meio", "meioCombate", "meioApoio", "\
		meioSocorro", "transporta", "alocado", "acciona", "\
		coordenador", "audita", "solicita"])

def populatecamara(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatevideo(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatesegmentovideo(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatelocal(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatevigia(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populateeventoemergencia(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populateprocessosocorro(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populateentidademeio(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatemeio(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatemeiocombate(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatemeioapoio(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatemeiosocorro(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatetransporta(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatealocado(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populateacciona(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatecoordenador(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populateaudita(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))

def populatesolicita(f, i, j):
	f.write("insert into {} values ({});\n".format(i, j + 1))


def main():	
	f = open("populate1.sql", "w+")
	for i in tables:
		for j in range(100):
			if i == "camara": populatecamara(f, i, j)
			if i == "video": populatevideo(f, i, j)
			if i == "segmentoVideo": populatesegmentovideo(f, i, j)
			if i == "local": populatelocal(f, i, j)
			if i == "vigia": populatevigia(f, i, j)
			if i == "eventoEmergencia": populateeventoemergencia(f, i, j)
			if i == "processoSocorro": populateprocessosocorro(f, i, j)
			if i == "entidadeMeio": populateentidademeio(f, i, j)
			if i == "meio": populatemeio(f, i, j)
			if i == "meioCombate": populatemeiocombate(f, i, j)
			if i == "meioApoio": populatemeioapoio(f, i, j)
			if i == "meioSocorro": populatemeiosocorro(f, i, j)
			if i == "transporta": populatetransporta(f, i, j)
			if i == "alocado": populatealocado(f, i, j)
			if i == "acciona": populateacciona(f, i, j)
			if i == "coordenador": populatecoordenador(f, i, j)
			if i == "audita": populateaudita(f, i, j)
			if i == "solicita": populatesolicita(f, i, j)
		f.write("\n")
	f.close()

if __name__ == "__main__":
	main()