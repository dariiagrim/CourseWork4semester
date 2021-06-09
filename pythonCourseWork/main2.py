import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from main import connect, postgres_to_dataframe, param_dic, df, data
from surprise import SVD
from surprise.model_selection import cross_validate

connection = connect(param_dic)
meta_column_names = ["id", "name", "popularity", "release_date", "artist_id", "danceability", "energy"]
meta_df = postgres_to_dataframe(connection, "select id, name, popularity, release_date, artist_id, danceability, energy from tracks", meta_column_names)
print(meta_df.head())
svd = SVD(verbose=False, n_epochs=10)
cross_validate(svd, data, measures=['RMSE', 'MAE'], cv=3, verbose=True)
trainset = data.build_full_trainset()
svd.fit(trainset)


def get_track_info(track_id, metadata):
    track_info = metadata[metadata['id'] == track_id][['name', 'popularity', 'release_date', 'artist_id', 'danceability', 'energy']]
    return track_info.to_dict(orient='records')


def predict_review(user_id, track_id, model, metadata):
    review_prediction = model.predict(uid=user_id, iid=track_id)
    return review_prediction.est


print(predict_review(1, 3, svd, meta_df))

