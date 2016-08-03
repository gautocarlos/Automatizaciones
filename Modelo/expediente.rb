# Clase que se utiliza para realizar operaciones en Expediente Electrónico
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'Matrix'
  require 'htmlentities'
  require './numeroExpediente.rb'
  require '../constantes.rb'
  class Expediente
    attr_accessor
      :browser
      :log
      :trata
      :motivoInterno
      :motivoExterno
      :descAdicional
      :ffcc
      :tipoActuacion
      :anio
      :numero
      :reparticionActuacion
      :reparticionUsuario
      :botoneraEEParseo
      :datosExpediente
      :expedientePasesJSON
      :coder
      :numeroExpediente
    # constructor
    def initialize(browser)
      self.setBrowser(browser)
      log = Logger.new('C:\CapturasWatir\Logs\Logs.txt') #DEBUG
      #@log = Logger.new("#{GEDORUTALOGS}#{GEDONOMBRELOG}")
      self.setLog(log)
      # Herramienta que se utiliza para utilizar acentos y otros caracteres con la nomenclatura HTML
      self.setCoder(HTMLEntities.new)
      # Crea y setea el objeto número de expediente
      #self.setNumeroExpediente(NumeroExpediente.new)
      parseJSON()
      self.parseJSONBotonerasEE()
    end
    # Getters
    def getExpedientePasesJSON()
      return @expedientePasesJSON
    end
    #
    def getDatosExpediente()
      return @datosExpediente
    end
    #
    def getBrowser()
      return @browser
    end
    # 
    def getLog()
      return @log
    end
    #
    def getTrata()
      return @trata
    end
    #
    def getMotivoInterno()
      return @motivoInterno
    end
    #
    def getMotivoExterno()
      return @motivoExterno
    end
    #
    def getDescAdicional()
      return @descAdicional
    end
    # 
    def getFFCC
      return @ffcc
    end
    #
    def getTipoActuacion()
      return @tipoActuacion
    end
    #
    def getAnio()
      return @anio
    end
    #
    def getNumero()
      return @numero
    end
    #
    def getReparticionActuacion()
      return @reparticionActuacion
    end
    # 
    def getReparticionUsuario()
      return @reparticionUsuario
    end
    # 
    def getBotoneraEEParseo()
      return @botoneraEEParseo 
    end
    #
    def getCoder()
      return @coder
    end
    # Retorna un objeto número de expediente
    def getNumeroExpediente()
      return @numeroExpediente
    end
    #
    # Setters
    def setExpedientePasesJSON(expedientePasesJSON)
      @expedientePasesJSON = expedientePasesJSON
    end
    #
    def setDatosExpediente(datosExpediente)
      @datosExpediente = datosExpediente
    end

    def setBrowser(browser)
      @browser = browser
    end
    #
    def setLog(log)
      @log = log
    end
    def setTrata(trata)
      @trata = trata
    end
    #
    def setMotivoInterno(motivoInterno)
      @motivoInterno = motivoInterno
    end
    #
    def setMotivoExterno(motivoExterno)
      @motivoExterno = motivoExterno
    end
    #
    def setDescAdicional(descAdicional)
      @descAdicional = descAdicional
    end
    #
    def setFFCC(ffcc)
      @ffcc = ffcc
    end
    #
    def setTipoActuacion(tipoActuacion)
      @tipoActuacion = tipoActuacion
    end
    #
    def setAnio(anio)
      @anio = anio
    end
    #
    def setNumero(numero)
      @numero = numero
    end
    #
    def setReparticionActuacion(reparticionActuacion)
      @reparticionActuacion = reparticionActuacion
    end
    # 
    def setReparticionUsuario(reparticionUsuario)
      @reparticionUsuario = reparticionUsuario
    end
    #
    def setBotoneraEEParseo (botoneraEEParseo)
      @botoneraEEParseo = botoneraEEParseo
    end
    # Coder para la utilización de acentos y otros caracteres con formato HTML
    def setCoder(coder)
      @coder = coder
    end
    #
    # Almacena un objeto número de expediente
    def setNumeroExpediente(numeroExpediente)
      @numeroExpediente = numeroExpediente
    end
    #
    # Métodos
    def parseJSON()
      archivoDatosEE = open("../JSON/expediente.json")
      datosEE = archivoDatosEE.read
      datosEEParseo = JSON.parse(datosEE)
      # TO DO
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      self.setDatosExpediente(datosEEParseo)
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      # TO DO
      self.setTrata(datosEEParseo["expediente"]["trata"])
      #self.setMotivoInterno(datosEEParseo["expediente"]["motivoInterno"])
      #self.setMotivoExterno(datosEEParseo["expediente"]["motivoExterno"])
      #self.setDescAdicional(datosEEParseo["expediente"]["descAdicional"])
      # Se reliza decode para corregir los caracteres con acentos
      motivoInterno = self.getCoder().decode(datosEEParseo["expediente"]["motivoInterno"])
      motivoExterno = self.getCoder().decode(datosEEParseo["expediente"]["motivoExterno"])
      descAdicional = self.getCoder().decode(datosEEParseo["expediente"]["descAdicional"])
      self.setMotivoInterno(motivoInterno)
      self.setMotivoExterno(motivoExterno)
      self.setDescAdicional(descAdicional)
      #
      if (datosEEParseo["expediente"]["ffcc"] != nil)
        self.setFFCC(datosEEParseo["expediente"]["ffcc"])
      end
      # Se parsea el archivo con la información de los pases
      archivoexpedientePases = open("../JSON/expedientePases.json")
      expedientePasesJSON = archivoexpedientePases.read
      expedientePasesJSONParse = JSON.parse(expedientePasesJSON)
      # TO DO
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      self.setExpedientePasesJSON(expedientePasesJSONParse)
    end
    # Métodos
    # Todos los nombres de las imagenes que se contraponen con botones de EE se parametrizan via JSON
    def parseJSONBotonerasEE()
      archivoBotoneraEE = open("../JSON/botoneraExpediente.json")
      botoneraEE = archivoBotoneraEE.read
      botoneraEEParseo = JSON.parse(botoneraEE)
      self.setBotoneraEEParseo(botoneraEEParseo)
    end
    # Completa los datos de la caratula variable
    def completarFFCC()
      indice = 0 # TO DO: Luego validar si se utiliza esta variable o se puede eliminar
      indiceFFCC = 0
      campos = self.getBrowser().text_fields(:class => 'z-textbox')  
      campos.each do |i|
        indice = indice + 1
        if (i.visible? && !i.readonly?)
          if indice > 0
            i.set self.getFFCC()[indiceFFCC.to_s]
            indiceFFCC = indiceFFCC + 1
          end
          i.fire_event :blur
        end
      end
    end

    # Realiza una caratulación interna de expediente
    def caratularInterno()
      puts "Inicio: caratularInterno()"
      self.iniciarCaratulacionInterna()
      self.completarDatosGenericos()
      self.caratular()
      if(self.tieneCaratulaVariable())
        self.completarCV()
      end
      self.terminarCaratulacion()
      puts "Fin: caratularInterno()"
    end
    # Realiza una caratulación interna de expediente
    def caratularExterno()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[2].click

    end
    #
    def iniciarCaratulacionInterna()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[1].click 
    end
    #
    def iniciarCaratulacionExterna()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[2].click 
    end
    # 
    def completarDatosGenericos()
      puts "Inicio: completarDatosGenericos()"
      Watir::Wait.until { self.getBrowser().text_fields(:class => 'z-textbox')[0].exists?}
      self.getBrowser().text_fields(:class => 'z-textbox')[0].set self.getMotivoInterno()
      #
      self.getBrowser().text_fields(:class => 'z-textbox')[0].fire_event :blur
      #
      self.getBrowser().text_fields(:class => 'z-textbox')[1].set self.getMotivoExterno()
      #
      self.getBrowser().text_fields(:class => 'z-textbox')[1].fire_event :blur
      #
      self.getBrowser().text_field(:class => 'z-bandbox-inp').set self.getTrata()
      #
      self.getBrowser().text_field(:class => 'z-bandbox-inp').fire_event :blur
      #
      self.getBrowser().text_fields(:class => 'z-textbox')[2].set self.getDescAdicional()
      #
      self.getBrowser().text_fields(:class => 'z-textbox')[2].fire_event :blur
      #
      puts "Fin: completarDatosGenericos()"
    end
    # 
    def completarDatosPersonaFisica()

    end
    #
    def caratular()
      # Espera para evitar intentanr presionar un botón que aún no se ha cargado
      Watir::Wait.until {self.getBrowser().divs(:class => 'z-toolbarbutton')[3].exists?}
      #
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].click
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].wait_while_present
    end
    def tieneCaratulaVariable()
      return (self.getBrowser().fieldset(:class => 'z-fieldset').exists?)
    end
    #
    def completarCV()
        self.completarFFCC()
        self.getBrowser().element(:class => 'z-button-cm').click
        self.getBrowser().fieldset(:class => 'z-fieldset').wait_while_present
    end
    # Obtiene el número de expediente generado
    # Reemplazar el HARDCODE
    def obtenerNumeroExpediente()
      textoGeneracionExpediente = 'Se generó el expediente: '
      labelExpediente = nil
      labels = self.getBrowser().spans(:class => 'z-label')
      numeroExpediente = ''
      labels.each do |label|
        if (label.text.include? textoGeneracionExpediente)
          labelExpediente = label
          numeroExpediente = labelExpediente.text.gsub(textoGeneracionExpediente, '')
          break
        end
      end
      #
      #puts "labelExpediente :: #{labelExpediente} ::"
      puts "numeroExpediente :: #{numeroExpediente} ::"
      self.setNumeroExpediente(NumeroExpediente.new(numeroExpediente))
    end
    # HARDCODE : Parametrizar : Cierra el cuadro de mensaje de generación de expediente : 
    def terminarCaratulacion()
      claseHeaderMensaje = 'z-window-highlighted-header'
      textoBotonTDOK = 'OK'
      claseBotonTDOK = 'z-button-cm'
      Watir::Wait.until {self.getBrowser().element(:class => claseHeaderMensaje).exists?}
      #Watir::Wait.until {self.getBrowser().element(:class => 'z-button-cm').exists?}
      # Obtiene y guarda el número del expediente generado
      self.obtenerNumeroExpediente()
      #Watir::Wait.until {self.getBrowser().element(:class => 'z-button-cm').exists?}
      #Watir::Wait.until {self.getBrowser().element(:class => 'z-window-highlighted-header').exists?}
      self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
      #self.getBrowser().element(:class => 'z-button-cm').click
    end
    # DESARROLLAR: Buscar un elemento del tipo i mediante la clase y un texto
    def buscarElementoTextoAtributo(clase, titulo)
      
    end
    # Deprecar?
    def consultarEE()
      self.presionarTabConsulta()

    end
    # Recibe por parámetro el código SADE de un expediente y lo busca
    # Se debería deprecar y ser reeemplazado por el método: consultaExpedientesPorNumeroExpediente(numeroExpediente)
    def consultaExpedientesPorNumeroSADE(anio, numero, reparticionUsuario)
      self.presionarTabConsulta()
      self.presionarBotonConsultaExpedientesPorNumeroSADE()
      self.cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      self.presionarBotonBuscarExpediente()
    end
    # Recibe por parámetro un objeto numeroExpediente y lo busca
    def consultaExpedientesPorNumeroExpediente(numeroExpediente)
      puts "Inicio: consultaExpedientesPorNumeroExpediente(numeroExpediente)"
      anio = numeroExpediente.getAnio()
      numero = numeroExpediente.getNumero()
      reparticionUsuario = numeroExpediente.getReparticionUsuario()
      #
      self.presionarTabConsulta()
      self.presionarBotonConsultaExpedientesPorNumeroSADE()
      self.cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      self.presionarBotonBuscarExpediente()
      puts "Fin: consultaExpedientesPorNumeroExpediente(numeroExpediente)"
    end
    # Redefinir para quitar HARDCODE
    def presionarTabConsulta()
      # HARDCODE
      botonera = self.getBrowser().spans(:class => 'z-tab-text') 
      botonera.each do |boton|
        if (boton.text == "Consultas")
          boton.click
        end
      end
    end
    #
    # HARCODE A MODIFICAR: CLASE DEL BOTÓN A PRESIONAR
    def presionarTabBuzonDeTareas()
      puts "Inicio: presionarTabBuzonDeTareas()"

      botoneraEE = self.getBotoneraEEParseo()
      textoBotonSpanTab = self.getCoder().decode(botoneraEE['botonera']['tabs']['tabBuzonDeTareas'])
      #textoBotonSpanTab = botoneraEE['botonera']['tabs']['tabBuzonDeTareas']
      #puts "textoBotonSpanTab :: #{textoBotonSpanTab}"
      claseBotonSpanTab = 'z-tab-text'
      self.presionarBotonSpan(textoBotonSpanTab, claseBotonSpanTab)
      puts "Fin: presionarTabBuzonDeTareas()"
    end
    #
    def presionarBotonConsultaExpedientesPorNumeroSADE()
      Watir::Wait.until { self.getBrowser().button(:class => 'z-menu-item-btn').exists?}
      self.getBrowser().button(:class => 'z-menu-item-btn').click
    end
    #
    def presionarBotonBuscarExpediente()
      textoBoton = 'Buscar'
      botonPresionado = nil
      botonera = self.getBrowser().tds(:class => 'z-button-cm') 
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          botonPresionado = boton
          boton.click
          boton.wait_while_present
          return true
        end
      end
      return false
    end
    # HARDCODE 
    def cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      texto = 'Consulta Expedientes por número'
      puts "Inicio: cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)"
      self.esperarTexto(texto)
      Watir::Wait.until { self.getBrowser().text_fields(:class => 'z-intbox')[0].exists? }
      self.getBrowser().text_fields(:class => 'z-intbox')[0].set anio
      self.getBrowser().text_fields(:class => 'z-intbox')[0].fire_event :blur
      self.getBrowser().text_fields(:class => 'z-intbox')[1].set numero
      self.getBrowser().text_fields(:class => 'z-intbox')[1].fire_event :blur
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set reparticionUsuario
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur
      puts "Fin: cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)"
    end
    # Refactorizar utilizando elementoImagen : TO DO
    def visualizarExpediente()
      imagenes = self.getBrowser().images
      imagenes.each do |imagen|
        if imagen.title == "Ver expediente"
          imagen.click
        end
      end
    end
    #
    def consultasPresionarTramitar()
      puts "Inicio: consultasPresionarTramitar()"
      # Parametrizar HARDCODE
      clase = 'z-label'
      textoBoton = 'Tramitar'
      # Aguardar a que exista el resultado de la búsqueda
      Watir::Wait.until { (self.getBrowser().divs(:class => 'z-listbox-body'))[1].exists?}
      #  Se reemplaza este método
      self.presionarBotonSpan(textoBoton, clase)
      puts "Fin: consultasPresionarTramitar()"
    end
    def consultasPresionarTramitarEjecutarTarea()
      puts "Inicio: consultasPresionarTramitarEjecutarTarea()"
      # Parametrizar HARDCODE
      textoBoton = 'Ejecutar Tarea'
      clase = 'z-menu-item-cnt'
      Watir::Wait.until { (self.getBrowser().divs(:class => 'z-menu-popup z-menu-popup-shadow'))[0].exists?}
      self.presionarBotonLink(textoBoton, clase)
      puts "Fin: consultasPresionarTramitarEjecutarTarea()"
    end
    # HARCODE parametrizar
    def tramitarEjecutarTarea()
      puts "Inicio: tramitarEjecutarTarea()"
      self.consultasPresionarTramitar()
      self.consultasPresionarTramitarEjecutarTarea()
      puts "Fin: tramitarEjecutarTarea()"
    end
    #
    def tramitarAdquirirTarea()
      puts "Inicio: tramitarAdquirirTarea()"
      self.consultasPresionarTramitar()
      Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[9]).exists?}
      botonAdquirir = self.getBrowser().lis(:class => 'z-menu-item')[9]
      botonAdquirir.click
      botonAdquirir.wait_while_present
      puts "Fin: tramitarAdquirirTarea()"
    end
    #
    def tramitarAdquirirTareaEjecutar()
      #consultasPresionarTramitar()
      #Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[9]).exists?}
      #botonAdquirir = self.getBrowser().lis(:class => 'z-menu-item')[9]
      #botonAdquirir.click
      #botonAdquirir.wait_while_present
      puts "Inicio: tramitarAdquirirTareaEjecutar()"
      botoneraEE = self.getBotoneraEEParseo()
      self.tramitarAdquirirTarea()
      # FALTA UN WAIT, NO LLEGA A CARGAR EL BOTON POR ESO FALLA
      boton = self.presionarBotonImagen(botoneraEE['botonera']['botonesInternos']['Ejecutar'], 0)
      boton.wait_while_present
      puts "Fin: tramitarAdquirirTareaEjecutar()"
    end
    # Presiona el botón de realizar pase de la botonera transversal de la tramitación de expediente
    def presionarRealizarPaseBotoneraTransversal()
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPase'], 0)      
    end
    # Presiona el botón de realizar pase paralelo de la botonera transversal de la tramitación de expediente
    def presionarRealizarPaseParaleloBotoneraTransversal()
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPaseParalelo'], 0)      
    end
    # Presiona el botón de realizar pase de la pantalla propia de realizar pase
    def presionarRealizarPase()
      puts "Inicio: presionarRealizarPase()"
      # Parametrizar HARDCODE
      textoConfirmacionPase = 'Se generó el pase del expediente'
      textoBotonTDOK = 'OK'
      claseBotonTDOK = 'z-button-cm'
      # Parametrizar HARDCODE
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPase'], 1)
      #
      Watir::Wait.until {(self.getBrowser().text.include? textoConfirmacionPase)}
      #self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
      # Prueba a realizar, nuevo botón de espera
      self.presionarEsperarBotonTD(textoBotonTDOK, claseBotonTDOK)
      puts "Fin: presionarRealizarPase()"
    end
    # Presiona el botón de realizar pase de la pantalla propia de realizar pase
    def presionarRealizarPaseParalelo()
      puts "Inicio: presionarRealizarPaseParalelo()"
      # Parametrizar HARDCODE
      textoConfirmacionPase = 'Se generó el pase del expediente'
      textoBotonTDOK = 'OK'
      claseBotonTDOK = 'z-button-cm'
      # Parametrizar HARDCODE
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPaseParalelo'], 1)
      #
      Watir::Wait.until {(self.getBrowser().text.include? textoConfirmacionPase)}
      #self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
      # Prueba a realizar, nuevo botón de espera
      self.presionarEsperarBotonTD(textoBotonTDOK, claseBotonTDOK)
      puts "Fin: presionarRealizarPaseParalelo()"
    end
    #
    # Realizar pase paralelo de un expediente
    def realizarPaseParalelo(motivoPase)
      puts "Inicio: realizarPaseParalelo(motivoPase)"
      self.presionarRealizarPaseParaleloBotoneraTransversal()
      self.cargarDestinoUsuariosParalelo() # CREAR
      self.cargarDestinoSectoresParalelo()  # CREAR
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPaseParalelo()
      puts "Fin: realizarPaseParalelo(motivoPase)"
    end    
    #
    # DESARROLLAR
    def cargarDestinoUsuariosParalelo()
      puts "Inicio: cargarDestinoUsuariosParalelo()"
      datosExpediente = self.getDatosExpediente()
      sleep 1
      campoUsuario = self.getBrowser().text_fields(:class => 'z-combobox-inp')
      indice = 1
      campoUsuario.each do |inputUsuario|
        if (inputUsuario.visible?)
          begin
            #puts "indice:: #{indice} :: inputUsuario.visible"
            inputUsuario.set datosExpediente['expediente']['pase']['usuarioDestino']
            break
            rescue 
              puts "No se puede cargar el usuarioDestino en este input."
          end          
        end
      end
      sleep 2
      self.getBrowser().execute_script("$('.z-comboitem-text').get($('.z-comboitem-text').size()-1).click()")
      sleep 2
      puts "Fin: cargarDestinoUsuariosParalelo()"
    end
    # 
    def cargarDestinoSectoresParalelo()
      # Levantar del JSON
      puts "Inicio: cargarDestinoSectoresParalelo()"
      datosExpediente = self.getDatosExpediente()
      #sleep 2 # Agregar un wait que evalue si el campo está habilitado o no
      # Reemplaza sleep 2
      Watir::Wait.until { (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).exists? }
      #
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).set datosExpediente['expediente']['pase']['sectorDestino']['reparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].fire_event :blur
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6]).set datosExpediente['expediente']['pase']['sectorDestino']['sector']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6].fire_event :blur
      puts "Fin: cargarDestinoSectoresParalelo()"
    end
    # 
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino usuario:
    def realizarPaseSinCambioEstadoDestinoUsuario(motivoPase)
      puts "Inicio: realizarPaseSinCambioEstadoDestinoUsuario(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
      puts "Fin: realizarPaseSinCambioEstadoDestinoUsuario(motivoPase)"
    end
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino Reparticion-Sector:
    def realizarPaseSinCambioEstadoDestinoSector(motivoPase)
      puts "Inicio: realizarPaseSinCambioEstadoDestinoSector(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
      puts "Fin: realizarPaseSinCambioEstadoDestinoSector(motivoPase)"
    end
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino: Mesa de la repartición
    def realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion(motivoPase)
      puts "Inicio: realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
      puts "Fin: realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion(motivoPase)"
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonImagen(nombreBoton)
      #Obtener todas imagenes que sean botones
      Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cnt').images
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == nombreBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              break
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoTD y Deprecar
    def presionarBotonTD(textoBoton, clase)
      # Redefinir la variable clase para recibir por parámetro la clase del componente a presionar click
      #clase = 'z-button-cm'
      botonera = self.getBrowser().tds(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          #break
          return true
        end
      end
      #botonConsulta.wait_while_present
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    #
    # Busca un componente TD en base a un texto y aguarda mientras esté presente el botón
    # Migrar a clase elementoTD y Deprecar
    def presionarEsperarBotonTD(textoBoton, clase)
      # Redefinir la variable clase para recibir por parámetro la clase del componente a presionar click
      #clase = 'z-button-cm'
      #presionarBotonTD = nil
      botonera = self.getBrowser().tds(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          boton.wait_while_present
          #break
          return true
        end
      end
      #botonConsulta.wait_while_present
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoSPAN y Deprecar
    def presionarBotonSpan(textoBoton, clase)
      # Redefinir la variable clase para recibir por parámetro la clase del componente a presionar click
      #clase = 'z-button-cm'
      #puts "presionarBotonSpan() -- textoBoton:: #{textoBoton} :: -- Clase:: #{clase} ::"
      botonera = self.getBrowser().spans(:class => clase)
      botonera.each do |boton|
        begin 
          if (boton.text() == textoBoton)
            boton.click
            #break
            return true        
          end
        rescue
          puts "ERROR al intentar :: presionarBotonSpan(textoBoton, clase) :: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} :: Posiblemente no se pueda acceder a algún elemento ::"
        end
      end
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    # # Migrar a clase elementoLink y Deprecar
    def presionarBotonLink(textoBoton, clase)
      # Redefinir la variable clase para recibir por parámetro la clase del componente a presionar click
      #clase = 'z-button-cm'
      #puts "presionarBotonSpan() -- textoBoton:: #{textoBoton} :: -- Clase:: #{clase} ::"
      botonera = self.getBrowser().links(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          break
        end
      end
      #botonConsulta.wait_while_present
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoImagen y Deprecar
    def presionarBotonImagen(nombreBoton, indiceFrame)
      #Obtener todas imagenes que sean botones
      Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      botonesImagenes = (self.getBrowser().divs(:class => 'z-window-highlighted-cnt'))[indiceFrame].images
      botonPresionado = nil
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == nombreBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              botonPresionado = boton
              break
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
      return botonPresionado
    end
    #
    def seleccionarDestinoUsuario()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[2]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[2].click
    end
    # 
    def seleccionarDestinoSector()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[3]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[3].click
    end
    # 
    def seleccionarDestinoMesaDeLaReparticion()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[4]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[4].click
    end
    # 
    def cargarDestinoUsuario()
      puts "Inicio: cargarDestinoUsuario()"
      datosExpediente = self.getDatosExpediente()
      sleep 1
      campoUsuario = self.getBrowser().text_fields(:class => 'z-combobox-inp')
      indice = 1
      campoUsuario.each do |inputUsuario|
        if (inputUsuario.visible?)
          begin
            #puts "indice:: #{indice} :: inputUsuario.visible"
            inputUsuario.set datosExpediente['expediente']['pase']['usuarioDestino']
            break
            rescue 
              puts "No se puede cargar el usuarioDestino en este input."
          end          
        end
      end
      sleep 2
      self.getBrowser().execute_script("$('.z-comboitem-text').get($('.z-comboitem-text').size()-1).click()")
      sleep 2
      puts "Fin: cargarDestinoUsuario()"
    end
    # 
    def cargarDestinoSector()
      # Levantar del JSON
      puts "Inicio: cargarDestinoSector()"
      datosExpediente = self.getDatosExpediente()
      #sleep 2 # Agregar un wait que evalue si el campo está habilitado o no
      # Reemplaza sleep 2
      Watir::Wait.until { (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).exists? }
      #
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).set datosExpediente['expediente']['pase']['sectorDestino']['reparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].fire_event :blur
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6]).set datosExpediente['expediente']['pase']['sectorDestino']['sector']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6].fire_event :blur
      puts "Fin: cargarDestinoSector()"
    end
    # 
    def cargarDestinoMesaDeLaReparticion()
      puts "Inicio: cargarDestinoMesaDeLaReparticion()"
      datosExpediente = self.getDatosExpediente()
      posicion = (self.getBrowser().text_fields(:class => 'z-bandbox-inp')).size() - 2
      sleep 1
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[posicion]).set datosExpediente['expediente']['pase']['mesaDeLaReparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[posicion].fire_event :blur
      puts "Fin: cargarDestinoMesaDeLaReparticion()"
    end
    #
    def completarMotivoPase(motivoPase)
      # Completar el motivo del Pase
      scriptOld = "$($('iframe').get(1)).contents().find('body').find('iframe').contents().find('body').append('<p>#{motivoPase}</p>')"
      scriptNew = "
      marcos = $('iframe')
      for (i = 0; i < marcos.size(); i++)
      {
        srcUnFrame = marcos.get(i).src
        if ((srcUnFrame != null) && (srcUnFrame.contains('FCKeditor'))) {
           console.log(srcUnFrame)
           console.log(i)
           $($('iframe').get(i)).contents().find('body').find('iframe').contents().find('body').append('<p>#{motivoPase}</p>')
        }
      };"      
      self.getBrowser().execute_script(scriptNew)
    end
    # Métodos para relizar un pase cambiando el destino
    def paseDestinoIniciacion(obsoleto)
      expedientePasesJSON = self.getExpedientePasesJSON()
      indice = 0
      estadoIniciacion = 'Iniciación'
      existeEstado = false
      comboEstadoActual = self.getBrowser().text_fields(:class => 'z-combobox-inp z-combobox-readonly')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estado.value() == estadoIniciacion))
          existeEstado = true
          break
        end
      end
      if !(existeEstado)
        # Implementar raise
        puts "paseDestinoIniciacion() - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return
      end
    end
    #
    def paseDestinoIniciacion()
      # HARDCODE
      destinoPase = 'Iniciación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseInciacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        #self.seleccionarDestinoTramitacion(comboEstado)
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    # Método principal de realización de pase a Tramitación
    def paseDestinoTramitacion()
      destinoPase = 'Tramitación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseTramitacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        #self.seleccionarDestinoTramitacion(comboEstado)
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoComunicacion()
      destinoPase = 'Comunicación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseComunicacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoEjecucion()
      destinoPase = 'Ejecución'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseEjecucion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoSubsanacion()
      destinoPase = 'Subsanación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseSubsanacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoGuardaTemporal()
      destinoPase = 'Guarda Temporal'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseGuardaTemporal()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      #puts ":: paseDestinoGuardaTemporal() ::  (comboEstado != nil) ::"
      if (comboEstado != nil)
        # Existe el destino seleccionado
        #puts ":: paseDestinoGuardaTemporal() ::  (comboEstado != nil) ::"
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def validarEstadoExpedienteParaPase(estadosValidos)
      indice = 0
      #estadoIniciacion = expedientePasesJSON['destinoEstados']['Iniciación']['Iniciación']
      #estadoActual = 'Tramitación' # [Iniciación, Tramitación, Subsanación] Pueden pasar a Tramitación. AGREGAR VALIDACIÓN DE ESTOS ESTADOS
      #estadosValidos = self.estadosValidosPaseTramitacion() # ['Iniciación', 'Tramitación', 'Subsanación'] # Estados válidos para la transición
      #destinoPase = 'Tramitación'
      existeEstado = false
      comboEstado = nil #
      #comboEstados = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual = self.getBrowser().text_fields(:class => 'z-combobox-inp z-combobox-readonly')
      comboEstadoActual.each do |estado|
        #puts "Estado: #{indice} :  #{estado.value()} ::"
        indice = indice + 1
        #if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estado.value() == estadoActual))
        if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estadosValidos.include?(estado.value())))
          # Hay que ver como validar los acentos
          #puts ":: validarEstadoExpedienteParaPase(estadosValidos) ::Estado dentro de IF: #{indice} :  #{estado.value()} ::"
          existeEstado = true
          comboEstado = estado
          break
        end
      end
      if !(existeEstado)
        puts "validarEstadoExpedienteParaPase() - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return nil
      end
      return comboEstado
    end
    #
    def seleccionarDestino(comboEstado, destinoPase)
      #puts ":: seleccionarDestino(destinoPase) :: #{destinoPase} ::"
      comboEstado.click()
      sleep 1
      estadoValido = self.validarDestinoSeleccionado(destinoPase)
      # Se selecciona el estado destino
      if (estadoValido != nil)
        estadoValido.click()
        return true
      end
      return false
      #
    end
    # Valida que el destino  exista para ser seleccionado
    def validarDestinoSeleccionado(destinoPase)
      indice = 0
      existeEstado = false
      estadoValido = nil
      comboEstadoActual = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.text() != nil) || (estado.text() != '')) && (estado.text() == destinoPase))
          existeEstado = true
          estadoValido = estado
          break
        end
      end
      if !(existeEstado)
        puts "validarDestinoSeleccionado(#{destinoPase}) - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return nil
      end
      return estadoValido
    end
    #
    def seleccionarDestinoTramitacion(comboEstado)
      comboEstado.click()
      #
      indice = 0
      destinoPase = 'Tramitación'
      existeEstado = false
      estadoValido = nil
      comboEstadoActual = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.text() != nil) || (estado.text() != '')) && (estado.text() == destinoPase))
          existeEstado = true
          estadoValido = estado
          break
        end
      end
      if !(existeEstado)
        puts "seleccionarDestinoTramitacion(comboEstado) - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return false
      end
      # Se selecciona el estado destino
      estadoValido.click()
      return true
      #
    end
    # NUEVA LÓGICA DE PASES CON CAMBIO DE ESTADO
    #
    # Estado destino: Inciación
    #
    def paseDestinoIniciacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoIniciacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # 
    def paseDestinoIniciacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Tramitación
    #
    def paseDestinoTramitacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoTramitacionDestinoSector(motivoPase)
      puts "Inicio: paseDestinoTramitacionDestinoSector(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      puts "Fin: paseDestinoTramitacionDestinoSector(motivoPase)"
      return true
    end
    #
    def paseDestinoTramitacionDestinoMesaDeLaReparticion(motivoPase)
      puts "Inicio: paseDestinoTramitacionDestinoMesaDeLaReparticion(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      puts "Fin: paseDestinoTramitacionDestinoMesaDeLaReparticion(motivoPase)"
      return true
    end
    #
    # Estado destino: Comunicación
    #
    def paseDestinoComunicacionDestinoUsuario(motivoPase)
      puts "Inicio: paseDestinoComunicacionDestinoUsuario(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      puts "Fin: paseDestinoComunicacionDestinoUsuario(motivoPase)"
      return true
    end
    #
    def paseDestinoComunicacionDestinoSector(motivoPase)
      puts "Inicio: paseDestinoComunicacionDestinoSector(motivoPase)"
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      puts "Fin: paseDestinoComunicacionDestinoSector(motivoPase)"
      return true
    end
    #
    def paseDestinoComunicacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Ejecución
    #
    # # Pase a usuario con estado Ejecución
    def paseDestinoEjecucionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Sector de la repartición con estado Ejecución
    def paseDestinoEjecucionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Mesa de la repartición con estado Ejecución
    def paseDestinoEjecucionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Subsanación
    #
    # Pase a usuario con estado subsanación
    def paseDestinoSubsanacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a sector con estado subsanación
    def paseDestinoSubsanacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Mesa de la repartición con estado subsanación
    def paseDestinoSubsanacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Pase a Guarda Temporal
    def paseDestinoGuardaTemporalFinal(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      sleep 1
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoGuardaTemporal())
        self.presionarRealizarPase()
        # Click en el cartel de aviso
        self.presionarBotonTD('Si','z-button-cm')
      else
        return false
      end
      return true
    end
    #

    # Luego evaluar la posibilidad de quietar estos métodos con hardcode por JSON
    def estadosValidosPaseInciacion()
      estadosValidos = ['Iniciación']
      return estadosValidos
    end
    #
    def estadosValidosPaseTramitacion()
      estadosValidos = ['Iniciación', 'Tramitación', 'Subsanación']
      return estadosValidos
    end
    #
    def estadosValidosPaseComunicacion()
      estadosValidos = ['Tramitación', 'Comunicación']
      return estadosValidos
    end
    #
    def estadosValidosPaseEjecucion()
      estadosValidos = ['Comunicación', 'Ejecución']
      return estadosValidos
    end
    #
    def estadosValidosPaseSubsanacion()
      estadosValidos = ['Iniciación', 'Tramitación', 'Ejecución' , 'Subsanación']
      return estadosValidos
    end
    #
    def estadosValidosPaseGuardaTemporal()
      estadosValidos = ['Iniciación', 'Tramitación', 'Comunicación' , 'Ejecución' , 'Subsanación']
      return estadosValidos
    end
    # VINCULACIÓN DE DOCUMENTOS A UN EXPEDIENTE
    # Se utiliza para vincular documentos GEDO a un Expediente
    def vincularDocumentoPorNumeroSADE()
      # Recarga los JSON en caso de que se hayan actualizado
      puts "Inicio: vincularDocumentoPorNumeroSADE()"
      self.parseJSON()
      botoneraEE = self.getBotoneraEEParseo()
      datosExpediente = self.getDatosExpediente()
      documentosParaVincular = datosExpediente['expediente']['documentos']
      #puts documentosParaVincular
      parseGEDOSADE = self.parseGEDOSADE(documentosParaVincular)
      #indice = 0
      parseGEDOSADE.each do |documento|
        # Número SADE
        self.cargarNumeracionSADE(documento)
        boton = self.presionarBotonImagen(botoneraEE['botonera']['tabDocumento']['VincularDocumento'], 0)
        sleep 1
        #indice = indice + 1
      end
      puts "Fin: vincularDocumentoPorNumeroSADE()"
    end
    #
    def cargarTipoSADE(documento)
      # Espera a que se cargue correctamente el componente a utilizar
      Watir::Wait.until {self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].exists?}
      #
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set documento[0] # Tipo
      #self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur # Se comenta ver funcionamiento de ESPECIAL
      #sleep 2
      Watir::Wait.until {self.getBrowser().is(:class => 'z-bandbox-btn')[0].exists?} # alternativa a sleep 2
      #
      self.getBrowser().is(:class => 'z-bandbox-btn')[0].click # Bandbox tipo
      self.seleccionarTipoDocumentoSADE(documento)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur
    end
    #
    def cargarAnioSADE(documento)
      self.getBrowser().text_fields(:class => 'z-intbox')[0].set documento[1] # Año
      self.getBrowser().text_fields(:class => 'z-intbox')[0].fire_event :blur
    end
    #
    def cargarNumeroSADE(documento)
      self.getBrowser().text_fields(:class => 'z-intbox')[1].set documento[2] # Número
      self.getBrowser().text_fields(:class => 'z-intbox')[1].fire_event :blur
    end
    #
    def cargarReparticionSADE(documento)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[1].set documento[4] # Repartición
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[1].fire_event :blur
    end
    #
    def cargarNumeracionSADE(documento)
      self.cargarTipoSADE(documento)
      self.cargarAnioSADE(documento)
      self.cargarNumeroSADE(documento)
      self.cargarReparticionSADE(documento)
    end
    # Se utiliza para vincular documentos GEDO a un Expediente mediante su número especial
    def vincularDocumentoPorNumeroEspecial()
      # Recarga los JSON en caso de que se hayan actualizado
      puts "Inicio: vincularDocumentoPorNumeroEspecial()"
      self.parseJSON()
      botoneraEE = self.getBotoneraEEParseo()
      datosExpediente = self.getDatosExpediente()
      documentosParaVincular = datosExpediente['expediente']['documentos']
      #puts documentosParaVincular
      parseGEDOEspecial = self.parseGEDOEspecial(documentosParaVincular)
      #indice = 0
      parseGEDOEspecial.each do |documento|
        # Número SADE
        self.cargarNumeracionEspecial(documento)
        boton = self.presionarBotonImagen(botoneraEE['botonera']['tabDocumento']['VincularDocumento'], 0)
        sleep 1
        #indice = indice + 1
      end
      puts "Fin: vincularDocumentoPorNumeroEspecial()"
    end
    #
    def cargarTipoEspecial(documento)
      tipoEspecial = documento[0]
      # Espera a que se cargue correctamente el componente a utilizar
      Watir::Wait.until {self.getBrowser().text_fields(:class => 'z-bandbox-inp')[2].exists?}
      #
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[2].set tipoEspecial # Tipo
      #sleep 2
      Watir::Wait.until {self.getBrowser().is(:class => 'z-bandbox-btn')[2].exists?} # alternativa a sleep 2
      self.getBrowser().is(:class => 'z-bandbox-btn')[2].click # Bandbox tipo      
      self.seleccionarTipoDocumentoEspecial(tipoEspecial)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[2].fire_event :blur
    end
    # Recorre el árbol de tipos de documento especial para seleccionar el indicado
    def seleccionarTipoDocumentoEspecial(tipoEspecial)
      arbolTipos = self.getBrowser().spans(:class => 'z-tree-ico z-tree-root-close')
      arbolTipos = self.getBrowser().text_fields(:class => 'z-treerow')
      posicionArbol = arbolTipos.size() + 1
      indiceArbol = posicionArbol
      indiceMinimo = 0
      # Recorre el árbol de tipos de documento de manera inversa y abre todas las ramas
      puts "posicionArbol:: #{posicionArbol} ::: indiceMinimo:: #{indiceMinimo}"
      while ((posicionArbol != 0) && (indiceArbol >= indiceMinimo)) do
        begin
          indiceArbol = indiceArbol - 1
          arbolTipos[posicionArbol].click # Abre el árbol de tipos
          ##acronimos =           
        rescue
          puts "ERROR al dar click en seleccionarTipoDocumentoEspecial(), continua el procesamiento."
        end
      end
      #
      arbolTipos.each do |itemArbol|
        begin
          itemArbol.click
        rescue
          puts "ERROR al dar click en seleccionarTipoDocumentoEspecial(), continua el procesamiento."
        end
      end
      #
      divsAcronimos = self.getBrowser().divs(:class => 'z-tree-ico z-tree-root-close')
      #posiciondivsTipos = divsAcronimos.size()
      existeTipo = false
      divsAcronimos.each do |acronimo|
        begin
          if (acronimo.text() == tipoEspecial)          
            acronimo.click
            existeTipo = true
            break
          end
        rescue
          puts "ERROR al dar click en el acrónimo en seleccionarTipoDocumentoEspecial(), continua el procesamiento."
        end
      end
      #
      return existeTipo      
    end
    # Recorre el árbol de tipos de documento para seleccionar el indicado
    def seleccionarTipoDocumentoSADE(tipoDocumento)
      ###
      arbolTipos = self.getBrowser().divs(:class => 'z-treecell-cnt z-overflow-hidden')
      ###
      arbolTipos.each do |itemArbol|
        begin
          if itemArbol.text == tipoDocumento
            itemArbol.click
            break
          end
        rescue
          puts "ERROR al dar click en seleccionarTipoDocumento(), continua el procesamiento - arbolTipos.each."
        end
      end
      # NUEVOS CAMBIOS
      divsAcronimos = self.getBrowser().divs(:class => 'z-tree-ico z-tree-root-close')
      #posiciondivsTipos = divsAcronimos.size()
      existeTipo = false
      divsAcronimos.each do |acronimo|
        begin
          if (acronimo.text() == tipoDocumento)          
            acronimo.click
            existeTipo = true
            break
          end
        rescue
          puts "ERROR al dar click en el acrónimo en seleccionarTipoDocumento(), continua el procesamiento. - divsAcronimos.each"
        end
      end
      #
      return existeTipo      
    end
    #
    def cargarAnioEspecial(documento)
      self.getBrowser().text_fields(:class => 'z-intbox')[2].set documento[1] # Año
      self.getBrowser().text_fields(:class => 'z-intbox')[2].fire_event :blur
    end
    #
    def cargarNumeroEspecial(documento)
      self.getBrowser().text_fields(:class => 'z-intbox')[3].set documento[2] # Número
      self.getBrowser().text_fields(:class => 'z-intbox')[3].fire_event :blur
    end
    #
    def cargarReparticionEspecial(documento)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[3].set documento[3] # Repartición
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[3].fire_event :blur
    end
    #
    def cargarNumeracionEspecial(documento)
      self.cargarTipoEspecial(documento)
      self.cargarAnioEspecial(documento)
      self.cargarNumeroEspecial(documento)
      self.cargarReparticionEspecial(documento)
    end
    #
    # Se parsean los documentos GEDO para dividir en los distintos campos:
    # Ejemplo: "numeroSADE": "IF-2016-00009614-   -DGAYDRH"
    # Se divide en: 'IF', '2016', '00009614','   ', 'DGAYDRH'
    def parseGEDOSADE(documentosParaVincular)
      arrayDocumentosParaVincularSplit = []
      listaDocumentosParaVincular = documentosParaVincular['numeroSADE']
      indice = 0
      listaDocumentosParaVincular.each do |documento|
        documentoSplit = documento.split('-')
        arrayDocumentosParaVincularSplit[indice] = documentoSplit
        indice = indice + 1
      end
      return arrayDocumentosParaVincularSplit
    end
    #
    # Se parsean los documentos GEDO para dividir en los distintos campos:
    # Ejemplo: "numeroEspecial": "EITEM-2016-3-DGAYDRH"
    # Se divide en: 'EITEM', '2016', '3', 'DGAYDRH'
    def parseGEDOEspecial(documentosParaVincular)
      arrayDocumentosParaVincularSplit = []
      listaDocumentosParaVincular = documentosParaVincular['numeroEspecial']
      indice = 0
      listaDocumentosParaVincular.each do |documento|
        documentoSplit = documento.split('-')
        arrayDocumentosParaVincularSplit[indice] = documentoSplit
        indice = indice + 1
      end
      return arrayDocumentosParaVincularSplit
    end
    # Asociar uno o más expedientes a otro expediente cabecera
    def asociarExpediente()
      # Recarga los JSON en caso de que se hayan actualizado
      self.parseJSON()
      botoneraEE = self.getBotoneraEEParseo()
      datosExpediente = self.getDatosExpediente()
      #claseBotonSpanAsociarExp = 'z-label'
      claseBotonTDOK = 'z-button-cm'
      textoBotonTDOK = 'OK'
      expedientesParaVincular = datosExpediente['expediente']['asociarExpediente']
      # TAB Asociar Expediente
      sleep 2
      parseAsociarEE = self.parseEE(expedientesParaVincular, botoneraEE)
      self.presionarTabAsociarExpediente(botoneraEE)
      indice = 0
      parseAsociarEE.each do |expediente|
        # Número SADE
        self.cargarNumeracionAsociarExpediente(expediente)
        boton = self.presionarBotonImagen(botoneraEE['botonera']['tabAsociarExpediente']['BuscarExpediente'], 0)
        sleep 1
        self.presionarBotonAsociarExpediente(botoneraEE)
        sleep 1
        self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
        indice = indice + 1
      end
    end
    # Tramitación conjunta de expedientes
    def tramitacionConjunta()
      # Recarga los JSON en caso de que se hayan actualizado
      self.parseJSON()
      botoneraEE = self.getBotoneraEEParseo()
      datosExpediente = self.getDatosExpediente()
      #claseBotonSpanAsociarExp = 'z-label'
      claseBotonTDOK = 'z-button-cm'
      textoBotonTDOK = 'OK'
      expedientesParaTC = datosExpediente['expediente']['tramitacionConjunta']
      # TAB Asociar Expediente
      sleep 2
      parseTCEE = self.parseEE(expedientesParaTC, botoneraEE)
      self.presionarTabTramitacionConjunta(botoneraEE)
      indice = 0
      parseTCEE.each do |expediente|
        # Número SADE
        self.cargarNumeracionTramitacionConjunta(expediente)
        boton = self.presionarBotonImagen(botoneraEE['botonera']['tabTramitacionConjunta']['BuscarExpediente'], 0)
        sleep 1
        #self.presionarBotonAsociarExpediente(botoneraEE)
        #sleep 1
        self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
        indice = indice + 1
      end
      self.presionarBotonImagen(botoneraEE['botonera']['tabTramitacionConjunta']['ConfirmarTramitacionConjunta'], 0)
      #sleep 3
      Watir::Wait.until {(self.getBrowser().text.include? ' Confirmando Tramitación Conjunta...')}
      self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
    end
    #
    # Fusión de expedientes
    def fusion()
      # Recarga los JSON en caso de que se hayan actualizado
      self.parseJSON()
      botoneraEE = self.getBotoneraEEParseo()
      datosExpediente = self.getDatosExpediente()
      #claseBotonSpanAsociarExp = 'z-label'
      claseBotonTDOK = 'z-button-cm'
      textoBotonTDOK = 'OK'
      textoBotonTDSI = 'Si'
      textoConfirmacionFusion = 'La operación de fusionado no puede deshacerse. ¿Está seguro?'
      textoFusionConfirmada ='Se ha confirmado la fusión de los expedientes.'
      procesando = 'Procesando'
      expedientesParaFusion = datosExpediente['expediente']['fusion']
      # TAB Asociar Expediente
      sleep 2
      parseFusionEE = self.parseEE(expedientesParaFusion, botoneraEE)
      self.presionarTabFusion(botoneraEE)
      indice = 0
      parseFusionEE.each do |expediente|
        # Número SADE
        self.cargarNumeracionFusion(expediente)
        boton = self.presionarBotonImagen(botoneraEE['botonera']['tabFusion']['BuscarExpediente'], 0)
        sleep 1
        self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
        indice = indice + 1
      end
      self.presionarBotonImagen(botoneraEE['botonera']['tabFusion']['ConfirmarFusion'], 0)
      Watir::Wait.until {(self.getBrowser().text.include? textoConfirmacionFusion)}
      self.presionarBotonTD(textoBotonTDSI, claseBotonTDOK)
      Watir::Wait.until {(self.getBrowser().text.include? procesando)}
      Watir::Wait.until {(self.getBrowser().text.include? textoFusionConfirmada)}
      self.presionarBotonTD(textoBotonTDOK, claseBotonTDOK)
    end
    #
    ############################ TABS ############################
    # Presionar el TAB para acceder a "Asociar Expediente"
    def presionarTabAsociarExpediente(botoneraEE)
      claseTabSpanAsociarExp = 'z-tab-text'
      sleep 1
      self.presionarBotonSpan(botoneraEE['botonera']['tabAsociarExpediente']['asociarexpedientes'], claseTabSpanAsociarExp)
    end
    #
    # Presionar el TAB para acceder a "Tramitación Conjunta"
    def presionarTabTramitacionConjunta(botoneraEE)
      # Se parsea el String para remplazar los caracteres con acento
      nombreBoton = self.getCoder().decode(botoneraEE['botonera']['tabTramitacionConjunta']['tramitacionConjunta'])
      claseTabSpanTramitacionConjunta = 'z-tab-text'
      sleep 1
      self.presionarBotonSpan(nombreBoton, claseTabSpanTramitacionConjunta)
    end
    # Presionar el TAB para acceder a "Tramitación Conjunta"
    def presionarTabFusion(botoneraEE)
      # Se parsea el String para remplazar los caracteres con acento
      nombreBoton = self.getCoder().decode(botoneraEE['botonera']['tabFusion']['fusion'])
      claseTabSpanFusion = 'z-tab-text'
      sleep 1
      self.presionarBotonSpan(nombreBoton, claseTabSpanFusion)
    end
    ############################ TABS ############################
    #
    # Presionar el botón de asociar expediente dentro de solapa "Asociar Expediente"
    def presionarBotonAsociarExpediente(botoneraEE)
      claseBotonSpanAsociarExp = 'z-label'
      #self.presionarBotonSpan(botoneraEE['botonera']['tabAsociarExpediente']['asociarexpedientes'], claseTabSpanAsociarExp)
      self.presionarBotonSpan(botoneraEE['botonera']['tabAsociarExpediente']['Asociar Exp.'], claseBotonSpanAsociarExp)
    end
    #
    # Presionar el botón de desasociar expediente dentro de solapa "Asociar Expediente"
    def presionarBotonDesasociarExpediente(botoneraEE)
      claseTabSpanAsociarExp = 'z-tab-text'
      self.presionarBotonSpan(botoneraEE['botonera']['tabAsociarExpediente']['Desasociar'], claseTabSpanAsociarExp)
    end
    # Se carga el número de Expediente en la solapa Asociar Expediente
    def cargarNumeracionAsociarExpediente(expediente)
      self.seleccionarTipoAsociarExpediente(expediente)
      self.cargarAnioAsociarExpediente(expediente)
      self.cargarNumeroAsociarExpediente(expediente)
      self.cargarReparticionAsociarExpediente(expediente)
    end
    # Se carga el número de Expediente en la solapa Asociar Expediente
    def cargarNumeracionTramitacionConjunta(expediente)
      self.seleccionarTipoTramitacionConjunta(expediente)
      self.cargarAnioTramitacionConjunta(expediente)
      self.cargarNumeroTramitacionConjunta(expediente)
      self.cargarReparticionTramitacionConjunta(expediente)
    end
    # Se carga el número de Expediente en la solapa Fusión
    def cargarNumeracionFusion(expediente)
      self.seleccionarTipoFusion(expediente)
      self.cargarAnioFusion(expediente)
      self.cargarNumeroFusion(expediente)
      self.cargarReparticionFusion(expediente)
    end
    #
    # Se parsean los expedientes para dividir en los distintos campos:
    # Ejemplo: "numeroSADE": "EX-2016-00009578-   -MGEYA-DGAYDRH"
    # Se divide en: 'EX', '2016', '00009578', '   ', 'MGEYA', 'DGAYDRH'
    def parseEE(expedientesParaAsociar, botoneraEE)
      #botonAsociar = botoneraEE['botonera']['tabAsociarExpediente']['asociarexpedientes']
      arrayExpedientesParaVincularSplit = []
      listaExpedientesParaVincular = expedientesParaAsociar['numeroExpediente']
      indice = 0
      listaExpedientesParaVincular.each do |expediente|
        expedienteSplit = expediente.split('-')
        arrayExpedientesParaVincularSplit[indice] = expedienteSplit
        #self.presionarBotonImagen(botonAsociar, 0)
        indice = indice + 1
      end
      return arrayExpedientesParaVincularSplit
    end
    #
    # Selecciona el tipo de actuación del expediente para la solapa Asociar Expiente
    def seleccionarTipoAsociarExpediente(expediente)
      # Espera a que se cargue correctamente el componente a utilizar
      #Watir::Wait.until {self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].exists?}
      #self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set expediente[0] # Tipo
      #Watir::Wait.until {self.getBrowser().is(:class => 'z-bandbox-btn')[0].exists?} # alternativa a sleep 2
      #self.getBrowser().is(:class => 'z-bandbox-btn')[0].click # Bandbox tipo
      #self.seleccionarTipoDocumentoSADE(expediente)
      #self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur
    end
    #
    def cargarAnioAsociarExpediente(expediente)
      self.getBrowser().text_fields(:class => 'z-intbox')[4].set expediente[1] # Año
      self.getBrowser().text_fields(:class => 'z-intbox')[4].fire_event :blur
    end
    #
    def cargarNumeroAsociarExpediente(expediente)
      self.getBrowser().text_fields(:class => 'z-intbox')[5].set expediente[2] # Número
      self.getBrowser().text_fields(:class => 'z-intbox')[5].fire_event :blur
    end
    #
    def cargarReparticionAsociarExpediente(expediente)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[4].set expediente[5] # Repartición
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[4].fire_event :blur
    end
    #
    # Selecciona el tipo de actuación del expediente para la solapa Fusión
    def seleccionarTipoFusion(expediente)
      # Espera a que se cargue correctamente el componente a utilizar
      #Watir::Wait.until {self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].exists?}
      #self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set expediente[0] # Tipo
      #Watir::Wait.until {self.getBrowser().is(:class => 'z-bandbox-btn')[0].exists?} # alternativa a sleep 2
      #self.getBrowser().is(:class => 'z-bandbox-btn')[0].click # Bandbox tipo
      #self.seleccionarTipoDocumentoSADE(expediente)
      #self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur
    end
    #
    def cargarAnioFusion(expediente)
      self.getBrowser().text_fields(:class => 'z-intbox')[6].set expediente[1] # Año
      self.getBrowser().text_fields(:class => 'z-intbox')[6].fire_event :blur
    end
    #
    def cargarNumeroFusion(expediente)
      self.getBrowser().text_fields(:class => 'z-intbox')[7].set expediente[2] # Número
      self.getBrowser().text_fields(:class => 'z-intbox')[7].fire_event :blur
    end
    #
    def cargarReparticionFusion(expediente)
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].set expediente[5] # Repartición
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].fire_event :blur
    end
    #
    def esperarTexto(texto)
      Watir::Wait.until {self.getBrowser().text.include? texto}
    end
    #
  end
###############################################################################