class SimpleDDD::DownloadAndParse
  def list
    @list ||= []
  end

  def parsed_list
    @parsed_list ||= SimpleDDD::Normalizer.new(list).normalize
  end

  def downloader
    @downloader ||= SimpleDDD::Downloader.new
  end

  def parser
    SimpleDDD::ParseAnatelPDF
  end

  def parse(reader)
    parser.new(reader).parse
  end

  def process
    downloader.download do |reader|
      list.push(*parse(reader))
    end
  end
end