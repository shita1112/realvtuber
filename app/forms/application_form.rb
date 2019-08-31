# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  private

  def add_models_errors(*models)
    models.each do |obj|
      obj.valid?
      obj.errors.each do |attribute, message|
        errors.add(attribute, message)
      end
    end
  end
end
