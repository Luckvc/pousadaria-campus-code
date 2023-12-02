class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def image_as_thumbnail(image)
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
