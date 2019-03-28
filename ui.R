library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Anuncios de inversión por provincias Argentinas para el período 2003 - 2014*"),
  sidebarPanel(
    conditionalPanel(condition="input.conditionedPanels==1",
                     selectInput("year", 
                                 label = "Elija un Año",
                                 choices = list("2003"= 2003,
                                                "2004"=2004,
                                                "2005"=2005,
                                                "2006"=2006,
                                                "2007"=2007,
                                                "2008"=2008,
                                                "2009"=2009,
                                                "2010"=2010,
                                                "2011"=2011,
                                                "2012"=2012,
                                                "2013"=2013,
                                                "2014"=2014),
                                 selected = 2003)
                     
    ),
    conditionalPanel(condition="input.conditionedPanels==2",
                     selectInput("provincia", 
                                 label = "Elija una Provincia",
                                 choices = list("Autonomous City of Buenos Aires"="AR-C",
                                                "Buenos Aires"="AR-B",
                                                "Catamarca"="AR-K",
                                                "Cordoba"="AR-X",
                                                "Corrientes"="AR-W",
                                                "Chaco"="AR-H",
                                                "Chubut"="AR-U",
                                                "Entre Rios"="AR-E",
                                                "Formosa"="AR-P",
                                                "Jujuy"="AR-Y",
                                                "La Pampa"="AR-L",
                                                "La Rioja"="AR-F",
                                                "Mendoza"="AR-M",
                                                "Misiones"="AR-N",
                                                "Neuquen"="AR-Q",
                                                "Rio Negro"="AR-R",
                                                "Salta"="AR-A",
                                                "San Juan"="AR-J",
                                                "San Luis"="AR-D",
                                                "Santa Cruz"="AR-Z",
                                                "Santa Fe"="AR-S",
                                                "Santiago del Estero"="AR-G",
                                                "Tucuman"="AR-T",
                                                "Tierra del Fuego"="AR-V",
                                                "Malvinas"="FK"),
                                 selected = "AR-C")
                     
                     
    ),
    conditionalPanel(condition="input.conditionedPanels==3",
                     checkboxGroupInput(inputId="provincia2",label="Provincia",
                                        choices =  list("Autonomous City of Buenos Aires"="Autonomous.City.of.Buenos.Aires",
                                                        "Buenos Aires"="Buenos.Aires",
                                                        "Catamarca",
                                                        "Cordoba",
                                                        "Corrientes",
                                                        "Chaco",
                                                        "Chubut",
                                                        "Entre Rios"="Entre.Rios",
                                                        "Formosa",
                                                        "Jujuy",
                                                        "La Pampa"="La.Pampa",
                                                        "La Rioja"="La.Rioja",
                                                        "Mendoza",
                                                        "Misiones",
                                                        "Neuquen",
                                                        "Rio Negro"="Rio.Negro",
                                                        "Salta",
                                                        "San Juan"="San.Juan",
                                                        "San Luis"="San.Luis",
                                                        "Santa Cruz"="Santa.Cruz",
                                                        "Santa Fe"="Santa.Fe",
                                                        "Santiago del Estero"="Santiago.del.Estero",
                                                        "Tucuman",
                                                        "Tierra del Fuego"="Tierra.del.Fuego",
                                                        "Malvinas"),
                                        selected = "Salta")
    )            
    
  ),
  
  mainPanel(
    strong("Todos las cantidades son en millones de dólares"), 
    p("Las inversiones registradas aquí corresponden a los anuncios de empresas que se revelan en medios periodísticos, encuestas propias e información directa de las firmas. Se computan tanto inversiones en ampliación, greenfield como en fusiones y adquisiciones."),
    p("*Nota: los datos para 2014 son provisionales"),
    tabsetPanel(
      tabPanel("Mapas", h4("Mapas de Inversión"), htmlOutput("gvis"), value=1),
      tabPanel("Inversión por Provincia", h4("Evolución Inversión por Provincia"), htmlOutput("bar"), value=2),
      tabPanel("Evolución", h4("Evolución Inversión Comparativo Provincias"), htmlOutput("line"), value=3),
      id="conditionedPanels"
    )
  )
))