# QR Scanner Application

## Descripción

QR Scanner es una aplicación nativa para iOS que permite escanear códigos QR desde la cámara del dispositivo. Esta construído en Swift, SwiftUI y Flutter.
Además, incorpora un vault protegido por acceso biométrico en donde se almacenan los códigos QR previamente escaneados.

## Requisitos
- Flutter SDK instalado
- Fastlane CLI instalado

## Tecnologías utilizadas

- Lenguage Swift, SwiftUI
- UI declarativo con SwiftUI
- Gestión de estados con Combine
- Base de Datos: SwiftData (CoreData)
- Autenticación Biométrica (LocalAuthentication Framework)
- Pruebas XCTest
- Automatización con Fastlane
- Integración con Flutter (FlutterEngine y MethodChannels)

## Instalación y Configuración

- El proyecto fue creado nativamente en iOS y posteriormente se añadió el modulo de Flutter manualmente.
- Inicializar el módulo de Flutter en el proyecto xcode con el siguiente comando:

```
fastlane dev
```
  
- Listo!. El proyecto ya está listo para abrirse en XCode para pruebas

## Ejecución

- WARNING: Cada cambio realizado en el proyecto de Flutter tiene que ser compilado con `fastlane dev` para poder visualizarlo al ejecutarlo en iOS

