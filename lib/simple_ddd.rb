require 'open-uri'
require 'pdf-reader'
require 'fileutils'
require 'json'
require 'active_support'
require 'active_support/core_ext'

lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

class SimpleDDD
  BaseDir = File.expand_path('..', File.dirname(__FILE__))
  autoload :Downloader,       'simple_ddd/downloader'
  autoload :ParseAnatelPDF,   'simple_ddd/parse_anatel_pdf'
  autoload :Normalizer,       'simple_ddd/normalizer'
  autoload :DownloadAndParse, 'simple_ddd/download_and_parse'

  def jekyll_home
    @jekyll_home ||= File.join(BaseDir,'site/brasil')
  end

  def file_name(uf = nil, city = nil)
    if uf.nil? and city.nil?
      file = jekyll_home
    elsif !uf.nil? and city.nil?
      file = File.join(jekyll_home, uf)
    else
      file = File.join(jekyll_home, uf, city)
    end
    file + '.json'
  end

  def file_name_ddd(uf, city)
    File.join(jekyll_home, uf, city, 'ddd.json')
  end

  # /brasil/pr.json

  def build_api
    d = DownloadAndParse.new
    d.process
    hash = Hash.new { |hash, key| hash[key] = Array.new }
    d.parsed_list.each do |item|
      FileUtils.mkdir_p(File.join(jekyll_home, item[:parameter_uf], item[:parameter_city]))
      hash[file_name] << item.to_json
      hash[file_name(item[:parameter_uf])] << item.to_json
      File.open(file_name(item[:parameter_uf], item[:parameter_city]), 'w+') do |f|
        f.write(item.to_json)
      end
      File.open(file_name_ddd(item[:parameter_uf], item[:parameter_city]), 'w+') do |f|
        f.write(item[:area_code].to_s)
      end
    end
    hash.each do |file, array|
      File.open(file, 'w+') do |f|
        f.write('[' + array.join(',') + ']')
      end
    end
    true
  end
end