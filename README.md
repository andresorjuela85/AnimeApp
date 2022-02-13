# AnimeApp

Esta aplicación implementa las funcionalidades solicitadas por Farmatodo para la prueba de desarrollador iOS. Las funcionalides son:

- Mostrar los animes TOP.
- Listado de animes con temporadas recientes.
- Opción de búsqueda de resultados (Filtro por animes top y animes recientes)
- Pantalla de detalle de cada anime
- Opción para ver el trailer del anime
- Animación de tamaño en el carrusel de animes Top

Como patrón de diseño se utilizó MVVM implementado con callbacks.

Para la gestión de dependencias se utilizó Cocoapods. Nota: Las versiones de las librerías son para la versión de Xcode 11.3.1 ya que es la máxima versión que soporta mi computador personal.

Listado de librerías utilizadas:

- Alamofire: Networking
- Alamofire Image: Descarga y caché de imágenes.
- Realm: Librería de base de datos para uso offline de la aplicación.

En el respositorio no se incluyó la carpeta Pods, por lo tanto al descargar el proyecto y antes de ejecutarlo se debe ejecutar la instrucción *pod install*.

## Autor
Andrés Camilo Orjuela Hurtado

email. andcam006@gmail.com

cel. 3202083406
