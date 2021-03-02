# OS

```py
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline
import os

#read path
path=os.getcwd()
```


# pandas
```py
#count and percentage proportion
df.value_counts()
proportion=df.value_counts(normalize=True).mul(100).round(1).astype(str)+'%'
```
# de-group the "carrier" column by appending an index column
```py
df.reset_index(level=0, inplace=True)
```
# rename column
df.rename(columns = {'old name':'new name'}, inplace = True)
# merge the two DataFrames
df = pd.merge(df1,df2, on = ['column1','columns2'], how = 'inner')
# get dummies
df2 = pd.get_dummies(df, columns = ['country'],drop_first=True)
# select rows
df.iloc
# select columns
df.iloc[:,0:15]
# drop columns
df.drop(columns=['B', 'C'])

## filter

# filter a dataframe
df1997=df[(df.year==97) & (df.poor=='pobre')]
# filter finite data only
df=df[np.isfinite(df.column)]

## sort

# sort values according to a column
```py
df.sort_values(by=['name'],ascending =False)
#sort the columns alphabetically
df = df.reindex(sorted(df.columns), axis=1)
```

## value

# replace value
```py
df.column=df.column.replace('old value',1,inplace=True)
#replace values under conditions
df['V204'].mask(df['V204']<=3,0(new value),inplace=True)
```

# numpy

# randomly pick 
images = np.random.choice(images, 200)
# create an empty numpy array
X = np.empty(shape=(len(images), imshape[0]*imshape[1]))
# Create a range
alpha_list=np.linspace(10**(-6),10**(6), num=1000)
# condition number
cond=np.linalg.cond(mat.to_numpy())
# inverse matrix
np.linalg.inv(A)

The condition number a measure of how close a matrix is to being singular: a matrix with large condition number is nearly singular, whereas a matrix with condition number close to 1 is far from being singular

# filter and select under conditions
freq_index = np.where(frequency>30)[0]

# clean data

# drop NA of a certain column
df.dropna(subset=['column'], inplace = True)
# get the number of all the null, summary
df.isnull().sum()

# remove certain characters from string in dataframe python
data['result'] = data['result'].map(lambda x: x.lstrip('[').rstrip(']'))

# smf

import statsmodels.formula.api as smf

# Ordinary Least Squares regression
lm1 = smf.ols(formula='y ~ x1+x2', data=df).fit()

# matplotlib

# use ggplot
plt.style.use('ggplot') 
# line chart
plt.plot(flights_df.groupby('month')['dep_delay'].mean())
# bar chart
```py
plt.bar(range(25), dep_delay_hour.dep_delay,color='blue')

x = list(carrier_avg['dep_delay'])
y = list(carrier_avg['arr_delay'])
area=list(carrier_avg['total_flights_count'])
s=list(carrier_avg['carrier'])

i = 0
while(i<len(carrier_avg)):
    text(x[i],y[i],s[i],size=14, verticalalignment='center', horizontalalignment='center', color='white', alpha = 0.7)
    i = i+1   
plt.scatter(x, y, s=area, linewidths=2, edgecolor='w',alpha=0.4)
rcParams['figure.figsize'] = 20, 20 #ensure the whole view of the plot
plt.axes().set_aspect('equal')
axis([0,25,-15,25])
xlabel('Average departure delay in mins')
ylabel('Average arrival delay in mins')
title('size ~ total number of flights, color ~ speed in minute')
```

![image.png](attachment:image.png)

# legend out of the plot
```py
ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))

import os

os.path

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data=pd.read_csv('C:\\Users\yang_\OneDrive - UW\database\hw8\Q2-bin-histogram.csv')

N=len(data['d'])
%matplotlib inline
x = np.arange(N)
fig, ax = plt.subplots()
plt.style.use('ggplot')
rgb = np.random.rand(3,)
cmap = plt.cm.tab10
colors = cmap(np.arange(N) % cmap.N)
ax.bar(x,data['func_d'],width=1,color=colors,edgecolor='white')
ax.set_ylabel('number of cities')
ax.set_title('cities and departing flights histogram')
ax.set_xticks(x)
ax.set_xticklabels(data['d'])
fig.set_size_inches(50, 20)
fig.savefig('C:\\Users\yang_\OneDrive - UW\database\hw8\histogram.jpg',  dpi=600)
```

# Manipulate bitmap images

mad hat see ps2

# diff-in-diff

#implement the before-after estimator
df['before'] = df.year ==97

# DiD estimator
progresa_df[progresa_df.poor=='pobre'].groupby(['progresa','before']).sc.mean()
m=smf.ols(formula='sc~before*progresa',data=progresa_df[progresa_df.poor=='pobre'])
r=m.fit()
r.summary()

# statistics

