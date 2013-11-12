module ActivityTracker
  def self.included(base)
    base.class_eval do
      class_name = base.name.downcase

      define_method("create_#{class_name}") do |params|
        subject = base.create(
          name:   params[:name],
          email:  params[:email],
          phone:  params[:phone],
          github: params[:github]
          )

        subject.create_activity("added", params) if subject.save

        subject
      end

      define_method("destroy_#{class_name}") do |params|
        self.create_activity("deleted", params)

        self.destroy
      end

      define_method("update_#{class_name}") do |params|
        params = params["#{class_name}".to_sym]

        self.update_attributes(
          name:   params[:name],
          email:  params[:email],
          phone:  clean_phone(params[:phone]),
          github: params[:github]
          )

        self.create_activity("updated", params) if self.save

        self
      end

      define_method("create_activity") do |action, params|
        activity = Activity.create(
          "#{class_name}_id".to_sym => self.id,
          :user_id                  => params[:user_id],
          :action                   => action
          )

        activity.save
      end
    end
  end

  private

  def clean_phone(number)
    number.gsub(/\D/, "")[0..10]
  end
end