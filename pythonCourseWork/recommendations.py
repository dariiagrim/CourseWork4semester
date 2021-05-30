import random
from main import algo
from operator import itemgetter


def get_recommendations(user_id, number):
    tracks_id_list = []
    for i in range(number):
        tracks_id_list.append(random.randint(1, number))
    tracks_id_set = set(tracks_id_list)
    tracks_id_list = list(tracks_id_set)
    evaluation_list = []
    for track_id in tracks_id_list:
        evaluation_list.append((track_id, algo.predict(user_id, track_id).est))
    evaluation_list_sorted = sorted(evaluation_list, key=itemgetter(1), reverse=True)
    return evaluation_list_sorted[:50]



