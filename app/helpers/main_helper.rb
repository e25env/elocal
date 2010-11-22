module MainHelper
  # convert *ss to waypoint link
  def a2waypoint(s)
    render :text => s.gsub!(/\*([\w]+)(\W)?/, '<a href="/\1">*\1</a>\2')
  end
end
