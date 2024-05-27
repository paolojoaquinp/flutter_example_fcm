# flutter_fcm

Este es un ejemplo para utilizar fcm con un servidor de node.js


## 1. Obterner packages de Flutter
 
Ejecuta el comando
```sh
flutter pub get
```

## 2. Configurar El proyecto del backend 
Obtener el backend en:
https://github.com/paolojoaquinp/back_fcm/security/secret-scanning/unblock-secret/2h3zrfX61Bd6nEylPJ6qcK3gS5b

y seguir instrucciones del readme.md para ejecutarlo. 


## Configuración de Firebase

Este proyecto utiliza Firebase. Para configurarlo, sigue estos pasos:

1. Crea un nuevo proyecto en la [consola de Firebase](https://console.firebase.google.com/).
1.1 Puedes hacer la configuracion desde `flutterfire configure` si es asi saltar demas pasos de este bloque(Configuración de Firebase).
2. Agrega una nueva aplicación Android a tu proyecto de Firebase.
3. Descarga el archivo `google-services.json` y colócalo en la carpeta `android/app` de este proyecto.
4. Agrega una nueva aplicación iOS a tu proyecto de Firebase.
5. Descarga el archivo `GoogleService-Info.plist` y colócalo en la carpeta `ios/Runner` de este proyecto.

Nota: No olvides habilitar los servicios que necesites en la consola de Firebase (por ejemplo, autenticación, base de datos, etc.).


## 2.1 Ejecutar app Flutter(y minimizar para tenerlo en segundo plano)

Al iniciar la app podras ver en DEBUG CONSOLE o en tu terminal la salida(output):
FCM Token: y-varias-letras

y-varias-letras es tu token necesitas copiar el token para el paso siguiente.

## 3 Ejecutar endpoint desde Postman o ThunderClient 

metodo: POST
body: {
    "fcmToken": "mi-token-generado-desde-la-consola-de-app"
}

endpoint: http://localhost:3000/sendNotification/

Y YA!