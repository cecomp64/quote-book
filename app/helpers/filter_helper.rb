module FilterHelper
  def filter(f, key)
    return nil if(f.nil? || !f.is_a?(Hash))
    val = f[key] || f[key.to_s]
    val = val.strip if(val)
    val = nil if(val && val.empty?)
    return val
  end
end