---
fecha: 2000-01-01
origen: proyecto-a
destino: proyecto-b        # un proyecto, "plantilla" o "todos"
tema: La SCP niega PutBucketPolicy al rol del CI
estado: pendiente          # pendiente | hecho
---

**Qué pasó:** al pasar a prod, el apply falló con AccessDenied en `s3:PutBucketPolicy`; lo niega la SCP `p-ejemplo`.

**Qué hacer en el destino:** antes de su paso a prod, aplicar la bucket policy a mano con el rol admin y adoptarla con un bloque `import`.

**Referencia:** decisión NNN y tarea NNNN de proyecto-a.

**Resultado** (lo completa el destino al pasar a hecho):
