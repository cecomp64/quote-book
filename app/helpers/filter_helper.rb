module FilterHelper
  def filter(f, key)
    return nil if(f.nil? || !f.is_a?(Hash))
    val = f[key] || f[key.to_s]
    val = val.strip if(val)
    val = nil if(val && val.empty?)
    return val
  end

  def sort_from_params(p)
    return {} if p[:order].nil?
    h = {}
    p[:order].map{|k, v| h[k.to_sym] = v.to_sym}
    return h
  end

  def order_from_sort(s)
    str = {created_at: :desc}
    s.each do |attr, direction|
      case attr
        when :votes
          #str = "score #{direction.to_s.upcase}"
          str = {score: direction}
        when :date
          str = {created_at: direction}
        when :name
          str = {name: direction}
      end
    end

    return str
  end
end