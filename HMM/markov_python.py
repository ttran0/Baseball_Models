import pandas as pd
import numpy as np
import copy as copy
# from PA import PA

def get_alpha(A,pie,p,y):
    s = len(p)
    n = len(y)
    q = 1-p
    Alpha = np.zeros((s,n))
    c = np.zeros(n)
    Alpha[:,[0]] = pie * (p*y[0] + (1-y[0])*q)
    c[0] = sum(Alpha[:,0])
    Alpha[:,[0]] = Alpha[:,[0]]/c[0]
    for k in range(1,n):
        Alpha[:,[k]] = np.dot((A.T),Alpha[:,[k-1]])
        Alpha[:,[k]] = Alpha[:,[k]] * (y[k]*p + (1-y[k])*q)
        c[k] = sum(Alpha[:,k])
        Alpha[:,[k]] = Alpha[:,[k]]/c[k]
    return Alpha,c

def get_beta(A,p,y,c):
    n = len(y)
    s = len(p)
    q = 1-p
    Beta = np.zeros((s,n))
    Beta[:,[n-1]] = np.ones((s,1))
    for k in range(n-2,-1,-1):
        p_t = y[k+1] * p + (1-y[k+1])*q
        Beta[:,[k]] = np.dot(A,(Beta[:,[k+1]]*p_t))
        Beta[:,[k]] = Beta[:,[k]]/c[k+1]
    return Beta


def get_gamma(Alpha,Beta,A,p,y,c):
    Gamma = Alpha * Beta
    [s,n] = Alpha.shape
    q = 1-p
    Xi = np.zeros((n,s,s))
    for k in range(1,n):
        p_t = y[k] * p + (1-y[k]) * q
        v = p_t * Beta[:,[k]]
        M = Alpha[:,[k-1]] * (v.T)
        Xi[[k],:,:] = M * A/c[k]
    return Gamma,Xi

def markov_parameters(A,p,pie,y):

    flag = 0
    iter = 0
    log_likelihood_old = -np.inf

    while flag==0:
        Alpha,c = get_alpha(A,pie,p,y)
        Beta = get_beta(A,p,y,c)
        Gamma,Xi = get_gamma(Alpha,Beta,A,p,y,c)
        LLcur = sum(np.log(c))
        print(LLcur)

        pie = Gamma[:,[0]]/sum(Gamma[:,[0]])
        p = ((np.dot(Gamma,y.reshape((len(y),1))).T/(np.sum(Gamma,axis=1)))).T
        A = sum(Xi)
        A = (A.T/np.sum(A,axis=1)).T

        iter = iter +1
        # print(iter)
        if (np.abs(LLcur - log_likelihood_old)<1e-5):
            flag = 1
        log_likelihood_old = LLcur
    return A,p,pie

def markov_states(A,p,pie,y):
    q= 1-p
    N = len(y)
    M = len(p)
    ind = np.zeros((M,N))
    g = np.zeros((M,N))
    g[:,[0]]= pie * (y[0]*p + (1-y[0])*q)

    for j in range(1,N):
        B = (A.T*g[:,j-1]).T
        Y = y[j] * p + (1-y[j])*q
        B = B * (np.ones((M,1)) * Y.T)
        ind[:,[j]] = B.argmax(axis=0).reshape(M,1)
        g[:,[j]] = B.max(axis=0).reshape(M,1)

    states = np.zeros((N))
    states[N-1] = g[:,N-1].argmax(axis=0)

    for j in range(N-2,-1,-1):
        states[j] = ind[int(states[j+1]),j+1]

    return states


def pa_results(data):
    n = len(data)
    s=[]
    outcome=[]
    outcome.append(data.event[0])
    s.append(data.state[0])
    for i in range(1,n):
        if data.batter[i-1] != data.batter[i]:
            outcome.append(data.event[i])
            s.append(data.state[i])
    return outcome,s

