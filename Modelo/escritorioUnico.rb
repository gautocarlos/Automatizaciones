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
    # Métodos
    #
    def presionarTabAdministracion()
      #textoBoton = TABADMINISTRACION
      textoBoton = self.getCoder().decode(TABADMINISTRACION)
      clase = CLASE_Z_TAB_TEXT
      self.getElementosHTMLFactory().getElemento('span').presionarBotonSpan(textoBoton, clase)
    end
    #
    def presionarTabDatosPesonales(textoBoton, clase)

    end
    #        
  end