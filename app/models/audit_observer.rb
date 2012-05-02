class AuditObserver < ActiveRecord::Observer
  observe Order, User

  def after_create(model)
    model.logger.info("[Audit] #{model.class.name} #{model.id} created")
  end
end
