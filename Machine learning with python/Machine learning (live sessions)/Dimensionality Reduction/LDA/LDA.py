#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


data=pd.read_csv('nba_final.csv')


# In[3]:


data.shape


# In[4]:


data


# In[5]:


data.info()


# In[6]:


data.isna().sum()


# In[8]:


data['Pos2']=data['Pos2'].replace(np.nan,'NONE')
data['Pos2'].unique()


# In[9]:


data=data.fillna(0)


# In[10]:


data.isna().sum()


# In[11]:


data.head()


# In[12]:


data=data.drop(['Player.x','Player_ID'],axis=1)


# In[13]:


data


# In[15]:


data['Pos1'].unique()


# In[ ]:


'''
ONE HOT ENCODING
C      PG     SF      PF     SG
1      0      0       0      0
0      1      0       0      0
0      0      1       0      0



'''


# In[ ]:


#Label encoding
'''
Genders
b-1
g-2
m-3
w-4
t-5
'''
#on hot encoding
'''
B  G  M   W  T
1  0  0  0   0

             1


'''


# In[16]:


data.columns


# In[17]:


from sklearn.preprocessing import LabelEncoder
Le=LabelEncoder()
data['Pos1']=Le.fit_transform(data['Pos1'])
data['Pos2']=Le.fit_transform(data['Pos2'])
data['Tm']=Le.fit_transform(data['Tm'])
data['Season']=Le.fit_transform(data['Season'])
data['Conference']=Le.fit_transform(data['Conference'])
data['Role']=Le.fit_transform(data['Role'])
data['Play']=Le.fit_transform(data['Play'])


# In[18]:


data


# In[19]:


X=data.drop(['Play'],axis=1)
y=data['Play']


# In[20]:


X


# In[21]:


y


# In[22]:


from sklearn.preprocessing import StandardScaler


# In[ ]:


#age
#18   0.00
#25   0.17
#40   
#50
#65


# In[23]:


min_age=18
max_age=65


# In[25]:


#nomalization_age=(age-min_age)/(max_age-min_age)
#standardized=(age-mean_age)/std_age
#z_score


# In[33]:


sc=StandardScaler()
X=sc.fit_transform(X)


# In[34]:


X


# In[38]:


from sklearn.discriminant_analysis import LinearDiscriminantAnalysis


# In[40]:


data['Play'].unique()


# In[54]:


lda=LinearDiscriminantAnalysis(n_components=1)
X=lda.fit_transform(X,y)


# In[42]:


X.shape


# In[45]:


from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split


# In[46]:


X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=20)


# In[47]:


lr=LogisticRegression()


# In[48]:


lr.fit(X_train,y_train)


# In[49]:


lr_pred=lr.predict(X_test)


# In[50]:


from sklearn.metrics import*


# In[51]:


accuracy_score(lr_pred,y_test)


# In[ ]:


'''
ETL
Loading libraies(required)
Importing dataset
EDA(shape,outlier,null value)
Feature eng.(Encoding,Resclaing)
feature_selection(LDA,PCA,IV,VIF,RFE ETC)
Model making
evalution
hyperparameter(if_required)
deployment

'''

