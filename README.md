# compartido

Rama `compartido` de `ai-native-development`: la estructura del espacio compartido entre los proyectos de una misma carpeta (`Proyectos/`) que comparten entorno (cuentas de nube, permisos, CI, tablero de tareas).

**En git solo hay estructura, formatos y ejemplos.** Los datos reales del entorno y los avisos se escriben en archivos locales que `.gitignore` ignora siempre, como un `.env`.

## Contenido

| Ruta | Qué es | En git |
|---|---|---|
| `CLAUDE.md` | Reglas para las sesiones de todos los proyectos | Sí |
| `instalar.sh` | Deja esta rama en `Proyectos/compartido` y crea `Proyectos/CLAUDE.md` | Sí |
| `respaldar.sh` | Respaldo **cifrado** (age, frase de paso) de los datos reales en un repo privado; `restaurar` para bajarlos | Sí |
| `entorno/*.example.md` | Qué se anota de cada tema, con valores inventados | Sí |
| `entorno/*.md` | Los datos reales del entorno | **No** (local) |
| `avisos/EJEMPLO.md` | Formato de un aviso entre proyectos | Sí |
| `avisos/*.md` | Avisos reales | **No** (local) |

## Instalar en un PC nuevo

```bash
cd ~/Documents/Proyectos            # la carpeta que contiene los proyectos
git clone -b compartido https://github.com/JeanPiffaut/ai-native-development.git compartido
bash compartido/instalar.sh
```

Si `ai-native-development` ya está clonado en la misma carpeta, `instalar.sh` usa un worktree de ese clon en vez de otro clon.

Después: copiar cada `entorno/<tema>.example.md` a `entorno/<tema>.md` y completarlo con los datos reales, o restaurarlos desde el respaldo cifrado con `bash compartido/respaldar.sh restaurar` (pide la frase de paso).
