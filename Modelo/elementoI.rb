  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require './elementosHTMLFactory.rb'
  #require '../constantes.rb'
  class ElementoI < ElementosHTML
    attr_accessor

    # Métodos
    def realizarClick(clase)
        self.getBrowser().i(:class => clase).click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClick(posicion, clase)
      self.getBrowser().is(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClick(posicion, clase)
      Watir::Wait.until { self.getBrowser().is(:class => clase)[posicion].exists?}
      self.getBrowser().is(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClickEsperar(posicion, clase)
      self.getBrowser().is(:class => clase)[posicion].click
      self.getBrowser().is(:class => clase)[posicion].wait_while_present
    end
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClickEsperar(posicion, clase)
      Watir::Wait.until { self.getBrowser().is(:class => clase)[posicion].exists?}
      self.getBrowser().is(:class => clase)[posicion].click
      self.getBrowser().is(:class => clase)[posicion].wait_while_present
    end
    #
    def esperarCompletarBandboxesDelista(texto, posicion, lista)
      begin
        puts "texto :: #{texto}"
        puts "posicion :: #{posicion}"
        puts "lista :: #{lista}"
        Watir::Wait.until { lista[posicion].exists?}
        lista[posicion].click
        self.completarBandbox(texto, posicion, lista)
      rescue
        puts "Error en: esperarCompletarBandboxesDelista(texto, posicion, lista) - Elemento no visible o no existente."
      end
    end
    #
    def completarBandbox(texto, posicion, lista)
        lista[posicion].set texto
        lista[posicion].fire_event :blur
    end
  end