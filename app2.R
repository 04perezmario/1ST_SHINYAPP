# Cargar las librerías necesarias
library(shiny)
library(bslib)

# Definir la Interfaz de Usuario (UI) ----
ui <- page_sidebar(
  title = "Hello World!",  # Título de la app
  sidebar = sidebar(
    "Sidebar", 
    position = "right",
    sliderInput("bins", "Número de barras en el histograma:", 
                min = 1, max = 50, value = 30)  # Control deslizante para ajustar el número de barras
  ),
  
  # Contenido principal
  card(
    card_header("Bienvenido a Shiny"),  # Encabezado de la tarjeta
    "Aquí puedes crear una interfaz de usuario interactiva."
  ),
  
  # Histograma (con salida dinámica)
  plotOutput("distPlot")  # Salida para mostrar el histograma
)

# Definir la lógica del servidor (server) ----
server <- function(input, output) {
  
  # Histograma de los datos del géiser Old Faithful
  output$distPlot <- renderPlot({
    
    # Datos a graficar: los tiempos de espera del géiser
    x    <- faithful$waiting
    
    # Crear los bins basados en el número de barras seleccionadas por el usuario
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # Dibujar el histograma con el borde de color "orange"
    hist(x, breaks = bins, col = "#007bc2", border = "orange",  # Borde en color naranja
         xlab = "Tiempo de espera para la siguiente erupción (en minutos)",
         main = "Histograma de los tiempos de espera")
  })
}

# Ejecutar la app ----
shinyApp(ui = ui, server = server)
