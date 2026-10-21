# SPDX-FileCopyrightText: 2026 Colaboradores de apuntes-mutl-uned
#
# SPDX-License-Identifier: MIT

# Detectar el sistema operativo para asignar el comando de borrado
ifeq ($(OS),Windows_NT)
	RM_DIR = rmdir /s /q
else
	RM_DIR = rm -rf
endif

# Declara que estos nombres no son archivos, sino comandos
.PHONY: all clean preview

# Renderiza el libro Quarto
all:
	quarto render

# Lanza el servidor en vivo
preview:
	quarto preview

# Limpia los archivos temporales y el libro compilado
clean:
	-$(RM_DIR) _book
	-$(RM_DIR) .quarto