## T-test
```py
from scipy.stats import ttest_ind

con_col=list(dfcontrol)
#create a dictionary in order to create the dataframe
dic={'Variable Name':[],'Variable Avg (Treatment villages)':[],'Avg (control)':[],'difference':[],'p-value':[]}
for column in con_col:
    dic['Variable Name'].append(column)
    dic['Variable Avg (Treatment villages)'].append(round(dftreat[column].dropna().mean(), 5))
    dic['Avg (control)'].append(round(dfcontrol[column].dropna().mean(), 5))
for i in range(len(con_col)):
    dic['difference'].append(
        round((dic['Variable Avg (Treatment villages)'][i]
               - dic['Avg (control)'][i]), 5))
    dic['p-value'].append(stats.ttest_ind(dftreat[dic['Variable Name'][i]].dropna(), dfcontrol[dic['Variable Name'][i]].dropna())[1])
```

## pearson correlation

```py
dict={'variable':[],'correlation':[]}
for column in wvs:
    dict['variable'].append(column)
    b=wvs[column].to_numpy()
    #in case there is inf or nan
    b= np.nan_to_num(b)
    p=stats.pearsonr(a,b)
    dict['correlation'].append(p[0]) #only show the first number of pearson correlation
pearson=pd.DataFrame(dict,columns=['variable','correlation'])
```

# sklearn
```py
from sklearn.linear_model import LinearRegression
from sklearn.neighbors import KNeighborsClassifier

```
# train test split
```py
X_train, X_test, Y_train, Y_test = train_test_split(X, Y,test_size=0.2)
X_tr, X_val, Y_tr, Y_val = train_test_split(X_train, Y_train, test_size=0.2)
```

# ridge and lasso
from sklearn.linear_model import Ridge, Lasso

# cross validation

```py
from sklearn.metrics import accuracy_score
from sklearn.metrics import f1_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score

def cv(k,model,X, y, data):
    accuracy_scores=[]
    f_scores=[]
    precision_scores=[]
    recall_scores=[]
    a=np.random.choice(len(data),len(data),replace=False)
    for i in range (1,k): #loop k times
        # For training data, select all indices, except those that went into validation data.
        train_index=a[a%k != i] #Select every k-th of your indices for validation data
        valid_index=a[a%k == i]
        #Separate the data X and the target y into training/validation parts.
        X_train=X.iloc[train_index]
        X_valid=X.iloc[valid_index]
        y_train=y.iloc[train_index]
        y_valid=y.iloc[valid_index]
        model.fit(X_train, y_train) # Fit the model on training data
        y1=model.predict(X_valid) # Predict outcome on validation data
        accuracy_scores.append(accuracy_score(y_valid, y1)) #score predict y and validation y
        f_scores.append(f1_score(y_valid,y1))
        precision_scores.append(precision_score(y_valid,y1))
        recall_scores.append(recall_score(y_valid, y1))
    
    dict={'accuracy score':accuracy_scores,'false 1 score':f_scores,
          'precision score': precision_scores,'recall score': recall_scores}
    scores=pd.DataFrame(dict,columns=['accuracy score','false 1 score','precision score','recall score'])
    print (scores)
    print ('mean accuracy score:',np.mean(accuracy_scores),'\nmean false 1 score:',np.mean(f_scores),'\nmean precision score:', np.mean(precision_scores),'\nmean recall score:', np.mean(recall_scores))
```
# k-nn
cv(5,KNeighborsClassifier(n_neighbors=1),X,y,wvs_sample)
# logistic regression
cv(5,LogisticRegression(solver='liblinear', random_state=0),X,y,wvs_sample)
# SVM
from sklearn.svm import SVC
cv(5,SVC(kernel='poly',degree=1,max_iter=1000),X,y,wvs_sample)
SVC(kernel='sigmoid',gamma=0.8,max_iter=1000)
SVC(kernel='rbf',gamma=1,max_iter=1000)

# confusion matrix
```py 
from sklearn.metrics import confusion_matrix 
from sklearn.metrics import accuracy_score 
from sklearn.metrics import classification_report
results = confusion_matrix(val2.real, val2.pred) 
print ('Confusion Matrix:')
print(results) 
print ('Accuracy Score:',accuracy_score(val2.real, val2.pred))
```

# clean

```py
def clean(data):
    nan_value = np.nan
    # find out missing values in quote
    data.replace("", nan_value, inplace=True)
    data.replace(" ", nan_value, inplace=True)
    
    # find out missing values in fresh
    data.replace("none", nan_value, inplace=True)

    # clean fresh and quote by dropping N/As
    data.dropna(subset=['fresh','quote'],inplace=True)
    
    # clean duplicated reviews
    data['duplicated_review']=data.quote.duplicated()
    data.drop(data[data['duplicated_review']==True].index,inplace=True)
    
    return data
```

# bag of words

vectorizer = CountVectorizer(binary=True)
# define vectorizer
X = vectorizer.fit_transform(tomatoes.quote.values)
X = X.toarray()
# vectorize your data. Note: this creates a sparce matrix,
# use .toarray() if you want a dense matrix.
words = vectorizer.get_feature_names()
# in case you want to see what are the actual words

