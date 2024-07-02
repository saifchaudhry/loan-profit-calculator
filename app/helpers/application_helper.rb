# app/helpers/application_helper.rb

module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice'
      "bg-blue-100 border-t-4 border-blue-500 text-blue-700 px-4 py-3 rounded relative"
    when 'alert'
      "bg-red-100 border-t-4 border-red-500 text-red-700 px-4 py-3 rounded relative"
    when 'error'
      "bg-yellow-100 border-t-4 border-yellow-500 text-yellow-700 px-4 py-3 rounded relative"
    else
      "bg-green-100 border-t-4 border-green-500 text-green-700 px-4 py-3 rounded relative"
    end
  end

  def flash_title(type)
    case type
    when 'notice'
      "Notice!"
    when 'alert'
      "Alert!"
    when 'error'
      "Error!"
    else
      "Success!"
    end
  end
end
