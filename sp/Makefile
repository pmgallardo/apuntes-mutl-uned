# SPDX-FileCopyrightText: 2026 Colaboradores de apuntes-mutl-uned
#
# SPDX-License-Identifier: MIT

# Declara que estos nombres no son archivos, sino comandos
.PHONY: all clean preview

# Renderiza el libro Quarto
all:
	quarto render

# Lanza el servidor en vivo para
preview:
	quarto preview

# Limpia los archivos temporales y el libro compilado
clean:
	rm -rf _book/ .quarto/
