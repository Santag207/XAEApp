# XAE Manager App

**XAE Manager App** es una aplicación integral desarrollada para el **Semillero Xaverian Aerospace Engineering (XAE)**. Este proyecto tiene como objetivo facilitar la **gestión de miembros, reuniones, tareas, agendas e inventario**, así como centralizar el acceso a perfiles detallados mediante tecnología de escaneo de códigos QR.

## 👨‍🚀 Proyecto del Semillero XAE

Esta herramienta nace como parte del esfuerzo del semillero por integrar tecnología en los procesos internos de organización, optimizar la trazabilidad de las actividades y fortalecer el trabajo colaborativo dentro de proyectos multidisciplinarios.

## ✍️ Autor
Santiago Castro Zuluaga  
Semillero XAE – Pontificia Universidad Javeriana

## ✨ Funcionalidades

- **Gestión de miembros:** Registro, edición y eliminación de miembros. Acceso a directorios actualizados con datos y roles dentro del semillero.
- **Agendamiento de reuniones:** Planificación de encuentros, envío de notificaciones y almacenamiento de actas.
- **Gestión de tareas:** Asignación de responsabilidades, seguimiento de progreso y cumplimiento de plazos.
- **Planificación de agendas:** Creación de agendas para reuniones, con opción de compartirlas con los asistentes.
- **Control de inventario:** Registro de materiales, alertas por bajo stock y trazabilidad de insumos y herramientas.
- **Perfiles de usuario:** Visualización de datos completos de cada miembro: contacto, historial de participación y tareas asignadas.
- **Escaneo de Códigos QR:** Para ingreso rápido a reuniones, consulta de perfiles e inventario con identificación única.

## 🧰 Tecnologías utilizadas

- **Lenguaje de programación:** Dart  
- **Framework:** Flutter  
- **Base de datos:** Firebase o PostgreSQL  
- **Escáner QR:** `qr_code_scanner`, `barcode_scan2`

## Project Structure
```
JaVexApp/
├── android/             # Android-specific files
├── assets/              # Static resources such as images and fonts
├── ios/                 # iOS-specific files
├── lib/                 # Main source code of the application
│   ├── main.dart        # Entry point of the application
│   ├── models/          # Data models
│   ├── screens/         # UI screens
│   ├── services/        # Business logic and services
│   ├── utils/           # Utility functions and helpers
│   └── widgets/         # Reusable UI components
├── test/                # Unit and widget tests
├── .gitignore           # Specifies files and directories to be ignored by Git
├── pubspec.yaml         # Flutter project configuration file
└── README.md            # Main documentation of the project
```

## 🚀 ¿Cómo usarla?

### 1. Gestión de miembros
- Ir a la sección "Miembros".
- Añadir nuevos integrantes o modificar información de miembros actuales.
- Consultar historial y estado de cada participante.

### 2. Reuniones
- Acceder al módulo de "Reuniones".
- Programar encuentros con hora, fecha y agenda.
- Enviar notificaciones automáticas a los miembros.

### 3. Tareas
- Ver tareas asignadas por proyecto.
- Crear nuevas tareas y definir responsables y fechas límite.
- Marcar tareas completadas o actualizar su estado.

### 4. Agendas
- Crear agendas detalladas para cada reunión.
- Compartirlas para asegurar que todos lleguen preparados.

### 5. Inventario
- Consultar existencias de herramientas y componentes.
- Añadir nuevos ítems y configurar alertas por bajo inventario.

### 6. Perfiles de usuario
- Consultar información completa de cada miembro.
- Revisar historial de tareas, asistencia y roles asumidos.

### 7. QR Codes
- Escanear para marcar asistencia, ver perfiles o registrar movimiento de materiales.

## ⚙️ Instalación

### Clonar el repositorio:

```bash
git clone https://github.com/Santag207/JaVexApp.git
  ```
