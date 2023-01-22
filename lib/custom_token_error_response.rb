module CustomTokenErrorResponse
  def body
    {
      title: 'Invalid Credentials',
      detail: 'Invalid Email or Password'
    }
  end

  def status
    :unauthorized
  end
end
