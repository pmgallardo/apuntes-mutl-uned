# SPDX-FileCopyrightText: 2026 Colaboradores de apuntes-mutl-uned
#
# SPDX-License-Identifier: MIT

# Encuentra automáticamente todas las subcarpetas que contienen un Makefile
SUBDIRS := $(dir $(wildcard */Makefile))

# Crea una lista virtual de objetivos para propagar el "clean" (ej: clean-asignatura1/)
CLEANDIRS := $(SUBDIRS:%=clean-%)

# Declara que estos nombres no son archivos, sino comandos
.PHONY: all clean site $(SUBDIRS) $(CLEANDIRS)

# Compila todas los libros
all: $(SUBDIRS)

# Entra en cada subcarpeta y ejecuta el make local
$(SUBDIRS):
	$(MAKE) -C $@

# El comando (make clean) propaga la limpieza
clean: $(CLEANDIRS)
	rm -rf _site/

# Regla para limpiar: extrae el nombre de la carpeta y ejecuta 'make clean' dentro
$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean 

# Ensambla la web completa localmente
site: all
	mkdir -p _site
	cp index.html _site/
	@for dir in $(SUBDIRS); do \
		DIR_NAME=$$(basename $$dir); \
		cp -r $${dir}_book _site/$$DIR_NAME 2>/dev/null || true; \
	done
