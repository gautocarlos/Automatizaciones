  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoLink < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoLink y Deprecar
    # 
    def presionarBotonLink(textoBoton, clase)
      botonera = self.getBrowser().links(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          return true
        end
      end
      return false
    end
    #        
  end