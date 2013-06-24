SimpleForm.setup do |config|
    config.wrappers :default, class: 'input row',
      hint_class: :field_with_hint, error_class: :errors do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
  
      ## Inputs
      b.wrapper tag: :div, class: 'large-16 small-16 columns' do |c|
        c.wrapper tag: :div, class: 'row collapse' do |d|
          d.wrapper tag: :div, class: 'large-12 small-12 columns' do |e|
            e.use :label, wrap_with: {tag: :span}
          end
          d.wrapper tag: :div, class: 'large-12 small-12 columns' do |e|
            e.use :input
          end
        end
        c.wrapper tag: :div, class: 'row collapse' do |d|
          d.wrapper tag: :div, class: 'large-16 small-16 columns' do |e|
            e.use :hint,  wrap_with: { tag: :span, class: :hint }
            e.use :error, wrap_with: { tag: :small, class: :error }
          end
        end
      end
    end
    config.default_wrapper = :default
    config.boolean_style = :nested
    config.button_class = 'button'
    config.error_notification_tag = :div
    config.error_notification_class = 'alert-box alert'
    config.label_class = 'control-label'
    config.form_class = :nice
    config.browser_validations = false
  end