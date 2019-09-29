hls = GC.stat[:heap_live_slots].to_f
hep = GC.stat[:heap_eden_pages].to_f
hpo = GC::INTERNAL_CONSTANTS[:HEAP_PAGE_OBJ_LIMIT].to_f
res = hls / (hep * hpo)
puts res.to_s