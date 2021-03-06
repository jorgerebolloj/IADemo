# IADemo

 ## Control de versiones
	Gitflow con git
  
## Control de ficheros útiles
	.gitignore
  
## Componentes personalizados escalables
	Alert view
	Loader view
  
## Internacionalización
	Localizable strings
	Extención de clase String para optimizar localizable strings
  
## Pods instalados
	Alamofire (REST service)
	RealmSwift (Percistencia de volumen alto de datos)
	SDWebImage (Manejo de descarga de imagenes remotas)
  
## Managers para centralización de gestión de configuraciones y desacoplamiento
	Alamofire
	UserDefaults
	RealmSwift
  
## Persistencia simple
	UserDefaults (Login y perfil)

## Persistencia de alto volumen
	RealmSwift (Cartelera)
  
## Arquitectura
	VIP (Clean swift)
	
## Principios
	SOLID
	
## Modelado de datos para óptimos flujo
	DataModel RequestView (To interactor)
	DataModel ResponseView (To presenter)
	DataModel View (To view controller)
	DataModel RequestWS (WS parameters)
	DataModel ResponseWS (To worker)
	DataModel Entities (Data persistence)
  
## Capa de servicios para centralización de gestión de configuraciones y desacoplamiento
	Dominios
	Endpoints
	WebServicesAPI
	
## Estructura limpia de vistas del proyecto
	Desacoplamiento de vistas y elementos visuales
	
## Estructura limpia de ficheros del proyecto
	Organización y separación de grupos y ficheros
  
## Formulario de login
	Placeholders en campos de texto
	Validaciones para success y error
	Ofuscación de campo de texto password
	Animación de loader
	Feedback a usuario de resultado de operación con alert view
	
## Estructura UI de TabBar
	Sección Perfil
	Sección Cartelera
	
## Vista de Perfil
	Pintado de datos de usuario
	Workflow para transacciones de tarjeta (servicio no disponible)
	Animación de loader
	Feedback a usuario de resultado de operación con alert view
	Función para botón logout

## Vista de Cartelera
	Pintado de posters de películas y nombre
	Flow para mostrar detalle de película
	Animación de loader
	Feedback a usuario de resultado de operación con alert view
	
## Vista de Detalle de película
	Modelado de datos para la vista
	Pintado de deatlle de película
	Presentación de poster de película
	Reproducción de trailer (si está disponible)
	Animación de loader
	Feedback a usuario de resultado de operación con alert view

## Flujo completo para el usuario
	Se puede hacer login y logout en la app
