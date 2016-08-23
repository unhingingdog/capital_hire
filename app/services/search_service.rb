class SearchService
  def initialize(target_class)
    @target_class = target_class
  end

  def search(query)
    if query.present?
      @target_class.where("title @@ :q or description @@ :q", q: query)
    end
  end
end
