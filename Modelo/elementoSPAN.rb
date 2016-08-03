  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoSPAN < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoSPAN y Deprecar
    def presionarBotonSpan(textoBoton, clase)
      botonera = self.getBrowser().spans(:class => clase)
      botonera.each do |boton|
        begin 
          if (boton.text() == textoBoton)
            boton.click
            return true
          end
        rescue
          puts "ERROR al intentar :: presionarBotonSpan(textoBoton, clase) :: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} :: Posiblemente no se pueda acceder a algún elemento ::"
        end
      end
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    #
    #        
  end