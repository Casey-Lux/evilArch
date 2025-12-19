# evilArch

Repositorio técnico con scripts personales para **gestionar herramientas de seguridad ofensiva en Arch Linux**, priorizando control, trazabilidad y mantenimiento a largo plazo.

El objetivo es **facilitar la exploración e instalación selectiva de herramientas**, sin meta-paquetes, sin instalaciones masivas y sin modificar el sistema base más de lo necesario.

---

## Estructura del repositorio

```
.
├── evil-zsh-aliases.sh   # Funciones Zsh para consultar BlackArch (solo lectura)
├── evil-tools.sh        # Script personal de instalación selectiva de herramientas
└── README.md
```

---

## evil-zsh-aliases.sh

Script que define **funciones para Zsh** orientadas a consultar el repositorio BlackArch usando `pacman`, sin instalar herramientas automáticamente.

Características:

* No instala paquetes
* No modifica configuración de pacman
* No utiliza meta-paquetes ni grupos
* Facilita exploración por áreas

### Funciones disponibles

| Función                 | Descripción                                            |
| ----------------------- | ------------------------------------------------------ |
| `ba <area>`             | Lista herramientas del grupo `blackarch-<area>`        |
| `ba-search <patrón>`    | Busca herramientas BlackArch por nombre                |
| `ba-all`                | Lista todas las herramientas BlackArch sin duplicados  |
| `ba-where <paquete>`    | Muestra los grupos a los que pertenece un paquete      |
| `ba-install <paquetes>` | Wrapper explícito para instalar paquetes usando pacman |

### Ejemplos de uso

```bash
ba webapp
ba networking
ba-search fuzz
ba-where sqlmap
```

### Carga del script

Se recomienda cargarlo desde Zsh:

```bash
source evil-zsh-aliases.sh
```

O incluirlo desde `~/.zshrc` si se desea persistencia.

---

## evil-tools.sh

Script de **instalación manual y selectiva** de herramientas.

No pretende cubrir todos los casos ni automatizar instalaciones complejas. Su propósito es mantener una **lista explícita y auditable** de herramientas que el usuario decide instalar.

---

## Principios

* Arch Linux como sistema base
* BlackArch utilizado únicamente como repositorio de paquetes
* Instalaciones explícitas y controladas
* Evitar meta-paquetes y grupos completos
* Facilidad de auditoría y mantenimiento

---

## Notas

Estos scripts están pensados para **uso personal** y pueden adaptarse según el flujo de trabajo de cada usuario.

No están diseñados para:

* instalaciones automáticas masivas
* entornos desechables
* configuraciones genéricas

---
