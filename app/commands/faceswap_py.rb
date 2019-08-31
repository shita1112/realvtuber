# frozen_string_literal: true

class FaceswapPy < BaseCommand
  FACESWAP_PATH = Rails.root.dirname.join("faceswap_code", "faceswap_latest", "faceswap.py").freeze
  TOOLS_PATH = Rails.root.dirname.join("faceswap_code", "faceswap_latest", "tools.py").freeze

  def extract(*args)
    python(FACESWAP_PATH, "extract", *args)
  end

  def train(*args)
    python(FACESWAP_PATH, "train", *args)
  end

  def convert(*args)
    python(FACESWAP_PATH, "convert", *args)
  end

  def effmpeg(*args)
    python(TOOLS_PATH, "effmpeg", *args)
  end

  def sort(*args)
    python(TOOLS_PATH, "sort", *args)
  end

  def train_with_timeout(time, *args)
    run("timeout", time, "python", FACESWAP_PATH, "train", *args) { puts "finish train" }
  end
end
