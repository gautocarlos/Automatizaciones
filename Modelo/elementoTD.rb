  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoTD < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Eliminar de clase expediente
    def presionarBotonTD(textoBoton, clase)
      botonera = self.getBrowser().tds(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          return true
        end
      end
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    #
    # Busca un componente TD en base a un texto y aguarda mientras esté presente el botón
    # Eliminar de clase expediente
    def presionarEsperarBotonTD(textoBoton, clase)
      botonera = self.getBrowser().tds(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          boton.wait_while_present
          return true
        end
      end
      puts ":: Botón textoBoton:: #{textoBoton} :: clase:: #{clase} no encontrado :: "
      return false
    end
    #        
  end