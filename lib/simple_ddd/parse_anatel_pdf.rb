class SimpleDDD::ParseAnatelPDF
  attr_accessor :reader
  def initialize(_reader)
    @reader = _reader
  end

  def regexp
    @regexp ||= /^(\w\w)\s{2,}(.*?)\s{2,}(\d+)$/
  end

  def parse
    txt = reader.pages.map { |p| p.text }.join("\n")
    txt.scan(regexp)
  end
end