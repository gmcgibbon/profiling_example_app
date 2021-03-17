Rails.autoloaders.main.on_load("ActiveStorage::AnalyzeJob") do
  ActiveStorage::AnalyzeJob.class_eval do
    def nothing_to_see_here_🙈
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  def super_cool_method_😎
  end
end

ActiveSupport.on_load(:active_record) do
  def i_like_emojis_✨
  end
end
