class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :comments

  def category_name=(name)
    self.categories << Category.find_or_create_by(name: name)
  end

  def category_name

  end

  def category_ids=(ids)
    ids.each do |id| 
      self.categories << (id.nil? ? Category.create(name: id) : Category.find_by(id: id))
    end
  end

  def category_ids
    self.categories.map { |cat| cat.id }
  end
end