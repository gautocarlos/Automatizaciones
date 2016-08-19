  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require './elementosHTMLFactory.rb'
  class ElementoButton < ElementosHTML
    attr_accessor

    # Métodos
    def realizarClick(clase)
        self.getBrowser().button(:class => clase).click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClick(posicion, clase)
      self.getBrowser().buttons(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClick(posicion, clase)
      Watir::Wait.until { self.getBrowser().buttons(:class => clase)[posicion].exists?}
      self.getBrowser().buttons(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClickEsperar(posicion, clase)
      self.getBrowser().buttons(:class => clase)[posicion].click
      self.getBrowser().buttons(:class => clase)[posicion].wait_while_present
    end
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClickEsperar(posicion, clase)
      Watir::Wait.until { self.getBrowser().buttons(:class => clase)[posicion].exists?}
      self.getBrowser().buttons(:class => clase)[posicion].click
      self.getBrowser().buttons(:class => clase)[posicion].wait_while_present
    end
    #
  end