# NB with smoothing
```py
def nbfitting(X_tr,Y_tr,a):
    prob = Y_tr.value_counts(1)
    lf=np.log(prob[0])
    lr=np.log(prob[1])
    
    bow_train = pd.DataFrame(data = X_tr, columns = words)
    bow_train['fresh'] = Y_tr
    words_sum = bow_train.groupby('fresh').sum()

    lwf = (words_sum[words_sum.index=='fresh']+a)/(Y_tr.value_counts()['fresh']+2*a)
    lwf = np.log(lwf)
    
    lwr = (words_sum[words_sum.index=='rotten']+a)/(Y_tr.value_counts()['rotten']+2*a)
    lwr = np.log(lwr)
    
    return lf, lr, lwf, lwr
```

# NB prediction
def nbpred(X_val,Y_val):
    fresh=np.apply_along_axis(loglikelihood_fresh,1,X_val)
    rotten=np.apply_along_axis(loglikelihood_rotten,1,X_val)
    pred = []
    for i in range(len(fresh)):
        if fresh[i] > rotten[i]:
            pred.append('fresh')
        else:
            pred.append('rotten')
            
    Y_array = np.array(Y_val)
    table = pd.DataFrame({'pred': pred,
                          'real': Y_array})

    score = accuracy_score(table.real, table.pred)
    return score

# [[RMSE]]

```py
def compute_rmse(predictions, yvalues):
    rmse = np.sqrt(np.mean((predictions-yvalues)**2))
    return round(rmse, 2)
```
# statistics

# covariance matrix
# cov = X'X / N - M'M
cov=X.T@X/N-M.T@M

# correlation matrix
# Corr := Cov / sqrt( diag(Cov)'diag(Cov) )
# diag returns a row vector consisting of the entries on the diagonal of its input
# '/' : element-wise division
corr=cov/np.sqrt(np.diag(cov).T@np.diag(cov))

# dataframe to matrix
for i in range(len(df)):
    a=cities.index(df['origin_city'][i])
    b=carriers.index(df['carrier_id'][i])
    X[a][b]=df['num'][i]

# SQL

def func_module_4():
  import pandas as pd
  def conn_mysql(info):
      import pymysql
      return pymysql.connect(
          database=info['database'],
          user=info['username'],
          password=info['password'],
          host=info['host'],
          port=int(info['port']))
  def conn_pgsql(info):
      import psycopg2
      return psycopg2.connect(
          database=info['database'],
          user=info['username'],
          password=info['password'],
          host=info['host'],
          port=info['port'])
  [dbType, dbName] = 'pgsql,MIMIC31263'.split(',')
  if dbType == 'mysql':
      conn = conn_mysql(mountedDB[dbName])
  else:
      conn = conn_pgsql(mountedDB[dbName])
  sql = '''select icud.subject_id, icud.hadm_id, icud.icustay_id,
             --- 人口统计学
             case when icud.age > 150 then 91.4 else round(icud.age, 1) end as age,
             icud.gender, icud.admission_type,
             case
                 when icus.first_careunit = 'ficu' then 'micu'
                 else icus.first_careunit
                 end as icu_first_service,
              --- 生命体征
             round(heartrate_mean) as heartrate,
             round(resprate_mean) as resprate,
             round(tempc_mean::numeric,1) as temperature,
             round(sysbp_mean) as SBP,
             round(meanbp_mean) as MAP,
             round(spo2_mean) as spo2,
             ---- 化验检查
             creatinine_max as creatinine,
             potassium_max as potassium,
             sodium_max as sodium,
             chloride_max as chloride,
             bicarbonate_max as bicarbonate,
             hematocrit_max as hematocrit,
             wbc_max as WBC,
             l.glucose_max as glucose,
             lactate_max as lactate,
             --- 死亡结局
             case
                 when icud.hospital_expire_flag = 1 or pat.dod between icud.dischtime and icud.dischtime + interval '30 days' then 'y'
                 else 'n'
                 end as mort_30days
      from icustay_detail icud
               left join patients pat on icud.subject_id = pat.subject_id
               left join icustays icus on icud.icustay_id = icus.icustay_id
               left join vitalsfirstday v on icud.icustay_id = v.icustay_id
               left join labsfirstday l on icud.icustay_id = l.icustay_id
      where age >= 18
        and icustay_seq = 1
        and hospstay_seq = 1'''
  df = pd.read_sql(sql, conn)
  from IPython import display
  display.display(df)
  return[df]
result_module_4 = func_module_4()

x%10 #modulus 取余数，取个位数
100//10 #floor divison 整除

# string, text processing

#extract only quote from the train DataFrame
training=train.quote
#convert training data to lower case
training=training.str.lower()
# replace lines and tabs
training=training.str.replace('\n',' ')
training=training.str.replace('\t',' ')
#Remove punctuation from the training data.
training=training.str.replace(r"[^\w\s']",' ')
training=training.str.strip()
#remove stop words from the training data using the NLTK package's English stop word list.
stops=stopwords.words('english')