  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  require './login.rb'
  require './elementosHTMLFactory.rb'
  #require '../constantes.rb'
  class Aplicativo
    attr_accessor
      :browser
      :elementosHTMLFactory
      :coder
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
    # Métodos
    # Ingreso a un módulo
    def ingresoSistema(rutaArchivoConfiguracion, sistema)
      login = Login.new(rutaArchivoConfiguracion, sistema)
      login.ingresar()
      browser = login.getBrowser()
      self.setBrowser(browser)
      self.setElementosHTMLFactory(ElementosHTMLFactory.new(self.getBrowser()))
      self.setCoder(HTMLEntities.new)
      # Se debería setear el lugar para el logueo # TO DO, posiblemente sea recomendable que lo implemente cada módulo
    end
  end