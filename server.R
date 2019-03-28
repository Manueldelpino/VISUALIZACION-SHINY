require(googleVis) #Voy a usar esta librería para realizar la geolocalización y visualización del mapa de manera correcta
require(shiny)
library(stringr)

load("data.Rda") 

dat$Inversion<-round(dat$Inversion,2)
# Voy a preparar el dataset obtenido a través de los datos económicos del Gobierno Argentino en política de inversiones
# para pintar las lineas de grafico (plotting)
g<-factor(unique(dat$Name))
c<-split(dat,g)
d <- data.frame(do.call("cbind", c))
x<-seq(4,length(names(d)),by=5)
d<-d[,c(3,x)]
z<-as.character(attributes(c)$names)
z<-str_trim(z, "right") 
names(d)<-c("Year",z)

d<-data.frame(d)

shinyServer(function(input, output) {
  data<-reactive({
    a <- subset(dat, Year==input$year)
    a<-droplevels(a)
    return(a)
  })
  
  output$gvis <- renderGvis({ # Uso renderGvis de la librería googleVis para realizar los mapas
    gvisGeoChart(data(), locationvar="Code", colorvar="Inversion", hovervar="Name", 
                 options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400,  
                              colorAxis="{colors:['#FFFFFF', '#0000FF']}"))  
  })
  
  data<-reactive({
    a <- subset(dat, Year==input$year)
    a<-droplevels(a)
    return(a)
  })
  
  output$gvis <- renderGvis({
    gvisGeoChart(data(), locationvar="Code", colorvar="Inversion", hovervar="Name", 
                 options=list(region="AR", displayMode="region", resolution="provinces", width=600, height=400,  
                              colorAxis="{colors:['#FFFFFF', '#0000FF']}"))  
  })
  
  
  data2<-reactive({
    a <- subset(dat, Code==input$provincia)
    a<-droplevels(a)
    return(a)
  })
  
  output$bar <- renderGvis({  
    gvisColumnChart(data2(), xvar="Year", yvar="Inversion", options=list(hAxis="{title: 'Año', format: '#,###'}", 
                                                                         vAxis="{title:'Cantidades anuales de anuncios de inversión'}",
                                                                         width=600, height=400,  colorAxis="{colors:['#FFFFFF', '#0000FF']}"))
  })
  
  
  data3<-reactive({
    myvars <- names(d) %in% c("Year",input$provincia2)
    d <- data.frame(d[myvars])
    d<-droplevels(d)
    return(d)
  })
  
  
  output$line <- renderGvis({  
    gvisLineChart(data3(), xvar=colnames(data3())[1], yvar=colnames(data3())[-1], 
                  options=list(hAxis="{title: 'Año', format: '#,###'}", vAxis="{title:'Cantidades anuales de anuncios de inversión'}",width=600, height=400,  
                               colorAxis="{colors:['#FFFFFF', '#0000FF']}"))
  })
  
})