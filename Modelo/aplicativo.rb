  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  require './login.rb'
  require './elementosHTMLFactory.rb'
  require './Configuracion.rb'
  #require '../constantes.rb'
  class Aplicativo
    attr_accessor
      :browser
      :elementosHTMLFactory
      :coder
      :configuracion
    # Getters
    def getBrowser()
      return @browser
    end
    def getElementosHTMLFactory()
      return @elementosHTMLFactory
    end
    def getCoder()
      return @coder
    end
    def getConfiguracion()
      return @configuracion
    end
    # Setters
    def setBrowser(browser)
      @browser = browser
    end
    def setElementosHTMLFactory(elementosHTMLFactory)
      @elementosHTMLFactory = elementosHTMLFactory
    end
    def setCoder(coder)
      @coder = coder
    end
    def setConfiguracion(configuracion)
      @configuracion = configuracion
    end
    # Métodos
    # Ingreso a un módulo
    def ingresoSistema(rutaArchivoConfiguracion, sistema)
      # Se setea el archivo de configuracion de la aplicación
      self.setConfiguracion(Configuracion.new(rutaArchivoConfiguracion)
      # Al contar con un nuevo objeto que gentiona la configuración habría que reformular la clase Login
      login = Login.new(rutaArchivoConfiguracion, sistema)
      login.ingresar()
      browser = login.getBrowser()
      self.setBrowser(browser)
      self.setElementosHTMLFactory(ElementosHTMLFactory.new(self.getBrowser()))
      self.setCoder(HTMLEntities.new)
      # Se debería setear el lugar para el logueo # TO DO, posiblemente sea recomendable que lo implemente cada módulo
    end
  end