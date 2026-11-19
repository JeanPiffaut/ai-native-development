# Espacio compartido entre proyectos

Este archivo se carga en las sesiones de todos los proyectos de esta carpeta (lo importa `../CLAUDE.md`). Cada proyecto sigue teniendo su propio `CLAUDE.md` y su framework (`ia-docs/` o `docs/`); esto solo agrega lo común.

## Dónde está lo compartido

- `compartido/entorno/`: el conocimiento del entorno que comparten los proyectos (cuentas de nube, permisos, bases de datos, CI, tablero de tareas, equipos de contacto). Los archivos reales son locales y nunca se suben; `*.example.md` muestra qué va en cada uno. Si falta el real, avisar al humano y no inventar valores.
- `compartido/avisos/`: el buzón entre proyectos. Un archivo por aviso, con el formato de `avisos/EJEMPLO.md`.

## Reglas

1. **Citar, no copiar.** Si un dato del entorno ya está en `compartido/entorno/`, el proyecto lo cita. Si el proyecto descubre algo del entorno común, propone agregarlo ahí.
2. **Cada proyecto escribe solo en lo suyo.** Un proyecto no edita el board, el código ni las ramas de otro. Lo que le sirve o le afecta a otro va como aviso en `compartido/avisos/`.
3. **Al iniciar sesión**, listar los avisos con `destino` igual al proyecto (o `todos`) y `estado: pendiente`. Al atenderlo, la sesión del proyecto de destino lo pasa a `estado: hecho` con una línea de resultado.
4. **Lo genérico del framework** (standards, skills, CONSTITUTION) que mejore en un proyecto va como aviso con destino `plantilla`, para llevarlo a `ai-native-development` y propagarlo con `sync-template.sh`.
5. **Nunca** secretos, credenciales ni datos de clientes en `compartido/`, tampoco en los archivos locales. Los secretos siguen en el gestor de secretos de cada ambiente.
6. Esta rama es pública: cualquier cambio a archivos versionados (README, ejemplos, este archivo) no puede llevar datos reales.
