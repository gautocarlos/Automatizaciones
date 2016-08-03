  #encoding: utf-8
  # Alta de documento GEDO
  #############################################################
  require 'watir-webdriver'
  require 'logger'
  #Levantar las constantes declaradas
  require '../constantes.rb'
  # Genera los dorectorios de logs
  require '../0000_Directorios_GEDO.rb'
  require './login.rb'
  # Clases de expediente
  require './expediente.rb'
  login = Login.new("C:/Users/cargauto/Documents/GitHub/AutomatizacionesGEDO/json/configuraciones.json","EE")
  login.ingresar()
  #login.ingresarChrome()
  browser = login.getBrowser()
  expediente = Expediente.new(browser)
  cantidadCaratulas = 1000
  while (cantidadCaratulas > 0)
    expediente.caratularInterno()
    expediente.consultaExpedientesPorNumeroExpediente(expediente.getNumeroExpediente())
    expediente.tramitarEjecutarTarea() # Funciona OK
    expediente.vincularDocumentoPorNumeroSADE()
    expediente.vincularDocumentoPorNumeroEspecial()
    expediente.asociarExpediente()
    expediente.paseDestinoTramitacionDestinoSector('Pase automatizado') # OK
    expediente.presionarTabBuzonDeTareas()
    cantidadCaratulas = cantidadCaratulas - 1
  end

  #login = Login.new("C:/Users/cargauto/Documents/GitHub/AutomatizacionesGEDO/json/configuraciones - ECS.json","EE")
  #login = Login.new("C:/Users/cargauto/Documents/GitHub/AutomatizacionesGEDO/json/configuraciones - ECS - CUIT.json","EE")


  #
  #
  #
  expediente.caratularInterno()
  expediente.consultaExpedientesPorNumeroExpediente(expediente.getNumeroExpediente())
  expediente.tramitarEjecutarTarea() # Funciona OK
  #expediente.realizarPaseSinCambioEstadoDestinoUsuario('Pase automatizado')
  expediente.realizarPaseSinCambioEstadoDestinoSector('Pase automatizado') # OK
  expediente.presionarTabBuzonDeTareas()

  #expediente.presionarTabBuzonDeTareas()
  #expediente.obtenerNumeroExpediente() # OK

  #expediente.consultaExpedientesPorNumeroSADE("2016", "00116814", "CHARLY") # Para Fusión
  #expediente.fusion() # OK
  #expediente.tramitacionConjunta() # OK
  #expediente.asociarExpediente() # OK
  #
  expediente.vincularDocumentoPorNumeroEspecial() # OK
  expediente.vincularDocumentoPorNumeroSADE() # OK
  #expediente.parseJSON()
  

  #expediente.consultaExpedientesPorNumeroSADE("2016", "00090646", "CHARLY")
  #expediente.consultaExpedientesPorNumeroSADE("2016", "00058769", "R03")
  #expediente.consultaExpedientesPorNumeroSADE("2016", "00106414", "CHARLY")
  # EX-2016-00116814- -MGEYA-CHARLY
  #expediente.consultaExpedientesPorNumeroSADE("2016", "00116748", "CHARLY") # Para Fusión

  #expediente.paseDestinoIniciacion()

  #expediente.paseDestinoComunicacion()
  #expediente.paseDestinoTramitacion()
  expediente.paseDestinoGuardaTemporalFinal('Pase automatizado')
  #expediente.caratularInterno()
  ##########
  expediente.consultaExpedientesPorNumeroSADE("2016", "00090646", "CHARLY")
  expediente.tramitarEjecutarTarea() # Funciona OK
  #
  # NUEVOS MÉTODOS PARA REALIZAR PASES
  #expediente.paseDestinoIniciacionDestinoUsuario('Pase automatizado') # OK
  #expediente.paseDestinoIniciacionDestinoSector('Pase automatizado') # OK
  #expediente.paseDestinoIniciacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoTramitacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoEjecucionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoSubsanacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  expediente.paseDestinoComunicacionDestinoUsuario('Pase automatizado') # OK
  #expediente.paseDestinoSubsanacionDestinoMesaDeLaReparticion('Pase automatizado') # OK
  #expediente.tramitarAdquirirTareaEjecutar() # OK
  expediente.realizarPaseSinCambioEstadoDestinoUsuario('Pase automatizado') # OK
  #expediente.realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion('Pase automatizado')  # OK
  expediente.realizarPaseSinCambioEstadoDestinoSector('Pase automatizado') # OK
  

  #
  expediente.tramitarEjecutarTarea()
  expediente.realizarPaseSinCambioEstadoDestinoSector('Pase automatizado')
  ####
  expediente.realizarPaseSinCambioEstadoDestinoUsuario('Pase automatizado')
  
  ##########
  #expediente.tramitarAdquirirTarea()


  imagenes = browser.images
  imagenes.each do |imagen|
    if imagen.title == "Ver expediente"
      imagen.click
    end
  end

      botonera = browser.spans(:class => 'z-label') 
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      botonera = self.getBrowser().lis(:class => 'z-menu-item')
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      browser.lis(:class => 'z-menu-item')[8].click

  expediente.parsearBotonesTramitarExpediente()

######
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cnt').images
      botonesImagenes.each do |imagen|
        rutaImagenSplit = imagen.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        botoneraEE = self.getBotoneraEEParseo()
        #
        if nombreImagen == botoneraEE['botonera']['transversal']['RealizarPase']
            imagen.click
          end
        end
######
expediente.getBrowser().text_field(:class => 'z-bandbox-inp')[5]
#####

#$('.z-bandbox-inp').size

  browser.spans(:class => 'z-tab-text').find(browser.span(:class => 'z-tab-text').text == "Consultas")
  browser.spans(:class => 'z-button')[1].click()

  botonera = browser.spans(:class => 'z-tab-text') 
  botonera.each do |boton|
    if (boton.text == "Consultas")
      boton.click
    end
  end

  #############################################################