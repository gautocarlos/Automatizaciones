  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoINPUT < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se completa el campo de texto en base a la posición y clase del elemento
    def completarTexto(texto, clase)
      #Watir::Wait.until { self.getBrowser().fieldset(:class => clase)[posicion].exists?}
      #Watir::Wait.until { self.getBrowser().fieldset(:class => clase).exists?}
      self.getBrowser().fieldset(:class => clase).set texto
      self.getBrowser().fieldset(:class => 'z-textbox').fire_event :blur
    end
    #
    def completarTexto(texto, clase, posicion)
      #Watir::Wait.until { self.getBrowser().fieldset(:class => clase)[posicion].exists?}
      #Watir::Wait.until { self.getBrowser().fieldset(:class => clase).exists?}
      self.getBrowser().fieldset(:class => clase)[posicion].set texto
      self.getBrowser().fieldset(:class => 'z-textbox')[posicion].fire_event :blur
    end
    #
    #
  end