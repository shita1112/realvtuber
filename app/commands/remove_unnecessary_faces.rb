# frozen_string_literal: true

class RemoveUnnecessaryFaces < BaseCommand
  PATH = Rails.root.join("lib", "python_scripts", "remove_unnecessary_faces.py").freeze

  def call(*args)
    python(PATH, *args)
  end
end
