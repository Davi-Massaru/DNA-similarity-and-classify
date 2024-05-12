Class dc.data.DNAClassification [ Language = python ]
{

ClassMethod CreateTheModelML()
{
    import pandas as pd

    def getKmers(sequence, size=6):
        kmers = [sequence[x:x+size].lower() for x in range(len(sequence) - size + 1)]
        kmers = [kmer for kmer in kmers if len(kmer) > 0]
        if len(kmers) == 0:
            return [sequence]
        return kmers

    print("Reading dataset")
    human_df = pd.read_table('/opt/irisbuild/data/human_data.txt')

    print("Creating K-mers groups")
    human_df['K_mers'] = human_df['sequence'].apply(getKmers)
    
    human_df['words'] = human_df.apply(lambda x: getKmers(x['sequence']), axis=1)
    human_df = human_df.drop('sequence', axis=1)

    human_texts = list(human_df['words'])
    for item in range(len(human_texts)):
        human_texts[item] = ' '.join(human_texts[item])
    y_data = human_df.iloc[:, 0].values        
    
    from sklearn.feature_extraction.text import CountVectorizer
    cv = CountVectorizer(ngram_range=(4,4))
    X_human_dna = cv.fit_transform(human_texts)

    print(X_human_dna.shape)

    print("PREPARING FIT DATA")
    from sklearn.model_selection import train_test_split
    X_train, X_test, y_train, y_test = train_test_split(X_human_dna, 
                                                        y_data, 
                                                        test_size = 0.20, 
                                                        random_state=42)
    
    print("FIT THE MODEL")
    from sklearn.naive_bayes import MultinomialNB
    classifier = MultinomialNB(alpha=0.1)
    classifier.fit(X_train, y_train)

    y_pred = classifier.predict(X_test)

    print("VALIDATING THE MODEL")

    from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score
    print("Confusion matrix\n")
    print(pd.crosstab(pd.Series(y_test, name='Actual'), pd.Series(y_pred, name='Predicted')))
    def get_metrics(y_test, y_predicted):
        accuracy = accuracy_score(y_test, y_predicted)
        precision = precision_score(y_test, y_predicted, average='weighted')
        recall = recall_score(y_test, y_predicted, average='weighted')
        f1 = f1_score(y_test, y_predicted, average='weighted')
        return accuracy, precision, recall, f1
    accuracy, precision, recall, f1 = get_metrics(y_test, y_pred)
    print("accuracy = %.3f \nprecision = %.3f \nrecall = %.3f \nf1 = %.3f" % (accuracy, precision, recall, f1))


    print("SAVE THE MODEL")
    import joblib
    joblib.dump(classifier, '/opt/irisbuild/data/multinomial_nb_model.pkl')
    joblib.dump(cv, '/opt/irisbuild/data/cv_to_multinomial_nb_model.pkl')
}

ClassMethod ClassifyDnaSequence(sequence As %String) As %Status
{
    import joblib
    from sklearn.feature_extraction.text import CountVectorizer

    classifier = joblib.load('/opt/irisbuild/data/multinomial_nb_model.pkl')
    cv = joblib.load('/opt/irisbuild/data/cv_to_multinomial_nb_model.pkl')

    def getKmers(sequence, size=6):
        kmers = [sequence[x:x+size].lower() for x in range(len(sequence) - size + 1)]
        kmers = [kmer for kmer in kmers if len(kmer) > 0]
        if len(kmers) == 0:
            return [sequence]
        return kmers
    k_mers = getKmers(sequence)

    k_mers_vec = cv.transform([' '.join(k_mers)])

    predicted_class = classifier.predict(k_mers_vec)[0]
    probabilities = classifier.predict_proba(k_mers_vec)[0]

    class_mapping = {
            0: 'G protein coupled receptors',
            1: 'tyrosine kinase',
            2: 'tyrosine phosphatase',
            3: 'synthetase',
            4: 'synthase',
            5: 'lon channel',
            6: 'transcription factor',
    }
    

    result = {
        "Classification": class_mapping[predicted_class],
        "Probabilities": {
            class_mapping[class_index]: float(probability)
            for class_index, probability in enumerate(probabilities)
        }
    }
    
    return result
}

}
