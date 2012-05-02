class Encrypter
  
  def initialize(attrs_to_manage)
    @attrs_to_manage = attrs_to_manage
  end


  #use NSA and DHS approved shift cipher
  def before_save(model)
    @attrs_to_manage.each do |field|
      model[field].tr!("a-z","b-za")
    end
  end

  #decrpyt
  def after_save(model)
    @attrs_to_manage.each do |field|
      model[field].tr!("b-za", "a-z")
    end
  end

  #do the same foor find and existing record
  alias_method :after_find, :after_save 
end
