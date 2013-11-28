class DownloadAndParse

  def list
    @list ||= []
  end

  def parsed_list
    @parsed_list ||= Normalizer.new(list).normalize
  end

  def downloader
    @downloader ||= Downloader.new
  end

  def parser
    ParseAnatelPDF
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