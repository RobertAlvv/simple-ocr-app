# Invoice Scanner — Flutter App

App móvil para escanear facturas dominicanas mediante OCR.
Extrae automáticamente: proveedor, RNC, fecha, subtotal, ITBIS y total.

---

## Requisitos

- Flutter 3.19+
- Dart 3.3+
- Backend `simple_ocr_bend` corriendo localmente (ver repo del backend)
- Android emulator o dispositivo físico

---

## Setup

### 1. Instalar dependencias
```bash
flutter pub get
```

### 2. Configurar variables de entorno
```bash
cp .env.example .env
```

Editar `.env`:
```env
# Android emulator
OCR_API_BASE_URL=http://10.0.2.2:8000

# iOS simulator
# OCR_API_BASE_URL=http://localhost:8000

# Dispositivo físico (reemplazar con IP local del servidor)
# OCR_API_BASE_URL=http://192.168.1.X:8000
```

### 3. Generar código (build_runner)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Levantar el backend primero
```bash
cd ../simple_ocr_bend
docker-compose up --build
```

### 5. Correr la app
```bash
flutter run
```

---

## Arquitectura

```
lib/
├── core/
│   ├── error/            → Failures y Exceptions
│   ├── env/              → Variables de entorno (dotenv)
│   ├── di/               → Dependency Injection (get_it + injectable)
│   ├── router/           → Auto Route navigation
│   └── theme/            → App theming
└── features/
    └── invoice/
        ├── data/
        │   ├── datasource/   → InvoiceRemoteDatasource (Dio)
        │   ├── model/        → InvoiceModel (fromJson/toJson)
        │   └── repository_impl/ → InvoiceRepositoryImpl
        ├── domain/
        │   ├── entity/       → InvoiceEntity
        │   ├── repository/   → InvoiceRepository (interfaz)
        │   └── use_case/     → ProcessImage, SaveInvoice, GetInvoice
        └── presentation/
            ├── bloc/         → InvoiceBloc (freezed events/states)
            ├── screen/       → CameraCapture, ExtractedDataReview
            └── view/         → UI views
```

### Flujo de la app

```
CameraScreen
    │
    ▼ (captura imagen)
ProcessImageUseCase
    │
    ▼
InvoiceRepositoryImpl
    │
    ▼
InvoiceRemoteDatasource → POST multipart → Backend OCR
    │
    ▼ (InvoiceModel.fromBackendJson)
InvoiceEntity
    │
    ▼
ExtractedDataReviewScreen → muestra supplier, RNC, fecha, montos
```

### Campos extraídos por el backend

| Campo      | Tipo      | Descripción                         |
|------------|-----------|-------------------------------------|
| supplier   | String?   | Nombre del proveedor                |
| rnc        | String?   | RNC del proveedor (9 dígitos)       |
| date       | DateTime? | Fecha de la factura                 |
| subtotal   | double?   | Monto antes de impuestos            |
| tax        | double?   | ITBIS (18%)                         |
| total      | double?   | Monto total a pagar                 |
| confidence | double?   | Confianza del OCR (0.0 – 1.0)      |
| status     | String    | Processed o Failed                  |
| rawText    | String?   | Texto completo extraído por el OCR  |

---

## Tests

```bash
# Todos los tests
flutter test

# Solo tests unitarios
flutter test test/unit/

# Solo tests de widgets
flutter test test/widget/

# Solo tests de integración (requiere mocks generados)
flutter test test/integration/

# Con cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Troubleshooting

### La app no conecta con el backend
- Verificar que Docker está corriendo: `curl http://localhost:8000/health`
- En emulador Android usar `10.0.2.2` (no `localhost`)
- En dispositivo físico usar la IP local de tu máquina

### Error de certificado SSL
El backend corre en HTTP para el MVP — asegurarse de que
`android:usesCleartextTraffic="true"` está en `AndroidManifest.xml`

### PaddleOCR tarda mucho la primera vez
Normal — descarga modelos ~150MB. El segundo request es rápido.

### build_runner falla
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```
