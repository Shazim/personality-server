module CustomException
  def raise_error(title, detail, status = :ok)
    render(json: { error: error_block(title, detail) }, status: status)
  end

  def error_block(title, detail)
    {
      title: title,
      detail: detail
    }
  end
end
