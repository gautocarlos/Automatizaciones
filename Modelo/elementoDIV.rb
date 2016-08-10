  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoDIV < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se realiza click sobre un DIV según su clase y su posición
    def realizarClick(posicion, clase)
      self.getBrowser().divs(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un DIV según su clase y su posición
    def esperarRealizarClick(posicion, clase)
      begin
        Watir::Wait.until { self.getBrowser().divs(:class => clase)[posicion].exists?}
        self.getBrowser().divs(:class => clase)[posicion].click
      rescue
        puts "Error al realizar la espera en: esperarRealizarClick(posicion, clase)"
      end
    end
    #
    # Se realiza click sobre un DIV según su clase y su posición
    def realizarClickEsperar(posicion, clase)
      begin
        self.getBrowser().divs(:class => clase)[posicion].click
        self.getBrowser().divs(:class => clase)[posicion].wait_while_present
      rescue
        puts "Error al realizar la espera en: realizarClickEsperar(posicion, clase)"
      end
    end
    # Se realiza click sobre un DIV según su clase y su posición
    def esperarRealizarClickEsperar(posicion, clase)
      begin
        Watir::Wait.until { self.getBrowser().divs(:class => clase)[posicion].exists?}
        self.getBrowser().divs(:class => clase)[posicion].click
        self.getBrowser().divs(:class => clase)[posicion].wait_while_present
      rescue
        puts "Error al realizar la espera en: esperarRealizarClickEsperar(posicion, clase)"
      end
    end
    # Retorna las imagenes contenidas en un div en base a la clase que posea
    def obtenerImagenesPorClase(clase)
      return self.getBrowser().div(:class => clase).images
    end
  end