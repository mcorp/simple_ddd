class SimpleDDD::Normalizer
  attr_accessor :list
  def initialize(_list)
    @list = _list
  end

  def normalize_city_name(name)
    name.mb_chars.capitalize.to_s
  end

  def normalize_state_name(name)
    name.downcase
  end

  def normalize_area_code(ddd)
    ddd.to_i
  end

  def normalize
    list.map do |value|
      {
        uf:             normalize_state_name(value[0]),
        city:           normalize_city_name(value[1]),
        parameter_uf:   value[0].parameterize,
        parameter_city: value[1].parameterize,
        area_code:      normalize_area_code(value[2])
      }
    end
  end
end