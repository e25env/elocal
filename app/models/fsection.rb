class Fsection < ActiveRecord::Base
  include ArMethods
  has_many :budgets
  def cats_fy(fy=fiscal_year)
    cats= budgets(:conditions=>{:fy=>fy}).map(&:cat_id).uniq.sort
    Cat.find cats
  end
  def doc_code
    return id==0 ? "" : Section.find(id).doc_code
  end
end
