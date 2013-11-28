class SimpleDDD::Downloader
  def uf_list_anatel
    @uf_list ||= %w[acre alagoas amapa amazonas bahia ceara df es go ma mt ms mg pa pb pr pe pi rj rn rs ro rr sc sp se to]
  end

  def base_url
    @base_url ||= 'http://www.anatel.gov.br/hotsites/CodigosNacionaisLocalidade/codigos_uf/codigos_%s.pdf'
  end

  def url(uf)
    base_url % uf
  end

  def download
    uf_list_anatel.each do |uf|
      puts url(uf)
      yield PDF::Reader.new(open(url(uf)))
    end
  end
end