def reorder_states(data):
    state_strike_summary = pd.crosstab(D['states'],D['strike'])
    index_state0 = np.where(data.states == 0)[0]
    index_state1 = np.where(data.states == 1)[0]
    if state_strike_summary.iloc[0,1] < state_strike_summary.iloc[1,1]:
                data.states[index_state0] = 1
                data.states[index_state1] = 0
    return data

def split(data):
    n = len(data)
    count = 1
    # print(data.batter[0])
    for i in range(0,n-1):
        if data.batter[i] != data.batter[i+1]:
            count = count +1
        if count == 19:
            index = i
            break
    data_before = data.iloc[0:index,:]
    data_after = data.iloc[index:len(data),:]
    return(data_before,data_after,index)



pitcher = ['JustinVerlander','FelixHernandez']
# file = '/Users/truong/Desktop/OneDrive/Baseball/pbp/'
file = '/Users/ttran/OneDrive/Baseball/pbp/'
data = pd.read_csv(file + pitcher[0] + 'pbp_11.csv')
fip_data = pd.read_csv(file+ pitcher[0]+'fip_11.csv')
dat = pd.read_csv(pitcher[0]+'_11.csv')
fip = fip_data.fip


# k = 11 #GAME K+1
num_states = 3
dates = dat.date.unique()
transition= np.zeros((len(dates),3,3))
emission = np.zeros((3,len(dates)))
initial = np.zeros((3,len(dates)))
m=[]
dframe = pd.DataFrame({})
old_states = {}
D = {}

# TRAIN ENTIRE SEASON

A = np.random.uniform(0,1,(num_states,num_states))
A = (A.T/np.sum(A,axis = 1)).T
pie = np.random.uniform(0,1,(num_states,1))
pie = pie/np.sum(pie)
p = np.random.uniform(0,1,(num_states,1))




#INDIVIDUAL GAME ANALYSIS
for k in range(0,4):
    print(k)
    game = dat[dat.date == dates[k]]

    y = data.iloc[k,:]
    y = y.dropna()
    y = y[1:len(y)-1]

    A = np.random.uniform(0,1,(num_states,num_states))
    A = (A.T/np.sum(A,axis = 1)).T
    pie = np.random.uniform(0,1,(num_states,1))
    pie = pie/np.sum(pie)
    p = np.random.uniform(0,1,(num_states,1))
    # A = np.array([[0.3020, 0.3095, 0.3885],[0.9771, 0.0229, 0],[0,0.1787, 0.8213]]);
    # p = np.array([[1],[0],[0.3988]]);
    # pie = np.array([[0],[1],[0]]);

    #GET PARAMETERS
    A,p,pie = markov_parameters(A,p,pie,y)
    #GET STATESnew_states = states
    states = markov_states(A,p,pie,y)

    emission[:,[k]] = p
    transition[[k],:,:] = A
    initial[:,[k]] = pie
    m.append(A.diagonal(0).max())
    game_summary = pd.DataFrame({'strike':y.tolist(),'state':states.tolist()})
    state_summary = pd.crosstab(game_summary['state'],game_summary['strike'])
    state_summary = state_summary.join(pd.DataFrame({'state':[0,1,2]}))
    state_summary.columns = ['n','y','state']
    state_summary = state_summary.sort(['y'],ascending=False)
    good = state_summary.state.iloc[0]
    okay = state_summary.state.iloc[1]
    bad = state_summary.state.iloc[2]
    index_good = np.where(states == good)
    index_okay = np.where(states == okay)
    index_bad = np.where(states == bad)
    # print(states)
    new_states = copy.copy(states)
    # print(states)
    new_states[index_good] = 0
    new_states[index_okay] = 1
    new_states[index_bad] = 2
    # dframe = pd.concat([dframe,pd.DataFrame({'game'+str(k):new_states})],axis=1)
    old_states['state' + str(k)] = pd.DataFrame({'state':states,'strike':y.tolist()})
    dframe = pd.DataFrame({'state':new_states,'event':game.event,'strike':y.tolist(),'batter':game.batter})
    D['game'+str(k)] = dframe


np.set_printoptions(suppress=True)
pd.set_option('display.height',1000)
