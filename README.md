# Invoice Scanner — Flutter App

App móvil para escanear facturas mediante OCR.  
Extrae automáticamente: proveedor, RNC, NCF, fecha, subtotal, ITBIS y total — con **confianza por campo**, validación de RNC, y warnings de extracción.

---

## Características

- **API v2** — respuesta enriquecida con confianza por campo (0.0–1.0)
- Indicadores visuales de confianza (color-coded por campo)
- Validación de RNC con indicador verde/rojo
- NCF (Número de Comprobante Fiscal) extraído y editable
- Warnings de extracción en banner amarillo (montos incoherentes, etc.)
- Formulario editable con todos los campos extraídos
- Manejo de errores categorizado (red, timeout, servidor, validación)
- Tiempo de procesamiento y confianza promedio del OCR visibles
- Arquitectura Clean + BLoC + injectable + auto_route

---

## Requisitos

- Flutter 3.19+ (FVM recomendado)
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
│   ├── error/            → Failures y Exceptions (categorías: network, timeout, server, validation)
│   ├── env/              → Variables de entorno (flutter_dotenv)
│   ├── di/               → Dependency Injection (get_it + injectable)
│   ├── router/           → Auto Route navigation
│   ├── theme/            → App theming (colors, typography, spacing)
│   └── widgets/          → Widgets reutilizables:
│       ├── confidence_indicator.dart  → Indicador visual de confianza por campo
│       ├── warnings_banner.dart       → Banner de warnings de extracción
│       └── error_view.dart            → Vista de error categorizada
└── features/
    └── invoice/
        ├── data/
        │   ├── datasource/   → InvoiceRemoteDatasource (Dio → /api/scan-invoice-v2)
        │   ├── model/        → InvoiceModel (fromBackendJson con campos v2)
        │   └── repository_impl/ → InvoiceRepositoryImpl
        ├── domain/
        │   ├── entity/       → InvoiceEntity (v2: NCF, fieldConfidences, warnings, rncValid)
        │   ├── repository/   → InvoiceRepository (interfaz)
        │   └── use_case/     → ProcessImage, SaveInvoice, GetInvoice
        └── presentation/
            ├── bloc/         → InvoiceBloc (freezed events/states, ErrorKind enum)
            ├── screen/       → CameraCapture, ExtractedDataReview, InvoiceDetail
            └── view/         → OcrProcessingView, ExtractedDataReviewView, InvoiceDetailView
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
InvoiceRemoteDatasource → POST multipart → Backend /api/scan-invoice-v2
    │
    ▼ (InvoiceModel.fromBackendJson — mapea campos v2)
InvoiceEntity (con fieldConfidences, extractionWarnings, rncValid, NCF)
    │
    ▼
ExtractedDataReviewView
    ├── WarningsBanner (si hay extraction_warnings)
    ├── ConfidenceIndicator por cada campo
    ├── RNC con badge ✓/✗ validación
    ├── NCF editable
    ├── Montos con indicadores de confianza
    └── Tiempo de procesamiento + confianza promedio OCR
```

### Campos extraídos (v2)

| Campo              | Tipo      | Descripción                              |
|--------------------|-----------|------------------------------------------|
| supplier           | String?   | Nombre del proveedor                     |
| rnc                | String?   | RNC del proveedor (9 dígitos)            |
| rncValid           | bool?     | Si el RNC pasó validación (Luhn)         |
| numeroComprobante  | String?   | NCF / Número de Comprobante Fiscal       |
| date               | DateTime? | Fecha de la factura (ISO 8601)           |
| subtotal           | double?   | Monto antes de impuestos                 |
| tax                | double?   | ITBIS (18%)                              |
| total              | double?   | Monto total a pagar                      |
| fieldConfidences   | Map?      | Confianza por campo (0.0–1.0)            |
| extractionWarnings | List?     | Warnings (montos incoherentes, etc.)     |
| ocrConfidenceAvg   | double?   | Confianza promedio del motor OCR         |
| processingTimeMs   | double?   | Tiempo de procesamiento del backend (ms) |
| confidence         | double?   | Confianza global del OCR (0.0–1.0)       |
| status             | String    | Processed o Failed                       |
| rawText            | String?   | Texto completo extraído por el OCR       |

---

## Tests

```bash
# Todos los tests (56 tests)
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

### Error 404 en scan-invoice-v2
Reiniciar el backend: `docker-compose down && docker-compose up --build`

### PaddleOCR tarda mucho la primera vez
Normal — descarga modelos ~150MB. El segundo request es rápido.

### build_runner falla
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```
