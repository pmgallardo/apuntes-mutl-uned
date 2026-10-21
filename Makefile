# SPDX-FileCopyrightText: 2026 Colaboradores de apuntes-mutl-uned
#
# SPDX-License-Identifier: MIT

# Detectar el SO y asignar los comandos correspondientes
ifeq ($(OS),Windows_NT)
    RM_DIR = rmdir /s /q
    MKDIR_SITE = if not exist _site mkdir _site
    CP_INDEX = copy /Y index.html _site\ >nul
    # Añadida la barra invertida (\) antes de _book
    CP_BOOK = xcopy /E /I /Y "$(@:site-%=%)\_book" "_site\$(@:site-%=%)" >nul 2>&1
else
    RM_DIR = rm -rf
    MKDIR_SITE = mkdir -p _site
    CP_INDEX = cp index.html _site/
    # Añadida la barra normal (/) antes de _book
    CP_BOOK = cp -r "$(@:site-%=%)/_book" "_site/$(@:site-%=%)" 2>/dev/null
endif

# Encuentra automáticamente todas las subcarpetas que contienen un Makefile
# (Esto devuelve las carpetas con una barra al final, ej: "asignatura1/")
SUBDIRS := $(dir $(wildcard */Makefile))

# Quita la barra final para tener nombres limpios (ej: "asignatura")
DIR_NAMES := $(patsubst %/,%,$(SUBDIRS))

# Crea listas virtuales de objetivos (ej: "clean-asignatura" y "site-asignatura")
CLEANDIRS := $(DIR_NAMES:%=clean-%)
SITEDIRS  := $(DIR_NAMES:%=site-%)

# Declara que estos nombres no son archivos, sino comandos
.PHONY: all clean site _site_base $(SUBDIRS) $(CLEANDIRS) $(SITEDIRS)

# Compila todos los libros
all: $(SUBDIRS)

# Entra en cada subcarpeta y ejecuta el make local
$(SUBDIRS):
	$(MAKE) -C $@

# El comando (make clean) propaga la limpieza y borra la carpeta web
clean: $(CLEANDIRS)
	-$(RM_DIR) _site

# Regla para limpiar: extrae el nombre de la carpeta y ejecuta 'make clean' dentro
$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean 

# Ensambla la web completa localmente
site: all _site_base $(SITEDIRS)

# Prepara el directorio _site copiando el index
_site_base:
	-$(MKDIR_SITE)
	-$(CP_INDEX)

# Regla para copiar cada libro compilado a su subcarpeta en _site
# Depende de "all" y "_site_base" para asegurar el orden de ejecución correcto
$(SITEDIRS): all _site_base
	-$(CP_BOOK)
