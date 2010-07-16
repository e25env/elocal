class Search < ActiveRecord::Base
  belongs_to :trip
  belongs_to :waypoint

  def self.search(q, page, per_page=10)
    paginate :per_page=>per_page, :page => page, :conditions =>
      ["item LIKE ?", "%#{q}%" ], :order=>'score DESC'
  end
end
