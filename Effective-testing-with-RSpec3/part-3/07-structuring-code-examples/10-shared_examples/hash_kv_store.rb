# the problem is the need to support two implementations with the same interface:
require ​'hash_kv_store'​
​ 	
​ 	RSpec.describe HashKVStore ​do​
​ 	  ​let​(​:kv_store​) { HashKVStore.new }
​ 	
​ 	  ​it​ ​'allows you to fetch previously stored values'​ ​do​
​ 	    kv_store.store(​:language​, ​'Ruby'​)
​ 	    kv_store.store(​:os​, ​'linux'​)
​ 	
​ 	    ​expect​(kv_store.fetch(​:language​)).to eq ​'Ruby'​
​ 	    ​expect​(kv_store.fetch(​:os​)).to eq ​'linux'​
​ 	  ​end​
​ 	
​ 	  ​it​ ​'raises a KeyError when you fetch an unknown key'​ ​do​
​ 	    ​expect​ { kv_store.fetch(​:foo​) }.to raise_error(KeyError)
​ 	  ​end​
​ 	​end​


require ​'file_kv_store'​
​ 	
​ 	RSpec.describe FileKVStore ​do​
​ 	  ​let​(​:kv_store​) { FileKVStore.new }
​ 	
​ 	  ​it​ ​'allows you to fetch previously stored values'​ ​do​
​ 	    kv_store.store(​:language​, ​'Ruby'​)
​ 	    kv_store.store(​:os​, ​'linux'​)
​ 	
​ 	    ​expect​(kv_store.fetch(​:language​)).to eq ​'Ruby'​
​ 	    ​expect​(kv_store.fetch(​:os​)).to eq ​'linux'​
​ 	  ​end​
​ 	
​ 	  ​it​ ​'raises a KeyError when you fetch an unknown key'​ ​do​
​ 	    ​expect​ { kv_store.fetch(​:foo​) }.to raise_error(KeyError)
​ 	  ​end​
​ 	​end​


# the soultion is to use shared_example
# /spec/support/kv_store_shared_examples.rb
RSpec.shared_examples ​'KV store'​ ​do​ |kv_store_class|
	  ​let​(​:kv_store​) { kv_store_class.new }
​ 	
​ 	  ​it​ ​'allows you to fetch previously stored values'​ ​do​
​ 	    kv_store.store(​:language​, ​'Ruby'​)
​ 	    kv_store.store(​:os​, ​'linux'​)
​ 	
​ 	    ​expect​(kv_store.fetch(​:language​)).to eq ​'Ruby'​
​ 	    ​expect​(kv_store.fetch(​:os​)).to eq ​'linux'​
​ 	  ​end​
​ 	
​ 	  ​it​ ​'raises a KeyError when you fetch an unknown key'​ ​do​
​ 	    ​expect​ { kv_store.fetch(​:foo​) }.to raise_error(KeyError)
​ 	  ​end​
​ 	​end​

# usage:
require ​'hash_kv_store'​
​ 	require ​'support/kv_store_shared_examples'​
​ 	
​ 	RSpec.describe HashKVStore ​do​
​ 	  it_behaves_like ​'KV store'​, HashKVStore
     it_behaves_like ​'KV store'​, FileKVStore
​ 	​end​
# note
# in such situation dont use two include_esxamples because second will overwrite the first 