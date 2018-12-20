#!/usr/bin/python
import time
import tensorflow as tf
with tf.device('/gpu:0'):
    a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
    b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
    c = tf.matmul(a, b)

with tf.Session() as sess:
    print ("<===============")
    print ("MatMul output:")
    tstart = time.time()
    for i in range(9999):
        sess.run(c)
    print (sess.run(c))
    print ("=> 10000 Runs done in ", time.time() - tstart)

