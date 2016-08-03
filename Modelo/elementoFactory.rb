  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require 'elementosHTML'
  # Objetos a fabricar
  require 'elementoButon'
  require 'elementoDIV'
  require 'elementoFieldset'
  #require '../constantes.rb'
  # DEPRECADO
  class ElementoFactory
    attr_accessor

    # Métodos
    # Quitar HARDCODE
    def getElemento(elemento)
      # ElementoButon
      div = 'DIV'
      if (elementoButon.upcase == 'BUTTON'.downcase)
        return ElementoButon.new()
      end
      # ElementoDIV
      if (elementoButon.upcase == div.downcase)
        return ElementoDIV.new()
      end
      # ElementoFieldSet
      if (elementoButon.upcase == 'FieldSet'.downcase)
        return ElementoFieldSet.new()
      end
    end
    #        
  end