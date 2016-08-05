  require 'watir-webdriver'
  require 'logger'
  #Levantar las constantes declaradas
  require '../constantes/constantesEU.rb'
  # Genera los dorectorios de logs
  #require '../0000_Directorios_GEDO.rb'
  require './escritorioUnico.rb'
  ######
  eu = EscritorioUnico.new()
  rutaArchivoConfiguracion = "../conf/configuraciones.json"
  sistema = "EU"
  eu.ingresoSistema(rutaArchivoConfiguracion, sistema)
  eu.presionarTabAdministracion()
