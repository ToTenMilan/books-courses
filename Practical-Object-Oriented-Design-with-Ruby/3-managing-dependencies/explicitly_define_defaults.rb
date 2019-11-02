# specifying defaults by merging a defaults hash. Defaults will be merged only if not passed to args
def initialize(args)
  args = defaults.merge(args)
  @chainring = args[:chainring]
  ...
end
def defaults
  {:chainring => 40, :cog => 18}
end


# ....
# specifying defaults using fetch (instead of using `||`)
def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  @cog       = args.fetch(:cog, 18)
  @wheel     = args[:wheel]
end
# ...


# specifying defaults using || might introduce bugs if someone will pass `false` as argument
# def initialize(args)
#   @chainring = args[:chainring] || 40
#   @cog       = args[:cog]       || 18
#   @wheel     = args[:wheel]
# end