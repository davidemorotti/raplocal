
using TextAnalysis, Languages, Clustering

filename = joinpath(dirname(@__FILE__), "data", "highlights.csv")

function get_headers(source)
    headers = [ String(s) for s in source[1,:] ]
    source = source[2:end,:] # clear the headers
    headers, source
end

source = readcsv(filename)
headers, source = get_headers(source)

sample = source[:,5]
length(sample)

#fd = FileDocument(sample)
#sd = StringDocument(fd)

text = join(sample, ",")
sd = StringDocument(text)
crps = Corpus([sd])

remove_punctuation!(sd)
update_lexicon!(crps)
lexicon(crps)

update_inverse_index!(crps)
inverse_index(crps)
hash_function!(crps, TextHashFunction())

crps["Handelskrieg"]

m = DocumentTermMatrix(crps)
D = dtm(m, :dense)
T = tf_idf(D)
cl = kmeans(T, 5)

m = DocumentTermMatrix(crps)
k = 2            # number of topics
iteration = 1000 # number of gibbs sampling iterations
alpha = 0.1      # hyper parameter
beta = 0.1       # hyber parameter
l = lda(m, k, iteration, alpha, beta) # l is k x word matrix.
                                      # value is probablity of occurrence of a word in a topic.


