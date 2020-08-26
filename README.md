# Nasa
App iOS que permite visualizar una tabla de contenido, el detalle del elemento muestra información obtenida por el API APOD (Astronomy Picture of the Day). debido al espacio disponible en mi disco, no me fue posible actualizar el SO a macOs Catalina, por este motivo no pude hacer uso de la versión más reciente de Alamofire.

macOs Mojave Versión 10.14.6

Xcode Version 10.2.1

Pods:

pod 'Alamofire', '~> 4.0' : Se utilizó AlamoFire en su versión 4.x por disponibilidad de espacio en disco.

#pod 'Kingfisher', '~> 5.0


La libreria de Kingfisher marcaba que se podia utilizar la versión de Xcode, sin embargo el compilador mandaba el sig error ["Missing return in a function expected to return 'CacheCallbackCoordinator.State'"], por lo cual decidi retirar la libreria e implementar el sig fragmento de código.
``` Web Image
func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let imag = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self!.imageView.image = imag
                    }
                }
            }
        }
    }
```
