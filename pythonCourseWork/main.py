import psycopg2
import pandas as pd
import sys
from surprise import Dataset
from surprise import Reader
from surprise import KNNWithMeans
from surprise import Dataset
from surprise import Reader

param_dic = {
    "host": "localhost",
    "database": "music_recommender",
    "user": "dariia",
    "password": "DDG256"
}


def connect(params_dic):
    conn = None
    try:
        conn = psycopg2.connect(**params_dic)
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    print("Connected")
    return conn


def postgres_to_dataframe(conn, select_query, column_names):
    cursor = conn.cursor()
    try:
        cursor.execute(select_query)
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        cursor.close()
        return 1
    tuples = cursor.fetchall()
    cursor.close()
    dataframe = pd.DataFrame(tuples, columns=column_names)
    return dataframe


connection = connect(param_dic)
column_names = ["user_id", "track_id", "rating"]
df = postgres_to_dataframe(connection, "select user_id, track_id, rating from ratings", column_names)
print(df.head(10))
reader = Reader(rating_scale=(1, 5))
data = Dataset.load_from_df(df[["user_id", "track_id", "rating"]], reader)

sim_options = {
    "name": "cosine",
    "user_based": True
}
algo = KNNWithMeans(sim_options=sim_options)
trainingSet = data.build_full_trainset()
algo.fit(trainingSet)
prediction = algo.predict(3, 2)
prediction_est = prediction.est
print(prediction_est)
connection.close()
