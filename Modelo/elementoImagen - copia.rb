  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  class ElementoImagen < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoImagen y Deprecar
    # 
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonImagen(srcBoton, indiceFrame, clase)
      #Obtener todas imagenes que sean botones
      #Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      #botonesImagenes = (self.getBrowser().divs(:class => 'z-window-highlighted-cnt'))[indiceFrame].images
      #clase = 'z-window-highlighted-cnt' # HARDCODE
      #Watir::Wait.until { (self.getBrowser().div(:class => clase)).exists?}
      # Cambio
      Watir::Wait.until { (self.getBrowser().div(:class => clase)).exists?}
      # Cambio
      if (indiceFrame == nil)
        botonesImagenes = self.getBrowser().img(:src => srcBoton)
      else  
        #botonesImagenes = (self.getBrowser().divs(:class => clase))[indiceFrame].images
        botonesImagenes = (self.getBrowser().divs(:class => clase))[indiceFrame].imgs
      end
      #
      puts "botonesImagenes:: #{botonesImagenes}"
      #
      botonPresionado = nil
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        #
        puts "rutaImagenSplit:: #{rutaImagenSplit}"
        #
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == srcBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              botonPresionado = boton
              return botonPresionado
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
      #return botonPresionado
      return false
    end
    #
    #        
  end