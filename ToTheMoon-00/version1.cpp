#include <iostream>

using namespace std;

class Brazo {
public:
	typedef enum {HORARIO, ANTIHORARIO} sentido;

	void girar(sentido s, unsigned int rpm, unsigned int minutos) {
		cout << "Girando el brazo en sentido " << (s == Brazo::HORARIO ? "horario" : "antihorario") << " a " << rpm << " rpm, durante " << minutos << " minutos." << endl;
	}

	void cerrar_pinzas() {
		cout << "Cerrando pinzas" << endl;
	}
};

typedef enum {PISO_DURO, PISO_BLANDO} tipo_de_piso;
tipo_de_piso detectar_tipo_de_piso(unsigned int dureza, unsigned int porosidad) {
	if (dureza > 100 && porosidad < 100) {
		return PISO_DURO;
	}
	if (dureza <= 100 && porosidad >= 100) {
		return PISO_BLANDO;
	}
	throw "Tipo de piso no reconocido";
}

int main(void) {
	unsigned int dureza, porosidad;
	tipo_de_piso piso;
	Brazo brazo;

	while (true) {
		cout << endl;
		cout << "Ingresar dureza y porosidad separados por un espacio: ";
		try {
			cin >> dureza >> porosidad;
			piso = detectar_tipo_de_piso(dureza, porosidad);
		} catch (const char* msg) {
			cerr << msg << endl;
			continue;
		}
		/**
		 * PISO DURO
		 *   CC 150 RPM 10 MIN
		 *   Cerrar pinza
		 *   C 150 RPM 10 MIN
		 */
		if (piso == PISO_DURO) {
			cout << "El tipo de piso es duro" << endl;
			brazo.girar(Brazo::HORARIO, 150, 10);
			brazo.cerrar_pinzas();
			brazo.girar(Brazo::ANTIHORARIO, 150, 10);
		}
		/**
		 * PISO BLANDO
		 *   CC 100 RPM 5 MIN
		 *   Cerrar pinza
		 *   C 100 RPM 5 MIN
		 */
		if (piso == PISO_BLANDO) {
			cout << "El tipo de piso es blando" << endl;
			brazo.girar(Brazo::ANTIHORARIO, 100, 5);
			brazo.cerrar_pinzas();
			brazo.girar(Brazo::HORARIO, 100, 5);
		}
	}
}