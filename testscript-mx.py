#!/usr/bin/python
import mxnet as mx

def ab():
    a = mx.nd.array([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
    b = mx.nd.array([[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]])
    c = mx.nd.dot(a,b)
    print (c.asnumpy())

print ("<===============")
print ("Dot product (gpu):")

gpu_device=mx.gpu(0) # Change this to mx.cpu() in absence of GPUs.
with mx.Context(gpu_device):
    ab()
