  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  require './login.rb'
  require './elementosHTMLFactory.rb'
  require './aplicativo.rb'
  require '../constantes/constantesEU.rb'
  #require '../constantes.rb'
  class EscritorioUnico < Aplicativo
    attr_accessor
      :jsonDatosUsuario
    # Getters
    def getJsonDatosUsuario()
      return @jsonDatosUsuario
    end
    # Setters
    def setJsonDatosUsuario(jsonDatosUsuario)
      @jsonDatosUsuario = jsonDatosUsuario
    end
    # Métodos
    # TABS
    def presionarTabAdministracion()
      #textoBoton = TABADMINISTRACION
      textoBoton = self.getCoder().decode(TAB_ADMINISTRACION)
      clase = Z_TAB_TEXT
      self.getElementosHTMLFactory().getElemento('span').presionarBotonSpan(textoBoton, clase)
    end
    #
    def presionarTabDatosPesonales(textoBoton, clase)

    end
    # Solapa: REPARTICIONES, botón: Alta Repartición
    def presionarTabUsuarios()
      #textoBoton = TABADMINISTRACION
      textoBoton = self.getCoder().decode(TAB_USUARIOS)
      clase = Z_TAB_TEXT
      self.getElementosHTMLFactory().getElemento('span').presionarBotonSpan(textoBoton, clase)
    end
    # Solapa: REPARTICIONES, botón: Alta Repartición
    def presionarTabReparticiones()
      #textoBoton = TABADMINISTRACION
      textoBoton = self.getCoder().decode(TAB_REPARTICIONES)
      clase = Z_TAB_TEXT
      self.getElementosHTMLFactory().getElemento('span').presionarBotonSpan(textoBoton, clase)
    end
    # Solapa: USUARIOS, botón: Alta Usuario
    def presionarAltaUsuario()
      posicion = 2
      #clase = Z_TOOLBARBUTTON_CNT
      clase = Z_TOOLBARBUTTON_CNT
      nombreBoton = BOTON_ALTA_USUARIO
      #indiceFrame = 0
      indiceFrame = nil
      # TO DO:  Debería tomar la clase y la posición del botón mediante algún tipo de parametrización
      #self.getElementosHTMLFactory().getElemento('div').esperarRealizarClick(posicion, clase)
      #self.getElementosHTMLFactory().getElemento('div').esperarRealizarClickEsperar(posicion, clase)
      # Nuevo cambio click mediante el acceso a una imagen
      self.getElementosHTMLFactory().getElemento('imagen').presionarBotonImagen(nombreBoton, indiceFrame, clase)
    end
    # Solapa: REPARTICIONES, botón: Alta Usuario
    def presionarAltaReparticion()
      posicion = 4
      clase = Z_TOOLBARBUTTON_CNT
      # TO DO:  Debería tomar la clase y la posición del botón mediante algún tipo de parametrización
      self.getElementosHTMLFactory().getElemento('div').esperarRealizarClick(posicion, clase)
    end
    # Se obtienen los datos desde JSON de altaUsuario.json
    # 1 = Nombre
    # 2 = Apellido
    # 3 = Nombre de usuario
    # 4 = Mail
    # 5 = Legajo
    # Se recibe el parámetro: posicion, con el motivo de en el eventual caso de recibir una lista de usuarios
    # En cada iteración de la invocación de este método se puedan procesar diferentes datos de alta
    def completarDatosUsuario(posicion)
      claseTbody = Z_ROWS
      claseInputsSimples = Z_TEXTBOX
      claseBanbox = Z_BANDBOX
      posicionTbody = 8
      # TO DO:  Debería tomar la clase y la posición del botón mediante algún tipo de parametrización
      begin
        tbody = self.getElementosHTMLFactory().getElemento('tbody')
        tbody.esperarObtenerElemento(claseTbody, posicionTbody)
        listaInputsZ_textbox = tbody.retornarElementosInputContenidos(claseInputsSimples)
        listaBandboxes = tbody.retornarElementosIContenidos(claseBanbox)
        self.completarDatosUsuarioDesdeJson(posicion, listaInputsZ_textbox, listaBandboxes)
      rescue
        puts "Error en: completarDatosUsuario(posicion) : posicion: #{posicion}"
      end
    end
    #
    def completarDatosUsuarioDesdeJson(posicion, listaInputs, listaBandboxes)
      #texto = 'texto'
      #posicionInput = 1
      # ANALIZAR EN QUE MOMENTO SE SETEA EL JSON DE DATOS DE USUARIO
      jsonInputsAltaUsuario = self.getParserArchivosJson().getInputsAltaUsuarioJson(posicion)
      jsonBandboxesAltaUsuario = self.getParserArchivosJson().getBandboxesAltaUsuarioJson(posicion)
      # Iterar los valores del json
      posicionCampo = 1
      indiceElemento = 0 # Indice valor del campo
      # Completar inputs básicos
      jsonInputsAltaUsuario.each do |datosUsuario|
        self.getElementosHTMLFactory().getElemento('input').esperarCompletarTextoDelista(datosUsuario, posicionCampo, listaInputs)
        posicionCampo = posicionCampo + 1
      end
      # Completar bandboxes
      posicionCampo = 1
      jsonBandboxesAltaUsuario.each do |datosUsuario|
        #self.getElementosHTMLFactory().getElemento('i').esperarCompletarBandboxesDeLista(datosUsuario, posicionCampo, listaBandboxes)
        #self.getElementosHTMLFactory().getElemento('i').esperarCompletarBandboxesDeLista(datosUsuario, posicionCampo, listaBandboxes, self.getElementosHTMLFactory())
        self.getElementosHTMLFactory().getElemento('ElementoBandbox').esperarCompletarBandboxesDeLista(datosUsuario, posicionCampo, listaBandboxes, self.getElementosHTMLFactory())        
        posicionCampo = posicionCampo + 1
      end
    end
  end