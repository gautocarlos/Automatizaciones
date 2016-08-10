  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  class ElementoINPUT < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se completa el campo de texto en base a la posición y clase del elemento
    def completarTexto(texto, posicion, clase)
      Watir::Wait.until { self.getBrowser().text_fields(:class => clase)[posicion].exists?}
      self.getBrowser().text_fields(:class => clase)[posicion].set texto
      self.getBrowser().text_fields(:class => clase)[posicion].fire_event :blur
    end
    #
    def esperarCompletarTextoDelista(texto, posicion, lista)
      Watir::Wait.until { lista[posicion].exists?}
      puts "esperarCompletarTextoDelista(texto, posicion, lista)"
      lista[posicion].set texto
      lista[posicion].fire_event :blur
      puts "esperarCompletarTextoDelista(texto, posicion, lista)"
    end
    #Espera a que se cargue el componente
    def esperarComponente(posicion, clase)
      Watir::Wait.until { self.getBrowser().text_fields(:class => clase)[posicion].exists?}
    end
    #Esperar mientras exista el componente
    def esperarMientrasExistaComponente(claseCampoTexto)
      #Watir::Wait.until { self.getBrowser().text_fields(:class => clase)[posicion].exists?}
      self.getBrowser().text_field(:class => claseCampoTexto).wait_while_present
    end
    #
    def obtenerInputsPorClase(clase)
      return self.getBrowser().text_fields(:class => clase)
    end
  end