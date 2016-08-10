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
    def initialize()
      
    end
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
    #
    def presionarAltaUsuario()
      posicion = 2
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
    def completarDatosUsuario()
      claseTbody = Z_ROWS
      claseInputsSimples = Z_TEXTBOX
      claseBanbox = Z_TEXTBOX
      posicionTbody = 8
      # TO DO:  Debería tomar la clase y la posición del botón mediante algún tipo de parametrización
      tbody = self.getElementosHTMLFactory().getElemento('tbody')
      tbody.esperarObtenerElemento(claseTbody, posicionTbody)
      listaInputsZ_textbox = tbody.retornarElementosInputContenidos(claseInputsSimples)
      inputsBandbox = tbody.retornarElementosInputContenidos(claseBanbox)
      texto = 'texto'
      posicionInput = 1
      self.getElementosHTMLFactory().getElemento('input').esperarCompletarTextoDelista(texto, posicionInput, listaInputsZ_textbox)
    end
  end