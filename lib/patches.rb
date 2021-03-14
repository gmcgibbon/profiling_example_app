Rails.application.reloader.to_prepare do
  ActiveStorage::AnalyzeJob.class_eval do
    def nothing_to_see_here_🙈
    end
  end
end

ActionController::Base.class_eval do
  def super_cool_method_😎
  end
end

ActiveRecord::Base.class_eval do
  def i_like_emojis_✨
  end
end
