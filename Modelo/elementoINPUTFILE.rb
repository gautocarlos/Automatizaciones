  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementoINPUT.rb'
  class ElementoINPUTFILE < ElementoINPUT
    attr_accessor

    # Métodos
    #
    #
    # Se completa el campo de texto en base a la posición y clase del elemento
    def subirArchivoPorNombreElemento(rutaArchivo, posicion, nombreElemento)
      self.getBrowser().file_fields(:name => nombreElemento)[posicion].set(rutaArchivo)
    end        
  end