module ApplicationHelper
  include ApplicationPermissions

  def navbar_class(name)
    if navbar_active?(name)
      'active'
    else
      ''
    end
  end

  def site_description
    config = Rails.configuration.rsp
    if config['type'] == 'season'
      config['desc'] + ' Currently in Season ' + config['season'].to_s + '.'
    elsif config['type'] == 'none'
      config['desc']
    else
      throw 'Invalid config: config/rsp.yml'
    end
  end

  def navbar_active?(name)
    case name
    when :home
      controller_name == 'pages' && action_name == 'home'
    when :admin
      controller.is_a? AdminController
    else
      controller_path.start_with? name.to_s
    end
  end

  def format_options
    Format.all.collect { |format| [format.name, format.id] }
  end

  def divisions_select
    @league.divisions.all.collect { |div| [div.name, div.id] }
  end

  def bootstrap_paginate(target)
    will_paginate target, renderer: BootstrapPagination::Rails
  end

  def present(object, klass = nil)
    klass ||= BasePresenter.presenter object

    klass.new(object, self)
  end

  def present_collection(collection, klass = nil)
    collection.map { |object| present(object, klass) }
  end
end
