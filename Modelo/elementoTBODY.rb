  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  class ElementoTBODY < ElementosHTML
    attr_accessor

    # Métodos
    def esperarObtenerElemento(clase, posicion)
      #puts "esperarObtenerElemento(clase, posicion)"
      Watir::Wait.until { self.getBrowser().tbodys(:class => clase)[posicion].exists?}
      self.setSiMismo(self.getBrowser().tbodys(:class => clase)[posicion])
      #puts "esperarObtenerElemento(clase, posicion)"
      return self.getSiMismo()
    end
    #
    def retornarElementosInputContenidos(clase)
      #self.getSiMismo().each do |elementoInput|
      #
      #end
      return self.getSiMismo().text_fields(:class => clase)
    end
    #
    def retornarElementosIContenidos(clase)
      #self.getSiMismo().each do |elementoInput|
      #
      #end
      return self.getSiMismo().is(:class => clase)
    end
  end