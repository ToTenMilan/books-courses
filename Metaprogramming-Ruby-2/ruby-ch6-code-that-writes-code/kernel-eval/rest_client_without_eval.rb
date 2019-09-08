verbs = %w[get post patch delete]

verbs.each do |m|
  define_method m do |path, *args, &b|
    r[path].send(m, *args, &b)
  end
end