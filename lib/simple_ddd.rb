require 'open-uri'
require 'pdf-reader'
require 'active_support'
require 'active_support/core_ext'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

class SimpleDDD
  autoload :Downloader,       'simple_ddd/downloader'
  autoload :ParseAnatelPDF,   'simple_ddd/parse_anatel_pdf'
  autoload :Normalizer,       'simple_ddd/normalizer'
  autoload :DownloadAndParse, 'simple_ddd/download_and_parse'
end