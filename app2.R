# Cargar las librerías necesarias
library(shiny)
library(bslib)

# Definir la Interfaz de Usuario (UI) ----
ui <- page_sidebar(
  #el hello world solo sale arriba a la izquierda 
  title = "Hello World!",  # Título de la app
  sidebar = sidebar(
    "Sidebar", 
    #la sidebar solo sale a la derecha
    position = "right",

#el sliderinput es un control deslizante ajusta el número de barras en un histograma.
    sliderInput("bins", "Número de barras en el histograma:", 
                min = 1, max = 50, value = 30)  # Control deslizante para ajustar el número de barras
  ),
  
  # Contenido principal

  #Card es un componente de interfaz de usuario que se utiliza para organizar y agrupar contenido dentro de una tarjeta visual. 
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
