import math
import numpy as np
import os.path
import pandas as pd

from gensim.models import Word2Vec
from sklearn.metrics.pairwise import cosine_similarity as cos_sim


def get_patients_data(path_to_csv, columns=None, dropna=True):
    """
    gets a csv dataset into pandas keeping specified columns and dropping or keeping na's

    :param path_to_csv: str
    :param columns: list of str, columns to keep, None by default (keeps all)
    :param dropna: bool, whether to drop na's, True by default
    :return: pd.DataFrame
    """
    res = pd.read_csv(path_to_csv, index_col=0)
    if columns:
        columns = list(filter(lambda col: col in res, columns))
        if columns:
            res = res[columns]
    if dropna:
        res = res.dropna()
    return res


def collocation_handler(model, word, collocation_function=None):
    not_found = 0
    if ' ' in word:
        if not collocation_function:
            collocation_function = lambda vec1, vec2: np.mean(vec1, vec2, axis=0)
        first, second = word.split()
        if first in model and second in model:
            first_vector = model[first]
            second_vector = model[second]
            word_vector = collocation_function(first_vector, second_vector)
        elif first in model and second not in model:
            word_vector = model[first]
            not_found = 1
        elif first not in model and second in model:
            word_vector = model[second]
            not_found = 1
        else:
            word_vector = None
            not_found = 2
    else:
        if word in model:
            word_vector = model[word]
        else:
            word_vector = None
            not_found = 1
    return word_vector, not_found


def get_cos_sim_list(model, patient_word_list, collocation_function=None):
    """
    calculates pairwise cosine similarities of words or collocations in a word list

    cosine similarity for a word pair that has a collocation is calculated as
    cosine similarity between a word vector and an average of word vectors from the collocation

    :param model: gensim.word2vec model
    :param patient_word_list: list of strings, words produced by the patient
    :param collocation_function: function combining two word vectors in a collocation, if None (default) mean is taken
    :return patient_cos_sim_list: list of float, pairwise cosine similarities
    :return not_found: int, number of words missing from the model vocabulary
    """
    patient_cos_sim_list = []
    not_found = 0
    for j, word in enumerate(patient_word_list):
        if j > 0:
            previous_word = patient_word_list[j - 1]
            word_vector, nf = collocation_handler(model, word, collocation_function)
            not_found += nf
            previous_word_vector, nf = collocation_handler(model, previous_word, collocation_function)
            not_found += nf
            if word_vector and previous_word_vector:
                patient_cos_sim_list.append(cos_sim(word_vector, previous_word_vector))
            else:
                continue
    not_found = math.ceil(not_found / 2)
    return patient_cos_sim_list, not_found


def main():
    root = os.path.abspath(os.path.curdir)
    csv = "verbal fluency.csv"
    animals = get_patients_data(csv, ['animals'])
    animals['animals'] = animals['animals'].apply(lambda s: s.strip().split(';'))
    print(animals)


if __name__ == "__main__":
    main()
