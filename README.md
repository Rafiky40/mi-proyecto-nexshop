# NexShop Group S.A. - Base de Datos

**Proyecto de Bases de Datos - CodeArts**
**Elaborado por:** Rafael García Moreno

---

## 🏢 Descripción de la Empresa

**NexShop Group S.A.** es una empresa de distribución y venta al por menor fundada en 2015 con sede en Valencia. Opera bajo dos líneas de negocio: una **tienda online** (nexshop.es) y una **red de tres tiendas físicas** en Valencia, Madrid y Barcelona. Ambas líneas comparten el mismo catálogo de más de 2.000 productos organizados en categorías y subcategorías, aunque funcionan de forma casi independiente con equipos distintos.

---

## 📁 Estructura del Repositorio

```
mi-proyecto-nexshop/
  |
  |-- README.md                    ← Este archivo
  |-- docs/
  |    |-- memoria.pdf             ← Memoria de análisis (PDF)
  |    |-- diagrama_er.pdf         ← Diagrama Entidad-Relación (PDF)
  |    |-- modelo_relacional.pdf   ← Modelo relacional (PDF)
  |-- sql/
  |    |-- schema.sql              ← CREATE TABLE con restricciones y FKs
  |    |-- datos.sql               ← INSERT con datos de prueba realistas
  |-- consultas/
       |-- consultas.sql           ← Las 14 consultas comentadas
```

---

## 🗂️ Diagrama Entidad-Relación

El diagrama completo en formato PDF se encuentra en el siguiente enlace:
- [diagrama_er.pdf](docs/diagrama_er.pdf)

El diagrama incluye las 22 entidades del modelo con sus atributos, claves primarias y todas las cardinalidades de las relaciones.

---

## 🚀 Instrucciones de Instalación y Ejecución

### Requisitos previos
- **MySQL 8.x** instalado y en ejecución
- Cliente MySQL (MySQL Workbench, DBeaver, terminal, etc.)

### Paso 1 — Crear la base de datos e importar el esquema
```bash
mysql -u root -p < sql/schema.sql
```
O desde MySQL Workbench: `File → Open SQL Script → schema.sql → Execute (⚡)`

### Paso 2 — Insertar los datos de prueba
```bash
mysql -u root -p nexshop < sql/datos.sql
```

### Paso 3 — Ejecutar las consultas
```bash
mysql -u root -p nexshop < consultas/consultas.sql
```

### Paso 4 — Verificar que todo funciona
```sql
USE nexshop;
SHOW TABLES;           -- Debe mostrar las 22 tablas
SELECT COUNT(*) FROM producto;   -- Debe devolver 20
SELECT COUNT(*) FROM cliente;    -- Debe devolver 10
SELECT COUNT(*) FROM pedido_online; -- Debe devolver 12
```

---

## 📊 Resumen del Modelo

| Entidad | Descripción |
|---|---|
| `sede` | Tiendas físicas + almacén central |
| `empleado` | 47 empleados repartidos por sedes |
| `categoria` | Árbol de categorías y subcategorías |
| `producto` | Catálogo de 2.000+ referencias |
| `historico_precio` | Trazabilidad de cambios de PVP |
| `proveedor` | Empresas suministradoras |
| `proveedor_producto` | Condiciones negociadas por combo proveedor-producto |
| `promocion` | Campañas de descuento temporal |
| `promocion_producto` | Qué productos participan en cada promoción |
| `cliente` | Clientes registrados online |
| `direccion` | Múltiples direcciones por cliente |
| `pedido_online` | Pedidos a través de nexshop.es |
| `linea_pedido` | Detalle de productos por pedido |
| `envio` | Envíos (un pedido puede tener varios) |
| `venta_presencial` | Ventas en tienda física |
| `linea_venta` | Detalle de productos por venta |
| `devolucion` | Devoluciones de ventas presenciales |
| `ticket_incidencia` | Incidencias de atención al cliente |
| `stock` | Nivel de stock por sede y producto |
| `transferencia_stock` | Movimientos de stock entre sedes |
| `valoracion` | Reseñas de clientes (1-5 estrellas) |
| `movimiento_puntos` | Histórico del programa de fidelización |

---

## 📋 Entregables del Proyecto

| Fase | Entregable | Estado |
|---|---|---|
| 1 | Memoria de análisis | ✅ Completada |
| 2 | Diagrama ER | ✅ Completado |
| 3 | Modelo relacional | ✅ Completado |
| 4 | Script SQL (schema + datos) | ✅ Completado |
| 5 | 14 Consultas MySQL | ✅ Completadas |
| 6 | Repositorio GitHub | ✅ Publicado |

---

## 👤 Autor

**Rafael García Moreno** · CodeArts - Curso de Bases de Datos · 2026

---

