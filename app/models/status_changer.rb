module StatusChanger
  
  def self.klass_for(status)
    case status
    when 'sold'
      Sold
    end
  end

end
