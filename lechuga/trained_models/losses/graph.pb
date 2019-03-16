node {
  name: "InputScope/input"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: -1
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
        dim {
          size: 16
        }
        dim {
          size: 1
        }
      }
    }
  }
}
node {
  name: "y_true"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: -1
        }
        dim {
          size: 1885
        }
      }
    }
  }
}
node {
  name: "scales"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: -1
        }
        dim {
          size: 3
        }
      }
    }
  }
}
node {
  name: "Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "training"
  op: "PlaceholderWithDefault"
  input: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000\001\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.08206099271774292
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.08206099271774292
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "conv1/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "conv1/kernel/Initializer/random_uniform/max"
  input: "conv1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "conv1/kernel/Initializer/random_uniform/RandomUniform"
  input: "conv1/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/kernel/Initializer/random_uniform"
  op: "Add"
  input: "conv1/kernel/Initializer/random_uniform/mul"
  input: "conv1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/kernel/Assign"
  op: "Assign"
  input: "conv1/kernel"
  input: "conv1/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/kernel/read"
  op: "Identity"
  input: "conv1/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv1/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/bias/Assign"
  op: "Assign"
  input: "conv1/bias"
  input: "conv1/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/bias/read"
  op: "Identity"
  input: "conv1/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
}
node {
  name: "conv1/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "conv1/Conv3D"
  op: "Conv3D"
  input: "InputScope/input"
  input: "conv1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "conv1/BiasAdd"
  op: "BiasAdd"
  input: "conv1/Conv3D"
  input: "conv1/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "conv1/Relu"
  op: "Relu"
  input: "conv1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "pool1/MaxPool3D"
  op: "MaxPool3D"
  input: "conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.048112522810697556
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.048112522810697556
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "conv3/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "conv3/kernel/Initializer/random_uniform/max"
  input: "conv3/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "conv3/kernel/Initializer/random_uniform/RandomUniform"
  input: "conv3/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/kernel/Initializer/random_uniform"
  op: "Add"
  input: "conv3/kernel/Initializer/random_uniform/mul"
  input: "conv3/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/kernel/Assign"
  op: "Assign"
  input: "conv3/kernel"
  input: "conv3/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/kernel/read"
  op: "Identity"
  input: "conv3/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv3/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/bias/Assign"
  op: "Assign"
  input: "conv3/bias"
  input: "conv3/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/bias/read"
  op: "Identity"
  input: "conv3/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
}
node {
  name: "conv3/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "conv3/Conv3D"
  op: "Conv3D"
  input: "pool1/MaxPool3D"
  input: "conv3/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "conv3/BiasAdd"
  op: "BiasAdd"
  input: "conv3/Conv3D"
  input: "conv3/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "conv3/Relu"
  op: "Relu"
  input: "conv3/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "pool2/MaxPool3D"
  op: "MaxPool3D"
  input: "conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000@\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.0416666679084301
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0416666679084301
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "conv5/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "conv5/kernel/Initializer/random_uniform/max"
  input: "conv5/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "conv5/kernel/Initializer/random_uniform/RandomUniform"
  input: "conv5/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/kernel/Initializer/random_uniform"
  op: "Add"
  input: "conv5/kernel/Initializer/random_uniform/mul"
  input: "conv5/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 64
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/kernel/Assign"
  op: "Assign"
  input: "conv5/kernel"
  input: "conv5/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/kernel/read"
  op: "Identity"
  input: "conv5/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv5/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/bias/Assign"
  op: "Assign"
  input: "conv5/bias"
  input: "conv5/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/bias/read"
  op: "Identity"
  input: "conv5/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
}
node {
  name: "conv5/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "conv5/Conv3D"
  op: "Conv3D"
  input: "pool2/MaxPool3D"
  input: "conv5/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "conv5/BiasAdd"
  op: "BiasAdd"
  input: "conv5/Conv3D"
  input: "conv5/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "conv5/Relu"
  op: "Relu"
  input: "conv5/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Flatten/flatten/Shape"
  op: "Shape"
  input: "conv5/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "Flatten/flatten/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "Flatten/flatten/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "Flatten/flatten/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "Flatten/flatten/strided_slice"
  op: "StridedSlice"
  input: "Flatten/flatten/Shape"
  input: "Flatten/flatten/strided_slice/stack"
  input: "Flatten/flatten/strided_slice/stack_1"
  input: "Flatten/flatten/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "Flatten/flatten/Reshape/shape/1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "Flatten/flatten/Reshape/shape"
  op: "Pack"
  input: "Flatten/flatten/strided_slice"
  input: "Flatten/flatten/Reshape/shape/1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "Flatten/flatten/Reshape"
  op: "Reshape"
  input: "conv5/Relu"
  input: "Flatten/flatten/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "flatten/axis"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "flatten"
  op: "ConcatV2"
  input: "Flatten/flatten/Reshape"
  input: "scales"
  input: "flatten/axis"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\003@\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.01884278655052185
      }
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.01884278655052185
      }
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dense1/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "dense1/kernel/Initializer/random_uniform/max"
  input: "dense1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "dense1/kernel/Initializer/random_uniform/RandomUniform"
  input: "dense1/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/kernel/Initializer/random_uniform"
  op: "Add"
  input: "dense1/kernel/Initializer/random_uniform/mul"
  input: "dense1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 16387
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/kernel/Assign"
  op: "Assign"
  input: "dense1/kernel"
  input: "dense1/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/kernel/read"
  op: "Identity"
  input: "dense1/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dense1/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/bias/Assign"
  op: "Assign"
  input: "dense1/bias"
  input: "dense1/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/bias/read"
  op: "Identity"
  input: "dense1/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
}
node {
  name: "dense1/MatMul"
  op: "MatMul"
  input: "flatten"
  input: "dense1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "dense1/BiasAdd"
  op: "BiasAdd"
  input: "dense1/MatMul"
  input: "dense1/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "dense1/Relu"
  op: "Relu"
  input: "dense1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/gamma/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "bn_dense1/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/gamma/Assign"
  op: "Assign"
  input: "bn_dense1/gamma"
  input: "bn_dense1/gamma/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/gamma/read"
  op: "Identity"
  input: "bn_dense1/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
}
node {
  name: "bn_dense1/beta/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/beta/Assign"
  op: "Assign"
  input: "bn_dense1/beta"
  input: "bn_dense1/beta/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/beta/read"
  op: "Identity"
  input: "bn_dense1/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "bn_dense1/moving_mean/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/moving_mean"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/moving_mean/Assign"
  op: "Assign"
  input: "bn_dense1/moving_mean"
  input: "bn_dense1/moving_mean/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/moving_mean/read"
  op: "Identity"
  input: "bn_dense1/moving_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
}
node {
  name: "bn_dense1/moving_variance/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "bn_dense1/moving_variance"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/moving_variance/Assign"
  op: "Assign"
  input: "bn_dense1/moving_variance"
  input: "bn_dense1/moving_variance/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/moving_variance/read"
  op: "Identity"
  input: "bn_dense1/moving_variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
}
node {
  name: "bn_dense1/moments/mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "bn_dense1/moments/mean"
  op: "Mean"
  input: "dense1/Relu"
  input: "bn_dense1/moments/mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/moments/StopGradient"
  op: "StopGradient"
  input: "bn_dense1/moments/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/moments/SquaredDifference"
  op: "SquaredDifference"
  input: "dense1/Relu"
  input: "bn_dense1/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/moments/variance/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "bn_dense1/moments/variance"
  op: "Mean"
  input: "bn_dense1/moments/SquaredDifference"
  input: "bn_dense1/moments/variance/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/moments/Squeeze"
  op: "Squeeze"
  input: "bn_dense1/moments/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "bn_dense1/moments/Squeeze_1"
  op: "Squeeze"
  input: "bn_dense1/moments/variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "bn_dense1/cond/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond/switch_t"
  op: "Identity"
  input: "bn_dense1/cond/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond/switch_f"
  op: "Identity"
  input: "bn_dense1/cond/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond/Switch_1"
  op: "Switch"
  input: "bn_dense1/moments/Squeeze"
  input: "bn_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moments/Squeeze"
      }
    }
  }
}
node {
  name: "bn_dense1/cond/Switch_2"
  op: "Switch"
  input: "bn_dense1/moving_mean/read"
  input: "bn_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
}
node {
  name: "bn_dense1/cond/Merge"
  op: "Merge"
  input: "bn_dense1/cond/Switch_2"
  input: "bn_dense1/cond/Switch_1:1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_1/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_1/switch_t"
  op: "Identity"
  input: "bn_dense1/cond_1/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_1/switch_f"
  op: "Identity"
  input: "bn_dense1/cond_1/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_1/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_1/Switch_1"
  op: "Switch"
  input: "bn_dense1/moments/Squeeze_1"
  input: "bn_dense1/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moments/Squeeze_1"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_1/Switch_2"
  op: "Switch"
  input: "bn_dense1/moving_variance/read"
  input: "bn_dense1/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_1/Merge"
  op: "Merge"
  input: "bn_dense1/cond_1/Switch_2"
  input: "bn_dense1/cond_1/Switch_1:1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_2/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_2/switch_t"
  op: "Identity"
  input: "bn_dense1/cond_2/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_2/switch_f"
  op: "Identity"
  input: "bn_dense1/cond_2/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_2/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/decay"
  op: "Const"
  input: "^bn_dense1/cond_2/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/sub"
  op: "Sub"
  input: "bn_dense1/cond_2/AssignMovingAvg/sub/Switch:1"
  input: "bn_dense1/cond_2/AssignMovingAvg/sub/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/sub/Switch"
  op: "Switch"
  input: "bn_dense1/moving_mean/read"
  input: "bn_dense1/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/sub/Switch_1"
  op: "Switch"
  input: "bn_dense1/cond/Merge"
  input: "bn_dense1/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/cond/Merge"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/mul"
  op: "Mul"
  input: "bn_dense1/cond_2/AssignMovingAvg/sub"
  input: "bn_dense1/cond_2/AssignMovingAvg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg"
  op: "AssignSub"
  input: "bn_dense1/cond_2/AssignMovingAvg/Switch:1"
  input: "bn_dense1/cond_2/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "bn_dense1/cond_2/AssignMovingAvg/Switch"
  op: "RefSwitch"
  input: "bn_dense1/moving_mean"
  input: "bn_dense1/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_2/Switch_1"
  op: "Switch"
  input: "bn_dense1/moving_mean/read"
  input: "bn_dense1/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_2/Merge"
  op: "Merge"
  input: "bn_dense1/cond_2/Switch_1"
  input: "bn_dense1/cond_2/AssignMovingAvg"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_3/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_3/switch_t"
  op: "Identity"
  input: "bn_dense1/cond_3/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_3/switch_f"
  op: "Identity"
  input: "bn_dense1/cond_3/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_3/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/decay"
  op: "Const"
  input: "^bn_dense1/cond_3/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/sub"
  op: "Sub"
  input: "bn_dense1/cond_3/AssignMovingAvg/sub/Switch:1"
  input: "bn_dense1/cond_3/AssignMovingAvg/sub/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/sub/Switch"
  op: "Switch"
  input: "bn_dense1/moving_variance/read"
  input: "bn_dense1/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/sub/Switch_1"
  op: "Switch"
  input: "bn_dense1/cond_1/Merge"
  input: "bn_dense1/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/cond_1/Merge"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/mul"
  op: "Mul"
  input: "bn_dense1/cond_3/AssignMovingAvg/sub"
  input: "bn_dense1/cond_3/AssignMovingAvg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg"
  op: "AssignSub"
  input: "bn_dense1/cond_3/AssignMovingAvg/Switch:1"
  input: "bn_dense1/cond_3/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "bn_dense1/cond_3/AssignMovingAvg/Switch"
  op: "RefSwitch"
  input: "bn_dense1/moving_variance"
  input: "bn_dense1/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_3/Switch_1"
  op: "Switch"
  input: "bn_dense1/moving_variance/read"
  input: "bn_dense1/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
}
node {
  name: "bn_dense1/cond_3/Merge"
  op: "Merge"
  input: "bn_dense1/cond_3/Switch_1"
  input: "bn_dense1/cond_3/AssignMovingAvg"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0010000000474974513
      }
    }
  }
}
node {
  name: "bn_dense1/batchnorm/add"
  op: "Add"
  input: "bn_dense1/cond_1/Merge"
  input: "bn_dense1/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "bn_dense1/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/mul"
  op: "Mul"
  input: "bn_dense1/batchnorm/Rsqrt"
  input: "bn_dense1/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/mul_1"
  op: "Mul"
  input: "dense1/Relu"
  input: "bn_dense1/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/mul_2"
  op: "Mul"
  input: "bn_dense1/cond/Merge"
  input: "bn_dense1/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/sub"
  op: "Sub"
  input: "bn_dense1/beta/read"
  input: "bn_dense1/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_dense1/batchnorm/add_1"
  op: "Add"
  input: "bn_dense1/batchnorm/mul_1"
  input: "bn_dense1/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_dense1/cond/switch_t"
  op: "Identity"
  input: "dropout_dense1/cond/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_dense1/cond/switch_f"
  op: "Identity"
  input: "dropout_dense1/cond/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_dense1/cond/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/keep_prob"
  op: "Const"
  input: "^dropout_dense1/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/Shape"
  op: "Shape"
  input: "dropout_dense1/cond/dropout/Shape/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/Shape/Switch"
  op: "Switch"
  input: "bn_dense1/batchnorm/add_1"
  input: "dropout_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/batchnorm/add_1"
      }
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform/min"
  op: "Const"
  input: "^dropout_dense1/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform/max"
  op: "Const"
  input: "^dropout_dense1/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dropout_dense1/cond/dropout/Shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform/sub"
  op: "Sub"
  input: "dropout_dense1/cond/dropout/random_uniform/max"
  input: "dropout_dense1/cond/dropout/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform/mul"
  op: "Mul"
  input: "dropout_dense1/cond/dropout/random_uniform/RandomUniform"
  input: "dropout_dense1/cond/dropout/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/random_uniform"
  op: "Add"
  input: "dropout_dense1/cond/dropout/random_uniform/mul"
  input: "dropout_dense1/cond/dropout/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/add"
  op: "Add"
  input: "dropout_dense1/cond/dropout/keep_prob"
  input: "dropout_dense1/cond/dropout/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/Floor"
  op: "Floor"
  input: "dropout_dense1/cond/dropout/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/div"
  op: "RealDiv"
  input: "dropout_dense1/cond/dropout/Shape/Switch:1"
  input: "dropout_dense1/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/dropout/mul"
  op: "Mul"
  input: "dropout_dense1/cond/dropout/div"
  input: "dropout_dense1/cond/dropout/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/Identity"
  op: "Identity"
  input: "dropout_dense1/cond/Identity/Switch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_dense1/cond/Identity/Switch"
  op: "Switch"
  input: "bn_dense1/batchnorm/add_1"
  input: "dropout_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/batchnorm/add_1"
      }
    }
  }
}
node {
  name: "dropout_dense1/cond/Merge"
  op: "Merge"
  input: "dropout_dense1/cond/Identity"
  input: "dropout_dense1/cond/dropout/mul"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.10206207633018494
      }
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.10206207633018494
      }
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "descriptor/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "descriptor/kernel/Initializer/random_uniform/max"
  input: "descriptor/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "descriptor/kernel/Initializer/random_uniform/RandomUniform"
  input: "descriptor/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Initializer/random_uniform"
  op: "Add"
  input: "descriptor/kernel/Initializer/random_uniform/mul"
  input: "descriptor/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/kernel/Assign"
  op: "Assign"
  input: "descriptor/kernel"
  input: "descriptor/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/kernel/read"
  op: "Identity"
  input: "descriptor/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "descriptor/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/bias/Assign"
  op: "Assign"
  input: "descriptor/bias"
  input: "descriptor/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/bias/read"
  op: "Identity"
  input: "descriptor/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
}
node {
  name: "descriptor/MatMul"
  op: "MatMul"
  input: "dropout_dense1/cond/Merge"
  input: "descriptor/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "descriptor/BiasAdd"
  op: "BiasAdd"
  input: "descriptor/MatMul"
  input: "descriptor/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "descriptor/Relu"
  op: "Relu"
  input: "descriptor/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/gamma/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "bn_descriptor/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/gamma/Assign"
  op: "Assign"
  input: "bn_descriptor/gamma"
  input: "bn_descriptor/gamma/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/gamma/read"
  op: "Identity"
  input: "bn_descriptor/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
}
node {
  name: "bn_descriptor/beta/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/beta/Assign"
  op: "Assign"
  input: "bn_descriptor/beta"
  input: "bn_descriptor/beta/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/beta/read"
  op: "Identity"
  input: "bn_descriptor/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
}
node {
  name: "bn_descriptor/moving_mean/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/moving_mean"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/moving_mean/Assign"
  op: "Assign"
  input: "bn_descriptor/moving_mean"
  input: "bn_descriptor/moving_mean/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/moving_mean/read"
  op: "Identity"
  input: "bn_descriptor/moving_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
}
node {
  name: "bn_descriptor/moving_variance/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "bn_descriptor/moving_variance"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/moving_variance/Assign"
  op: "Assign"
  input: "bn_descriptor/moving_variance"
  input: "bn_descriptor/moving_variance/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/moving_variance/read"
  op: "Identity"
  input: "bn_descriptor/moving_variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
}
node {
  name: "bn_descriptor/moments/mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "bn_descriptor/moments/mean"
  op: "Mean"
  input: "descriptor/Relu"
  input: "bn_descriptor/moments/mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/moments/StopGradient"
  op: "StopGradient"
  input: "bn_descriptor/moments/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/moments/SquaredDifference"
  op: "SquaredDifference"
  input: "descriptor/Relu"
  input: "bn_descriptor/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/moments/variance/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "bn_descriptor/moments/variance"
  op: "Mean"
  input: "bn_descriptor/moments/SquaredDifference"
  input: "bn_descriptor/moments/variance/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/moments/Squeeze"
  op: "Squeeze"
  input: "bn_descriptor/moments/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "bn_descriptor/moments/Squeeze_1"
  op: "Squeeze"
  input: "bn_descriptor/moments/variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "squeeze_dims"
    value {
      list {
        i: 0
      }
    }
  }
}
node {
  name: "bn_descriptor/cond/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond/switch_t"
  op: "Identity"
  input: "bn_descriptor/cond/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond/switch_f"
  op: "Identity"
  input: "bn_descriptor/cond/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond/Switch_1"
  op: "Switch"
  input: "bn_descriptor/moments/Squeeze"
  input: "bn_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moments/Squeeze"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond/Switch_2"
  op: "Switch"
  input: "bn_descriptor/moving_mean/read"
  input: "bn_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond/Merge"
  op: "Merge"
  input: "bn_descriptor/cond/Switch_2"
  input: "bn_descriptor/cond/Switch_1:1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_1/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_1/switch_t"
  op: "Identity"
  input: "bn_descriptor/cond_1/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_1/switch_f"
  op: "Identity"
  input: "bn_descriptor/cond_1/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_1/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_1/Switch_1"
  op: "Switch"
  input: "bn_descriptor/moments/Squeeze_1"
  input: "bn_descriptor/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moments/Squeeze_1"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_1/Switch_2"
  op: "Switch"
  input: "bn_descriptor/moving_variance/read"
  input: "bn_descriptor/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_1/Merge"
  op: "Merge"
  input: "bn_descriptor/cond_1/Switch_2"
  input: "bn_descriptor/cond_1/Switch_1:1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_2/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_2/switch_t"
  op: "Identity"
  input: "bn_descriptor/cond_2/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_2/switch_f"
  op: "Identity"
  input: "bn_descriptor/cond_2/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_2/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/decay"
  op: "Const"
  input: "^bn_descriptor/cond_2/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/sub"
  op: "Sub"
  input: "bn_descriptor/cond_2/AssignMovingAvg/sub/Switch:1"
  input: "bn_descriptor/cond_2/AssignMovingAvg/sub/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/sub/Switch"
  op: "Switch"
  input: "bn_descriptor/moving_mean/read"
  input: "bn_descriptor/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/sub/Switch_1"
  op: "Switch"
  input: "bn_descriptor/cond/Merge"
  input: "bn_descriptor/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/cond/Merge"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/mul"
  op: "Mul"
  input: "bn_descriptor/cond_2/AssignMovingAvg/sub"
  input: "bn_descriptor/cond_2/AssignMovingAvg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg"
  op: "AssignSub"
  input: "bn_descriptor/cond_2/AssignMovingAvg/Switch:1"
  input: "bn_descriptor/cond_2/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "bn_descriptor/cond_2/AssignMovingAvg/Switch"
  op: "RefSwitch"
  input: "bn_descriptor/moving_mean"
  input: "bn_descriptor/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_2/Switch_1"
  op: "Switch"
  input: "bn_descriptor/moving_mean/read"
  input: "bn_descriptor/cond_2/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_2/Merge"
  op: "Merge"
  input: "bn_descriptor/cond_2/Switch_1"
  input: "bn_descriptor/cond_2/AssignMovingAvg"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_3/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_3/switch_t"
  op: "Identity"
  input: "bn_descriptor/cond_3/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_3/switch_f"
  op: "Identity"
  input: "bn_descriptor/cond_3/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_3/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/decay"
  op: "Const"
  input: "^bn_descriptor/cond_3/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/sub"
  op: "Sub"
  input: "bn_descriptor/cond_3/AssignMovingAvg/sub/Switch:1"
  input: "bn_descriptor/cond_3/AssignMovingAvg/sub/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/sub/Switch"
  op: "Switch"
  input: "bn_descriptor/moving_variance/read"
  input: "bn_descriptor/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/sub/Switch_1"
  op: "Switch"
  input: "bn_descriptor/cond_1/Merge"
  input: "bn_descriptor/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/cond_1/Merge"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/mul"
  op: "Mul"
  input: "bn_descriptor/cond_3/AssignMovingAvg/sub"
  input: "bn_descriptor/cond_3/AssignMovingAvg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg"
  op: "AssignSub"
  input: "bn_descriptor/cond_3/AssignMovingAvg/Switch:1"
  input: "bn_descriptor/cond_3/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "bn_descriptor/cond_3/AssignMovingAvg/Switch"
  op: "RefSwitch"
  input: "bn_descriptor/moving_variance"
  input: "bn_descriptor/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_3/Switch_1"
  op: "Switch"
  input: "bn_descriptor/moving_variance/read"
  input: "bn_descriptor/cond_3/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
}
node {
  name: "bn_descriptor/cond_3/Merge"
  op: "Merge"
  input: "bn_descriptor/cond_3/Switch_1"
  input: "bn_descriptor/cond_3/AssignMovingAvg"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0010000000474974513
      }
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/add"
  op: "Add"
  input: "bn_descriptor/cond_1/Merge"
  input: "bn_descriptor/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "bn_descriptor/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/mul"
  op: "Mul"
  input: "bn_descriptor/batchnorm/Rsqrt"
  input: "bn_descriptor/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/mul_1"
  op: "Mul"
  input: "descriptor/Relu"
  input: "bn_descriptor/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/mul_2"
  op: "Mul"
  input: "bn_descriptor/cond/Merge"
  input: "bn_descriptor/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/sub"
  op: "Sub"
  input: "bn_descriptor/beta/read"
  input: "bn_descriptor/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "bn_descriptor/batchnorm/add_1"
  op: "Add"
  input: "bn_descriptor/batchnorm/mul_1"
  input: "bn_descriptor/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OutputScope/descriptor_bn_read/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OutputScope/descriptor_bn_read"
  op: "Add"
  input: "bn_descriptor/batchnorm/add_1"
  input: "OutputScope/descriptor_bn_read/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OutputScope/descriptor_read/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OutputScope/descriptor_read"
  op: "Add"
  input: "descriptor/Relu"
  input: "OutputScope/descriptor_read/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/Switch"
  op: "Switch"
  input: "training"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_descriptor/cond/switch_t"
  op: "Identity"
  input: "dropout_descriptor/cond/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_descriptor/cond/switch_f"
  op: "Identity"
  input: "dropout_descriptor/cond/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_descriptor/cond/pred_id"
  op: "Identity"
  input: "training"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/keep_prob"
  op: "Const"
  input: "^dropout_descriptor/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.6499999761581421
      }
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/Shape"
  op: "Shape"
  input: "dropout_descriptor/cond/dropout/Shape/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/Shape/Switch"
  op: "Switch"
  input: "bn_descriptor/batchnorm/add_1"
  input: "dropout_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/batchnorm/add_1"
      }
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform/min"
  op: "Const"
  input: "^dropout_descriptor/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform/max"
  op: "Const"
  input: "^dropout_descriptor/cond/switch_t"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dropout_descriptor/cond/dropout/Shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform/sub"
  op: "Sub"
  input: "dropout_descriptor/cond/dropout/random_uniform/max"
  input: "dropout_descriptor/cond/dropout/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform/mul"
  op: "Mul"
  input: "dropout_descriptor/cond/dropout/random_uniform/RandomUniform"
  input: "dropout_descriptor/cond/dropout/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/random_uniform"
  op: "Add"
  input: "dropout_descriptor/cond/dropout/random_uniform/mul"
  input: "dropout_descriptor/cond/dropout/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/add"
  op: "Add"
  input: "dropout_descriptor/cond/dropout/keep_prob"
  input: "dropout_descriptor/cond/dropout/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/Floor"
  op: "Floor"
  input: "dropout_descriptor/cond/dropout/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/div"
  op: "RealDiv"
  input: "dropout_descriptor/cond/dropout/Shape/Switch:1"
  input: "dropout_descriptor/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/dropout/mul"
  op: "Mul"
  input: "dropout_descriptor/cond/dropout/div"
  input: "dropout_descriptor/cond/dropout/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/Identity"
  op: "Identity"
  input: "dropout_descriptor/cond/Identity/Switch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout_descriptor/cond/Identity/Switch"
  op: "Switch"
  input: "bn_descriptor/batchnorm/add_1"
  input: "dropout_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/batchnorm/add_1"
      }
    }
  }
}
node {
  name: "dropout_descriptor/cond/Merge"
  op: "Merge"
  input: "dropout_descriptor/cond/Identity"
  input: "dropout_descriptor/cond/dropout/mul"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000]\007\000\000"
      }
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.05548424646258354
      }
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.05548424646258354
      }
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "classes/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "classes/kernel/Initializer/random_uniform/max"
  input: "classes/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "classes/kernel/Initializer/random_uniform/RandomUniform"
  input: "classes/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/kernel/Initializer/random_uniform"
  op: "Add"
  input: "classes/kernel/Initializer/random_uniform/mul"
  input: "classes/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/kernel/Assign"
  op: "Assign"
  input: "classes/kernel"
  input: "classes/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/kernel/read"
  op: "Identity"
  input: "classes/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/bias/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1885
      }
    }
  }
}
node {
  name: "classes/bias/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "classes/bias/Initializer/zeros"
  op: "Fill"
  input: "classes/bias/Initializer/zeros/shape_as_tensor"
  input: "classes/bias/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "classes/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/bias/Assign"
  op: "Assign"
  input: "classes/bias"
  input: "classes/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/bias/read"
  op: "Identity"
  input: "classes/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
}
node {
  name: "classes/MatMul"
  op: "MatMul"
  input: "dropout_descriptor/cond/Merge"
  input: "classes/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "classes/BiasAdd"
  op: "BiasAdd"
  input: "classes/MatMul"
  input: "classes/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Rank"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Shape"
  op: "Shape"
  input: "classes/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Rank_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Shape_1"
  op: "Shape"
  input: "classes/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub"
  op: "Sub"
  input: "softmax_cross_entropy_with_logits/Rank_1"
  input: "softmax_cross_entropy_with_logits/Sub/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice/begin"
  op: "Pack"
  input: "softmax_cross_entropy_with_logits/Sub"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice"
  op: "Slice"
  input: "softmax_cross_entropy_with_logits/Shape_1"
  input: "softmax_cross_entropy_with_logits/Slice/begin"
  input: "softmax_cross_entropy_with_logits/Slice/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat/values_0"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat/axis"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat"
  op: "ConcatV2"
  input: "softmax_cross_entropy_with_logits/concat/values_0"
  input: "softmax_cross_entropy_with_logits/Slice"
  input: "softmax_cross_entropy_with_logits/concat/axis"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Reshape"
  op: "Reshape"
  input: "classes/BiasAdd"
  input: "softmax_cross_entropy_with_logits/concat"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Rank_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Shape_2"
  op: "Shape"
  input: "y_true"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub_1"
  op: "Sub"
  input: "softmax_cross_entropy_with_logits/Rank_2"
  input: "softmax_cross_entropy_with_logits/Sub_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_1/begin"
  op: "Pack"
  input: "softmax_cross_entropy_with_logits/Sub_1"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_1/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_1"
  op: "Slice"
  input: "softmax_cross_entropy_with_logits/Shape_2"
  input: "softmax_cross_entropy_with_logits/Slice_1/begin"
  input: "softmax_cross_entropy_with_logits/Slice_1/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat_1/values_0"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat_1/axis"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/concat_1"
  op: "ConcatV2"
  input: "softmax_cross_entropy_with_logits/concat_1/values_0"
  input: "softmax_cross_entropy_with_logits/Slice_1"
  input: "softmax_cross_entropy_with_logits/concat_1/axis"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Reshape_1"
  op: "Reshape"
  input: "y_true"
  input: "softmax_cross_entropy_with_logits/concat_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits"
  op: "SoftmaxCrossEntropyWithLogits"
  input: "softmax_cross_entropy_with_logits/Reshape"
  input: "softmax_cross_entropy_with_logits/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub_2/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Sub_2"
  op: "Sub"
  input: "softmax_cross_entropy_with_logits/Rank"
  input: "softmax_cross_entropy_with_logits/Sub_2/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_2/begin"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_2/size"
  op: "Pack"
  input: "softmax_cross_entropy_with_logits/Sub_2"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Slice_2"
  op: "Slice"
  input: "softmax_cross_entropy_with_logits/Shape"
  input: "softmax_cross_entropy_with_logits/Slice_2/begin"
  input: "softmax_cross_entropy_with_logits/Slice_2/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "softmax_cross_entropy_with_logits/Reshape_2"
  op: "Reshape"
  input: "softmax_cross_entropy_with_logits"
  input: "softmax_cross_entropy_with_logits/Slice_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "loss_c"
  op: "Mean"
  input: "softmax_cross_entropy_with_logits/Reshape_2"
  input: "Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000\000 \000\000"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.026958193629980087
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.026958193629980087
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dec_dense1/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "dec_dense1/kernel/Initializer/random_uniform/max"
  input: "dec_dense1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "dec_dense1/kernel/Initializer/random_uniform/RandomUniform"
  input: "dec_dense1/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Initializer/random_uniform"
  op: "Add"
  input: "dec_dense1/kernel/Initializer/random_uniform/mul"
  input: "dec_dense1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/kernel/Assign"
  op: "Assign"
  input: "dec_dense1/kernel"
  input: "dec_dense1/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/kernel/read"
  op: "Identity"
  input: "dec_dense1/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 8192
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Initializer/zeros"
  op: "Fill"
  input: "dec_dense1/bias/Initializer/zeros/shape_as_tensor"
  input: "dec_dense1/bias/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_dense1/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/bias/Assign"
  op: "Assign"
  input: "dec_dense1/bias"
  input: "dec_dense1/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/bias/read"
  op: "Identity"
  input: "dec_dense1/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
}
node {
  name: "dec_dense1/MatMul"
  op: "MatMul"
  input: "descriptor/Relu"
  input: "dec_dense1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "dec_dense1/BiasAdd"
  op: "BiasAdd"
  input: "dec_dense1/MatMul"
  input: "dec_dense1/bias/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "dec_dense1/Relu"
  op: "Relu"
  input: "dec_dense1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Shape"
  op: "Shape"
  input: "InputScope/input"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "strided_slice"
  op: "StridedSlice"
  input: "Shape"
  input: "strided_slice/stack"
  input: "strided_slice/stack_1"
  input: "strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "Reshape/shape/1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 8
      }
    }
  }
}
node {
  name: "Reshape/shape/2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 8
      }
    }
  }
}
node {
  name: "Reshape/shape/3"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "Reshape/shape/4"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 32
      }
    }
  }
}
node {
  name: "Reshape/shape"
  op: "Pack"
  input: "strided_slice"
  input: "Reshape/shape/1"
  input: "Reshape/shape/2"
  input: "Reshape/shape/3"
  input: "Reshape/shape/4"
  attr {
    key: "N"
    value {
      i: 5
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "Reshape"
  op: "Reshape"
  input: "dec_dense1/Relu"
  input: "Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.0589255653321743
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0589255653321743
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dec_conv1/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "dec_conv1/kernel/Initializer/random_uniform/max"
  input: "dec_conv1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "dec_conv1/kernel/Initializer/random_uniform/RandomUniform"
  input: "dec_conv1/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Initializer/random_uniform"
  op: "Add"
  input: "dec_conv1/kernel/Initializer/random_uniform/mul"
  input: "dec_conv1/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv1/kernel/Assign"
  op: "Assign"
  input: "dec_conv1/kernel"
  input: "dec_conv1/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv1/kernel/read"
  op: "Identity"
  input: "dec_conv1/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv1/Shape"
  op: "Shape"
  input: "Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice"
  op: "StridedSlice"
  input: "dec_conv1/Shape"
  input: "dec_conv1/strided_slice/stack"
  input: "dec_conv1/strided_slice/stack_1"
  input: "dec_conv1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv1/strided_slice_1/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_1/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 5
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_1/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_1"
  op: "StridedSlice"
  input: "dec_conv1/Shape"
  input: "dec_conv1/strided_slice_1/stack"
  input: "dec_conv1/strided_slice_1/stack_1"
  input: "dec_conv1/strided_slice_1/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv1/strided_slice_2/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_2/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_2/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_2"
  op: "StridedSlice"
  input: "dec_conv1/Shape"
  input: "dec_conv1/strided_slice_2/stack"
  input: "dec_conv1/strided_slice_2/stack_1"
  input: "dec_conv1/strided_slice_2/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv1/strided_slice_3/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_3/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_3/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_3"
  op: "StridedSlice"
  input: "dec_conv1/Shape"
  input: "dec_conv1/strided_slice_3/stack"
  input: "dec_conv1/strided_slice_3/stack_1"
  input: "dec_conv1/strided_slice_3/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv1/strided_slice_4/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_4/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_4/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv1/strided_slice_4"
  op: "StridedSlice"
  input: "dec_conv1/Shape"
  input: "dec_conv1/strided_slice_4/stack"
  input: "dec_conv1/strided_slice_4/stack_1"
  input: "dec_conv1/strided_slice_4/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv1/mul/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv1/mul"
  op: "Mul"
  input: "dec_conv1/strided_slice_2"
  input: "dec_conv1/mul/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/mul_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv1/mul_1"
  op: "Mul"
  input: "dec_conv1/strided_slice_3"
  input: "dec_conv1/mul_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/mul_2/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv1/mul_2"
  op: "Mul"
  input: "dec_conv1/strided_slice_4"
  input: "dec_conv1/mul_2/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/stack/4"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 32
      }
    }
  }
}
node {
  name: "dec_conv1/stack"
  op: "Pack"
  input: "dec_conv1/strided_slice"
  input: "dec_conv1/mul"
  input: "dec_conv1/mul_1"
  input: "dec_conv1/mul_2"
  input: "dec_conv1/stack/4"
  attr {
    key: "N"
    value {
      i: 5
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_conv1/conv3d_transpose"
  op: "Conv3DBackpropInputV2"
  input: "dec_conv1/stack"
  input: "dec_conv1/kernel/read"
  input: "Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "dec_conv1/Relu"
  op: "Relu"
  input: "dec_conv1/conv3d_transpose"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.0589255653321743
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0589255653321743
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dec_conv2/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "dec_conv2/kernel/Initializer/random_uniform/max"
  input: "dec_conv2/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "dec_conv2/kernel/Initializer/random_uniform/RandomUniform"
  input: "dec_conv2/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Initializer/random_uniform"
  op: "Add"
  input: "dec_conv2/kernel/Initializer/random_uniform/mul"
  input: "dec_conv2/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv2/kernel/Assign"
  op: "Assign"
  input: "dec_conv2/kernel"
  input: "dec_conv2/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv2/kernel/read"
  op: "Identity"
  input: "dec_conv2/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/Shape"
  op: "Shape"
  input: "dec_conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice"
  op: "StridedSlice"
  input: "dec_conv2/Shape"
  input: "dec_conv2/strided_slice/stack"
  input: "dec_conv2/strided_slice/stack_1"
  input: "dec_conv2/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv2/strided_slice_1/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_1/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 5
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_1/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_1"
  op: "StridedSlice"
  input: "dec_conv2/Shape"
  input: "dec_conv2/strided_slice_1/stack"
  input: "dec_conv2/strided_slice_1/stack_1"
  input: "dec_conv2/strided_slice_1/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv2/strided_slice_2/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_2/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_2/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_2"
  op: "StridedSlice"
  input: "dec_conv2/Shape"
  input: "dec_conv2/strided_slice_2/stack"
  input: "dec_conv2/strided_slice_2/stack_1"
  input: "dec_conv2/strided_slice_2/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv2/strided_slice_3/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_3/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_3/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_3"
  op: "StridedSlice"
  input: "dec_conv2/Shape"
  input: "dec_conv2/strided_slice_3/stack"
  input: "dec_conv2/strided_slice_3/stack_1"
  input: "dec_conv2/strided_slice_3/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv2/strided_slice_4/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_4/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_4/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_conv2/strided_slice_4"
  op: "StridedSlice"
  input: "dec_conv2/Shape"
  input: "dec_conv2/strided_slice_4/stack"
  input: "dec_conv2/strided_slice_4/stack_1"
  input: "dec_conv2/strided_slice_4/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_conv2/mul/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv2/mul"
  op: "Mul"
  input: "dec_conv2/strided_slice_2"
  input: "dec_conv2/mul/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/mul_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv2/mul_1"
  op: "Mul"
  input: "dec_conv2/strided_slice_3"
  input: "dec_conv2/mul_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/mul_2/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_conv2/mul_2"
  op: "Mul"
  input: "dec_conv2/strided_slice_4"
  input: "dec_conv2/mul_2/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/stack/4"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 32
      }
    }
  }
}
node {
  name: "dec_conv2/stack"
  op: "Pack"
  input: "dec_conv2/strided_slice"
  input: "dec_conv2/mul"
  input: "dec_conv2/mul_1"
  input: "dec_conv2/mul_2"
  input: "dec_conv2/stack/4"
  attr {
    key: "N"
    value {
      i: 5
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_conv2/conv3d_transpose"
  op: "Conv3DBackpropInputV2"
  input: "dec_conv2/stack"
  input: "dec_conv2/kernel/read"
  input: "dec_conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "dec_conv2/Relu"
  op: "Relu"
  input: "dec_conv2/conv3d_transpose"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000\001\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -0.08206099271774292
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.08206099271774292
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dec_reshape/kernel/Initializer/random_uniform/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "dec_reshape/kernel/Initializer/random_uniform/max"
  input: "dec_reshape/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "dec_reshape/kernel/Initializer/random_uniform/RandomUniform"
  input: "dec_reshape/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Initializer/random_uniform"
  op: "Add"
  input: "dec_reshape/kernel/Initializer/random_uniform/mul"
  input: "dec_reshape/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_reshape/kernel/Assign"
  op: "Assign"
  input: "dec_reshape/kernel"
  input: "dec_reshape/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_reshape/kernel/read"
  op: "Identity"
  input: "dec_reshape/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/Shape"
  op: "Shape"
  input: "dec_conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_reshape/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice"
  op: "StridedSlice"
  input: "dec_reshape/Shape"
  input: "dec_reshape/strided_slice/stack"
  input: "dec_reshape/strided_slice/stack_1"
  input: "dec_reshape/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_reshape/strided_slice_1/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_1/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 5
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_1/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_1"
  op: "StridedSlice"
  input: "dec_reshape/Shape"
  input: "dec_reshape/strided_slice_1/stack"
  input: "dec_reshape/strided_slice_1/stack_1"
  input: "dec_reshape/strided_slice_1/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_reshape/strided_slice_2/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_2/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_2/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_2"
  op: "StridedSlice"
  input: "dec_reshape/Shape"
  input: "dec_reshape/strided_slice_2/stack"
  input: "dec_reshape/strided_slice_2/stack_1"
  input: "dec_reshape/strided_slice_2/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_reshape/strided_slice_3/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_3/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_3/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_3"
  op: "StridedSlice"
  input: "dec_reshape/Shape"
  input: "dec_reshape/strided_slice_3/stack"
  input: "dec_reshape/strided_slice_3/stack_1"
  input: "dec_reshape/strided_slice_3/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_reshape/strided_slice_4/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_4/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 4
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_4/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/strided_slice_4"
  op: "StridedSlice"
  input: "dec_reshape/Shape"
  input: "dec_reshape/strided_slice_4/stack"
  input: "dec_reshape/strided_slice_4/stack_1"
  input: "dec_reshape/strided_slice_4/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "dec_reshape/mul/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/mul"
  op: "Mul"
  input: "dec_reshape/strided_slice_2"
  input: "dec_reshape/mul/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_reshape/mul_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/mul_1"
  op: "Mul"
  input: "dec_reshape/strided_slice_3"
  input: "dec_reshape/mul_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_reshape/mul_2/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/mul_2"
  op: "Mul"
  input: "dec_reshape/strided_slice_4"
  input: "dec_reshape/mul_2/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_reshape/stack/4"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "dec_reshape/stack"
  op: "Pack"
  input: "dec_reshape/strided_slice"
  input: "dec_reshape/mul"
  input: "dec_reshape/mul_1"
  input: "dec_reshape/mul_2"
  input: "dec_reshape/stack/4"
  attr {
    key: "N"
    value {
      i: 5
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "dec_reshape/conv3d_transpose"
  op: "Conv3DBackpropInputV2"
  input: "dec_reshape/stack"
  input: "dec_reshape/kernel/read"
  input: "dec_conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "dec_reshape/Sigmoid"
  op: "Sigmoid"
  input: "dec_reshape/conv3d_transpose"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "ReconstructionScopeAE/ae_reconstruction_read/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "ReconstructionScopeAE/ae_reconstruction_read"
  op: "Add"
  input: "dec_reshape/Sigmoid"
  input: "ReconstructionScopeAE/ae_reconstruction_read/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "mul"
  op: "Mul"
  input: "mul/x"
  input: "InputScope/input"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.000000013351432e-10
      }
    }
  }
}
node {
  name: "add"
  op: "Add"
  input: "dec_reshape/Sigmoid"
  input: "add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Log"
  op: "Log"
  input: "add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul_1"
  op: "Mul"
  input: "mul"
  input: "Log"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "sub/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "sub"
  op: "Sub"
  input: "sub/x"
  input: "InputScope/input"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul_2/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.10000000149011612
      }
    }
  }
}
node {
  name: "mul_2"
  op: "Mul"
  input: "mul_2/x"
  input: "sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "sub_1/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "sub_1"
  op: "Sub"
  input: "sub_1/x"
  input: "dec_reshape/Sigmoid"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.000000013351432e-10
      }
    }
  }
}
node {
  name: "add_1"
  op: "Add"
  input: "sub_1"
  input: "add_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Log_1"
  op: "Log"
  input: "add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul_3"
  op: "Mul"
  input: "mul_2"
  input: "Log_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_2"
  op: "Add"
  input: "mul_1"
  input: "mul_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\000\000\000\000\001\000\000\000\002\000\000\000\003\000\000\000\004\000\000\000"
      }
    }
  }
}
node {
  name: "Mean"
  op: "Mean"
  input: "add_2"
  input: "Const_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "Neg"
  op: "Neg"
  input: "Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "loss_r"
  op: "Identity"
  input: "Neg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul_4/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "mul_4"
  op: "Mul"
  input: "mul_4/x"
  input: "loss_c"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul_5/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 200.0
      }
    }
  }
}
node {
  name: "mul_5"
  op: "Mul"
  input: "mul_5/x"
  input: "Neg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "loss"
  op: "Add"
  input: "mul_4"
  input: "mul_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "global_step/initial_value"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "global_step"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "global_step/Assign"
  op: "Assign"
  input: "global_step"
  input: "global_step/initial_value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@global_step"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "global_step/read"
  op: "Identity"
  input: "global_step"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@global_step"
      }
    }
  }
}
node {
  name: "Const_3"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "Add"
  op: "Add"
  input: "global_step/read"
  input: "Const_3"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "update_step"
  op: "Assign"
  input: "global_step"
  input: "Add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@global_step"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "gradients/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/grad_ys_0"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "gradients/Fill"
  op: "Fill"
  input: "gradients/Shape"
  input: "gradients/grad_ys_0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Fill"
}
node {
  name: "gradients/loss_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/Fill"
  input: "^gradients/loss_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/Fill"
      }
    }
  }
}
node {
  name: "gradients/loss_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/Fill"
  input: "^gradients/loss_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/Fill"
      }
    }
  }
}
node {
  name: "gradients/mul_4_grad/Mul"
  op: "Mul"
  input: "gradients/loss_grad/tuple/control_dependency"
  input: "loss_c"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_4_grad/Mul_1"
  op: "Mul"
  input: "gradients/loss_grad/tuple/control_dependency"
  input: "mul_4/x"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_4_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_4_grad/Mul"
  input: "^gradients/mul_4_grad/Mul_1"
}
node {
  name: "gradients/mul_4_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/mul_4_grad/Mul"
  input: "^gradients/mul_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_4_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/mul_4_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/mul_4_grad/Mul_1"
  input: "^gradients/mul_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_4_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/mul_5_grad/Mul"
  op: "Mul"
  input: "gradients/loss_grad/tuple/control_dependency_1"
  input: "Neg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_5_grad/Mul_1"
  op: "Mul"
  input: "gradients/loss_grad/tuple/control_dependency_1"
  input: "mul_5/x"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_5_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_5_grad/Mul"
  input: "^gradients/mul_5_grad/Mul_1"
}
node {
  name: "gradients/mul_5_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/mul_5_grad/Mul"
  input: "^gradients/mul_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_5_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/mul_5_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/mul_5_grad/Mul_1"
  input: "^gradients/mul_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_5_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Reshape/shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Reshape"
  op: "Reshape"
  input: "gradients/mul_4_grad/tuple/control_dependency_1"
  input: "gradients/loss_c_grad/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/Shape"
  op: "Shape"
  input: "softmax_cross_entropy_with_logits/Reshape_2"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/Tile"
  op: "Tile"
  input: "gradients/loss_c_grad/Reshape"
  input: "gradients/loss_c_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/Shape_1"
  op: "Shape"
  input: "softmax_cross_entropy_with_logits/Reshape_2"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/Shape_2"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Prod"
  op: "Prod"
  input: "gradients/loss_c_grad/Shape_1"
  input: "gradients/loss_c_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/loss_c_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Prod_1"
  op: "Prod"
  input: "gradients/loss_c_grad/Shape_2"
  input: "gradients/loss_c_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/loss_c_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/loss_c_grad/Maximum"
  op: "Maximum"
  input: "gradients/loss_c_grad/Prod_1"
  input: "gradients/loss_c_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/loss_c_grad/Prod"
  input: "gradients/loss_c_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/Cast"
  op: "Cast"
  input: "gradients/loss_c_grad/floordiv"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/loss_c_grad/truediv"
  op: "RealDiv"
  input: "gradients/loss_c_grad/Tile"
  input: "gradients/loss_c_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Neg_grad/Neg"
  op: "Neg"
  input: "gradients/mul_5_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Shape"
  op: "Shape"
  input: "softmax_cross_entropy_with_logits"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Reshape"
  op: "Reshape"
  input: "gradients/loss_c_grad/truediv"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Reshape/shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/Mean_grad/Reshape"
  op: "Reshape"
  input: "gradients/Neg_grad/Neg"
  input: "gradients/Mean_grad/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Shape"
  op: "Shape"
  input: "add_2"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Tile"
  op: "Tile"
  input: "gradients/Mean_grad/Reshape"
  input: "gradients/Mean_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Shape_1"
  op: "Shape"
  input: "add_2"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Shape_2"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/Mean_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/Mean_grad/Prod"
  op: "Prod"
  input: "gradients/Mean_grad/Shape_1"
  input: "gradients/Mean_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/Mean_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/Mean_grad/Prod_1"
  op: "Prod"
  input: "gradients/Mean_grad/Shape_2"
  input: "gradients/Mean_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/Mean_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/Mean_grad/Maximum"
  op: "Maximum"
  input: "gradients/Mean_grad/Prod_1"
  input: "gradients/Mean_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/Mean_grad/Prod"
  input: "gradients/Mean_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/Cast"
  op: "Cast"
  input: "gradients/Mean_grad/floordiv"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Mean_grad/truediv"
  op: "RealDiv"
  input: "gradients/Mean_grad/Tile"
  input: "gradients/Mean_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/zeros_like"
  op: "ZerosLike"
  input: "softmax_cross_entropy_with_logits:1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims/dim"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims"
  op: "ExpandDims"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Reshape"
  input: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/mul"
  op: "Mul"
  input: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims"
  input: "softmax_cross_entropy_with_logits:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/LogSoftmax"
  op: "LogSoftmax"
  input: "softmax_cross_entropy_with_logits/Reshape"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/Neg"
  op: "Neg"
  input: "gradients/softmax_cross_entropy_with_logits_grad/LogSoftmax"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dim"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims_1"
  op: "ExpandDims"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Reshape"
  input: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/mul_1"
  op: "Mul"
  input: "gradients/softmax_cross_entropy_with_logits_grad/ExpandDims_1"
  input: "gradients/softmax_cross_entropy_with_logits_grad/Neg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/softmax_cross_entropy_with_logits_grad/mul"
  input: "^gradients/softmax_cross_entropy_with_logits_grad/mul_1"
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/softmax_cross_entropy_with_logits_grad/mul"
  input: "^gradients/softmax_cross_entropy_with_logits_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/softmax_cross_entropy_with_logits_grad/mul"
      }
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/softmax_cross_entropy_with_logits_grad/mul_1"
  input: "^gradients/softmax_cross_entropy_with_logits_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/softmax_cross_entropy_with_logits_grad/mul_1"
      }
    }
  }
}
node {
  name: "gradients/add_2_grad/Shape"
  op: "Shape"
  input: "mul_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_2_grad/Shape_1"
  op: "Shape"
  input: "mul_3"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_2_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/add_2_grad/Shape"
  input: "gradients/add_2_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_2_grad/Sum"
  op: "Sum"
  input: "gradients/Mean_grad/truediv"
  input: "gradients/add_2_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_2_grad/Reshape"
  op: "Reshape"
  input: "gradients/add_2_grad/Sum"
  input: "gradients/add_2_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_2_grad/Sum_1"
  op: "Sum"
  input: "gradients/Mean_grad/truediv"
  input: "gradients/add_2_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_2_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/add_2_grad/Sum_1"
  input: "gradients/add_2_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_2_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/add_2_grad/Reshape"
  input: "^gradients/add_2_grad/Reshape_1"
}
node {
  name: "gradients/add_2_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/add_2_grad/Reshape"
  input: "^gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_2_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/add_2_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/add_2_grad/Reshape_1"
  input: "^gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_2_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Shape"
  op: "Shape"
  input: "classes/BiasAdd"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
  op: "Reshape"
  input: "gradients/softmax_cross_entropy_with_logits_grad/tuple/control_dependency"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/Shape"
  op: "Shape"
  input: "mul"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/Shape_1"
  op: "Shape"
  input: "Log"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/mul_1_grad/Shape"
  input: "gradients/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/Mul"
  op: "Mul"
  input: "gradients/add_2_grad/tuple/control_dependency"
  input: "Log"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_1_grad/Sum"
  op: "Sum"
  input: "gradients/mul_1_grad/Mul"
  input: "gradients/mul_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/mul_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/mul_1_grad/Sum"
  input: "gradients/mul_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/Mul_1"
  op: "Mul"
  input: "mul"
  input: "gradients/add_2_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/mul_1_grad/Mul_1"
  input: "gradients/mul_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/mul_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/mul_1_grad/Sum_1"
  input: "gradients/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_1_grad/Reshape"
  input: "^gradients/mul_1_grad/Reshape_1"
}
node {
  name: "gradients/mul_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/mul_1_grad/Reshape"
  input: "^gradients/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/mul_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/mul_1_grad/Reshape_1"
  input: "^gradients/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/mul_3_grad/Shape"
  op: "Shape"
  input: "mul_2"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_3_grad/Shape_1"
  op: "Shape"
  input: "Log_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_3_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/mul_3_grad/Shape"
  input: "gradients/mul_3_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_3_grad/Mul"
  op: "Mul"
  input: "gradients/add_2_grad/tuple/control_dependency_1"
  input: "Log_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_3_grad/Sum"
  op: "Sum"
  input: "gradients/mul_3_grad/Mul"
  input: "gradients/mul_3_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/mul_3_grad/Reshape"
  op: "Reshape"
  input: "gradients/mul_3_grad/Sum"
  input: "gradients/mul_3_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_3_grad/Mul_1"
  op: "Mul"
  input: "mul_2"
  input: "gradients/add_2_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/mul_3_grad/Sum_1"
  op: "Sum"
  input: "gradients/mul_3_grad/Mul_1"
  input: "gradients/mul_3_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/mul_3_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/mul_3_grad/Sum_1"
  input: "gradients/mul_3_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/mul_3_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_3_grad/Reshape"
  input: "^gradients/mul_3_grad/Reshape_1"
}
node {
  name: "gradients/mul_3_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/mul_3_grad/Reshape"
  input: "^gradients/mul_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_3_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/mul_3_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/mul_3_grad/Reshape_1"
  input: "^gradients/mul_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/mul_3_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/Log_grad/Reciprocal"
  op: "Reciprocal"
  input: "add"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_1_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Log_grad/mul"
  op: "Mul"
  input: "gradients/mul_1_grad/tuple/control_dependency_1"
  input: "gradients/Log_grad/Reciprocal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Log_1_grad/Reciprocal"
  op: "Reciprocal"
  input: "add_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/mul_3_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Log_1_grad/mul"
  op: "Mul"
  input: "gradients/mul_3_grad/tuple/control_dependency_1"
  input: "gradients/Log_1_grad/Reciprocal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/add_grad/Shape"
  op: "Shape"
  input: "dec_reshape/Sigmoid"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/add_grad/Shape"
  input: "gradients/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_grad/Sum"
  op: "Sum"
  input: "gradients/Log_grad/mul"
  input: "gradients/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_grad/Reshape"
  op: "Reshape"
  input: "gradients/add_grad/Sum"
  input: "gradients/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_grad/Sum_1"
  op: "Sum"
  input: "gradients/Log_grad/mul"
  input: "gradients/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/add_grad/Sum_1"
  input: "gradients/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/add_grad/Reshape"
  input: "^gradients/add_grad/Reshape_1"
}
node {
  name: "gradients/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/add_grad/Reshape"
  input: "^gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/add_grad/Reshape_1"
  input: "^gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/add_1_grad/Shape"
  op: "Shape"
  input: "sub_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_1_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/add_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/add_1_grad/Shape"
  input: "gradients/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_1_grad/Sum"
  op: "Sum"
  input: "gradients/Log_1_grad/mul"
  input: "gradients/add_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/add_1_grad/Sum"
  input: "gradients/add_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/Log_1_grad/mul"
  input: "gradients/add_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/add_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/add_1_grad/Sum_1"
  input: "gradients/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/add_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/add_1_grad/Reshape"
  input: "^gradients/add_1_grad/Reshape_1"
}
node {
  name: "gradients/add_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/add_1_grad/Reshape"
  input: "^gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/add_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/add_1_grad/Reshape_1"
  input: "^gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/sub_1_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/sub_1_grad/Shape_1"
  op: "Shape"
  input: "dec_reshape/Sigmoid"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/sub_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/sub_1_grad/Shape"
  input: "gradients/sub_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/sub_1_grad/Sum"
  op: "Sum"
  input: "gradients/add_1_grad/tuple/control_dependency"
  input: "gradients/sub_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/sub_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/sub_1_grad/Sum"
  input: "gradients/sub_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/sub_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/add_1_grad/tuple/control_dependency"
  input: "gradients/sub_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/sub_1_grad/Neg"
  op: "Neg"
  input: "gradients/sub_1_grad/Sum_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/sub_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/sub_1_grad/Neg"
  input: "gradients/sub_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/sub_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/sub_1_grad/Reshape"
  input: "^gradients/sub_1_grad/Reshape_1"
}
node {
  name: "gradients/sub_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/sub_1_grad/Reshape"
  input: "^gradients/sub_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/sub_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/sub_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/sub_1_grad/Reshape_1"
  input: "^gradients/sub_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/sub_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/classes/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/classes/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/classes/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
}
node {
  name: "gradients/classes/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
  input: "^gradients/classes/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/classes/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/classes/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/classes/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/AddN"
  op: "AddN"
  input: "gradients/add_grad/tuple/control_dependency"
  input: "gradients/sub_1_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/Sigmoid_grad/SigmoidGrad"
  op: "SigmoidGrad"
  input: "dec_reshape/Sigmoid"
  input: "gradients/AddN"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/classes/MatMul_grad/MatMul"
  op: "MatMul"
  input: "gradients/classes/BiasAdd_grad/tuple/control_dependency"
  input: "classes/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "gradients/classes/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "dropout_descriptor/cond/Merge"
  input: "gradients/classes/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/classes/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/classes/MatMul_grad/MatMul"
  input: "^gradients/classes/MatMul_grad/MatMul_1"
}
node {
  name: "gradients/classes/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/classes/MatMul_grad/MatMul"
  input: "^gradients/classes/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/classes/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/classes/MatMul_grad/MatMul_1"
  input: "^gradients/classes/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000\001\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "gradients/dec_reshape/Sigmoid_grad/SigmoidGrad"
  input: "gradients/dec_reshape/conv3d_transpose_grad/Shape"
  input: "dec_conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/Conv3D"
  op: "Conv3D"
  input: "gradients/dec_reshape/Sigmoid_grad/SigmoidGrad"
  input: "dec_reshape/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dec_reshape/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_reshape/conv3d_transpose_grad/Conv3DBackpropFilterV2"
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dec_reshape/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  input: "^gradients/dec_reshape/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_reshape/conv3d_transpose_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "gradients/dec_reshape/conv3d_transpose_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dec_reshape/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_reshape/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_reshape/conv3d_transpose_grad/Conv3D"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/classes/MatMul_grad/tuple/control_dependency"
  input: "dropout_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_descriptor/cond/Merge_grad/cond_grad"
}
node {
  name: "gradients/dropout_descriptor/cond/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/Merge_grad/cond_grad"
  input: "^gradients/dropout_descriptor/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/Merge_grad/cond_grad:1"
  input: "^gradients/dropout_descriptor/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/classes/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape"
  op: "Shape"
  input: "dropout_descriptor/cond/dropout/div"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape_1"
  op: "Shape"
  input: "dropout_descriptor/cond/dropout/Floor"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Mul"
  op: "Mul"
  input: "gradients/dropout_descriptor/cond/Merge_grad/tuple/control_dependency_1"
  input: "dropout_descriptor/cond/dropout/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Sum"
  op: "Sum"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Mul"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape"
  op: "Reshape"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Sum"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Mul_1"
  op: "Mul"
  input: "dropout_descriptor/cond/dropout/div"
  input: "gradients/dropout_descriptor/cond/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Sum_1"
  op: "Sum"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Mul_1"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Sum_1"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape"
  input: "^gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape_1"
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape"
  input: "^gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape_1"
  input: "^gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_descriptor/cond/dropout/mul_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/Switch"
  op: "Switch"
  input: "bn_descriptor/batchnorm/add_1"
  input: "dropout_descriptor/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_1"
  op: "Shape"
  input: "gradients/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros"
  op: "Fill"
  input: "gradients/Shape_1"
  input: "gradients/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/Identity/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/dropout_descriptor/cond/Merge_grad/tuple/control_dependency"
  input: "gradients/zeros"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape"
  op: "Shape"
  input: "dropout_descriptor/cond/dropout/Shape/Switch:1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv"
  op: "RealDiv"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/control_dependency"
  input: "dropout_descriptor/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Sum"
  op: "Sum"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Reshape"
  op: "Reshape"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Sum"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Neg"
  op: "Neg"
  input: "dropout_descriptor/cond/dropout/Shape/Switch:1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv_1"
  op: "RealDiv"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Neg"
  input: "dropout_descriptor/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv_2"
  op: "RealDiv"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv_1"
  input: "dropout_descriptor/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/mul"
  op: "Mul"
  input: "gradients/dropout_descriptor/cond/dropout/mul_grad/tuple/control_dependency"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/RealDiv_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Sum_1"
  op: "Sum"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/mul"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Sum_1"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_descriptor/cond/dropout/div_grad/Reshape"
  input: "^gradients/dropout_descriptor/cond/dropout/div_grad/Reshape_1"
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Reshape"
  input: "^gradients/dropout_descriptor/cond/dropout/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_descriptor/cond/dropout/div_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/div_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/Reshape_1"
  input: "^gradients/dropout_descriptor/cond/dropout/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_descriptor/cond/dropout/div_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/dec_conv2/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/dec_reshape/conv3d_transpose_grad/tuple/control_dependency_1"
  input: "dec_conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "gradients/dec_conv2/Relu_grad/ReluGrad"
  input: "gradients/dec_conv2/conv3d_transpose_grad/Shape"
  input: "dec_conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/Conv3D"
  op: "Conv3D"
  input: "gradients/dec_conv2/Relu_grad/ReluGrad"
  input: "dec_conv2/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dec_conv2/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_conv2/conv3d_transpose_grad/Conv3DBackpropFilterV2"
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dec_conv2/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  input: "^gradients/dec_conv2/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_conv2/conv3d_transpose_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "gradients/dec_conv2/conv3d_transpose_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dec_conv2/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_conv2/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_conv2/conv3d_transpose_grad/Conv3D"
      }
    }
  }
}
node {
  name: "gradients/Switch_1"
  op: "Switch"
  input: "bn_descriptor/batchnorm/add_1"
  input: "dropout_descriptor/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_2"
  op: "Shape"
  input: "gradients/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_1/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_1"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_1"
  op: "Fill"
  input: "gradients/Shape_2"
  input: "gradients/zeros_1/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_descriptor/cond/dropout/Shape/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_1"
  input: "gradients/dropout_descriptor/cond/dropout/div_grad/tuple/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/AddN_1"
  op: "AddN"
  input: "gradients/dropout_descriptor/cond/Identity/Switch_grad/cond_grad"
  input: "gradients/dropout_descriptor/cond/dropout/Shape/Switch_grad/cond_grad"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_descriptor/cond/Identity/Switch_grad/cond_grad"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape"
  op: "Shape"
  input: "bn_descriptor/batchnorm/mul_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 64
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Sum"
  op: "Sum"
  input: "gradients/AddN_1"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Sum"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/AddN_1"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Sum_1"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/add_1_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/add_1_grad/Reshape_1"
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/Reshape_1"
  input: "^gradients/bn_descriptor/batchnorm/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape"
  op: "Shape"
  input: "descriptor/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 64
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Mul"
  op: "Mul"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency"
  input: "bn_descriptor/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Sum"
  op: "Sum"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Mul"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Sum"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Mul_1"
  op: "Mul"
  input: "descriptor/Relu"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Mul_1"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Sum_1"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape_1"
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape_1"
  input: "^gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/sub_grad/Neg"
  op: "Neg"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency_1"
  input: "^gradients/bn_descriptor/batchnorm/sub_grad/Neg"
}
node {
  name: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/add_1_grad/tuple/control_dependency_1"
  input: "^gradients/bn_descriptor/batchnorm/sub_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/sub_grad/Neg"
  input: "^gradients/bn_descriptor/batchnorm/sub_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/sub_grad/Neg"
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/dec_conv2/conv3d_transpose_grad/tuple/control_dependency_1"
  input: "dec_conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
  op: "Mul"
  input: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/control_dependency_1"
  input: "bn_descriptor/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_2_grad/Mul_1"
  op: "Mul"
  input: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/control_dependency_1"
  input: "bn_descriptor/cond/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
  input: "^gradients/bn_descriptor/batchnorm/mul_2_grad/Mul_1"
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
  input: "^gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_2_grad/Mul_1"
  input: "^gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_2_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "gradients/dec_conv1/Relu_grad/ReluGrad"
  input: "gradients/dec_conv1/conv3d_transpose_grad/Shape"
  input: "Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/Conv3D"
  op: "Conv3D"
  input: "gradients/dec_conv1/Relu_grad/ReluGrad"
  input: "dec_conv1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dec_conv1/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_conv1/conv3d_transpose_grad/Conv3DBackpropFilterV2"
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dec_conv1/conv3d_transpose_grad/Conv3DBackpropFilterV2"
  input: "^gradients/dec_conv1/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_conv1/conv3d_transpose_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "gradients/dec_conv1/conv3d_transpose_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dec_conv1/conv3d_transpose_grad/Conv3D"
  input: "^gradients/dec_conv1/conv3d_transpose_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_conv1/conv3d_transpose_grad/Conv3D"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/control_dependency"
  input: "bn_descriptor/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/cond/Merge_grad/cond_grad"
}
node {
  name: "gradients/bn_descriptor/cond/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/cond/Merge_grad/cond_grad"
  input: "^gradients/bn_descriptor/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/cond/Merge_grad/cond_grad:1"
  input: "^gradients/bn_descriptor/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/AddN_2"
  op: "AddN"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/control_dependency_1"
  input: "gradients/bn_descriptor/batchnorm/mul_2_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_grad/Mul"
  op: "Mul"
  input: "gradients/AddN_2"
  input: "bn_descriptor/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_grad/Mul_1"
  op: "Mul"
  input: "gradients/AddN_2"
  input: "bn_descriptor/batchnorm/Rsqrt"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/mul_grad/Mul"
  input: "^gradients/bn_descriptor/batchnorm/mul_grad/Mul_1"
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_grad/Mul"
  input: "^gradients/bn_descriptor/batchnorm/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/mul_grad/Mul_1"
  input: "^gradients/bn_descriptor/batchnorm/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/Switch_2"
  op: "Switch"
  input: "bn_descriptor/moments/Squeeze"
  input: "bn_descriptor/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_3"
  op: "Shape"
  input: "gradients/Switch_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_2/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_2"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_2"
  op: "Fill"
  input: "gradients/Shape_3"
  input: "gradients/zeros_2/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond/Switch_1_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_2"
  input: "gradients/bn_descriptor/cond/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/Rsqrt_grad/RsqrtGrad"
  op: "RsqrtGrad"
  input: "bn_descriptor/batchnorm/Rsqrt"
  input: "gradients/bn_descriptor/batchnorm/mul_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/Squeeze_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/Squeeze_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/cond/Switch_1_grad/cond_grad"
  input: "gradients/bn_descriptor/moments/Squeeze_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 64
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Shape"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Sum"
  op: "Sum"
  input: "gradients/bn_descriptor/batchnorm/Rsqrt_grad/RsqrtGrad"
  input: "gradients/bn_descriptor/batchnorm/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Sum"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_descriptor/batchnorm/Rsqrt_grad/RsqrtGrad"
  input: "gradients/bn_descriptor/batchnorm/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Sum_1"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/batchnorm/add_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/add_grad/Reshape_1"
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Reshape"
  input: "^gradients/bn_descriptor/batchnorm/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/batchnorm/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/batchnorm/add_grad/Reshape_1"
  input: "^gradients/bn_descriptor/batchnorm/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond_1/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/bn_descriptor/batchnorm/add_grad/tuple/control_dependency"
  input: "bn_descriptor/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond_1/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/cond_1/Merge_grad/cond_grad"
}
node {
  name: "gradients/bn_descriptor/cond_1/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/cond_1/Merge_grad/cond_grad"
  input: "^gradients/bn_descriptor/cond_1/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond_1/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/cond_1/Merge_grad/cond_grad:1"
  input: "^gradients/bn_descriptor/cond_1/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/Switch_3"
  op: "Switch"
  input: "bn_descriptor/moments/Squeeze_1"
  input: "bn_descriptor/cond_1/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_4"
  op: "Shape"
  input: "gradients/Switch_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_3/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_3"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_3"
  op: "Fill"
  input: "gradients/Shape_4"
  input: "gradients/zeros_3/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/cond_1/Switch_1_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_3"
  input: "gradients/bn_descriptor/cond_1/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Reshape_grad/Shape"
  op: "Shape"
  input: "dec_dense1/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Reshape_grad/Reshape"
  op: "Reshape"
  input: "gradients/dec_conv1/conv3d_transpose_grad/tuple/control_dependency_1"
  input: "gradients/Reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/Squeeze_1_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/Squeeze_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/cond_1/Switch_1_grad/cond_grad"
  input: "gradients/bn_descriptor/moments/Squeeze_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dec_dense1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/Reshape_grad/Reshape"
  input: "dec_dense1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Shape"
  op: "Shape"
  input: "bn_descriptor/moments/SquaredDifference"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Size"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/add"
  op: "Add"
  input: "bn_descriptor/moments/variance/reduction_indices"
  input: "gradients/bn_descriptor/moments/variance_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/mod"
  op: "FloorMod"
  input: "gradients/bn_descriptor/moments/variance_grad/add"
  input: "gradients/bn_descriptor/moments/variance_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/range/start"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/range/delta"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/range"
  op: "Range"
  input: "gradients/bn_descriptor/moments/variance_grad/range/start"
  input: "gradients/bn_descriptor/moments/variance_grad/Size"
  input: "gradients/bn_descriptor/moments/variance_grad/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Fill/value"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Fill"
  op: "Fill"
  input: "gradients/bn_descriptor/moments/variance_grad/Shape_1"
  input: "gradients/bn_descriptor/moments/variance_grad/Fill/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/DynamicStitch"
  op: "DynamicStitch"
  input: "gradients/bn_descriptor/moments/variance_grad/range"
  input: "gradients/bn_descriptor/moments/variance_grad/mod"
  input: "gradients/bn_descriptor/moments/variance_grad/Shape"
  input: "gradients/bn_descriptor/moments/variance_grad/Fill"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Maximum"
  op: "Maximum"
  input: "gradients/bn_descriptor/moments/variance_grad/DynamicStitch"
  input: "gradients/bn_descriptor/moments/variance_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/bn_descriptor/moments/variance_grad/Shape"
  input: "gradients/bn_descriptor/moments/variance_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/moments/Squeeze_1_grad/Reshape"
  input: "gradients/bn_descriptor/moments/variance_grad/DynamicStitch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Tile"
  op: "Tile"
  input: "gradients/bn_descriptor/moments/variance_grad/Reshape"
  input: "gradients/bn_descriptor/moments/variance_grad/floordiv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Shape_2"
  op: "Shape"
  input: "bn_descriptor/moments/SquaredDifference"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Shape_3"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Prod"
  op: "Prod"
  input: "gradients/bn_descriptor/moments/variance_grad/Shape_2"
  input: "gradients/bn_descriptor/moments/variance_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Prod_1"
  op: "Prod"
  input: "gradients/bn_descriptor/moments/variance_grad/Shape_3"
  input: "gradients/bn_descriptor/moments/variance_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Maximum_1/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Maximum_1"
  op: "Maximum"
  input: "gradients/bn_descriptor/moments/variance_grad/Prod_1"
  input: "gradients/bn_descriptor/moments/variance_grad/Maximum_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/floordiv_1"
  op: "FloorDiv"
  input: "gradients/bn_descriptor/moments/variance_grad/Prod"
  input: "gradients/bn_descriptor/moments/variance_grad/Maximum_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/Cast"
  op: "Cast"
  input: "gradients/bn_descriptor/moments/variance_grad/floordiv_1"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/variance_grad/truediv"
  op: "RealDiv"
  input: "gradients/bn_descriptor/moments/variance_grad/Tile"
  input: "gradients/bn_descriptor/moments/variance_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dec_dense1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/dec_dense1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/dec_dense1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dec_dense1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/dec_dense1/Relu_grad/ReluGrad"
}
node {
  name: "gradients/dec_dense1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dec_dense1/Relu_grad/ReluGrad"
  input: "^gradients/dec_dense1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_dense1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/dec_dense1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dec_dense1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/dec_dense1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_dense1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape"
  op: "Shape"
  input: "descriptor/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/scalar"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/moments/variance_grad/truediv"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/mul"
  op: "Mul"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/scalar"
  input: "gradients/bn_descriptor/moments/variance_grad/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/sub"
  op: "Sub"
  input: "descriptor/Relu"
  input: "bn_descriptor/moments/StopGradient"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/moments/variance_grad/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/mul_1"
  op: "Mul"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/mul"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Sum"
  op: "Sum"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/mul_1"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Sum"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/mul_1"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Sum_1"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/Neg"
  op: "Neg"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_descriptor/moments/SquaredDifference_grad/Neg"
  input: "^gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape"
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape"
  input: "^gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/SquaredDifference_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/Neg"
  input: "^gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/SquaredDifference_grad/Neg"
      }
    }
  }
}
node {
  name: "gradients/dec_dense1/MatMul_grad/MatMul"
  op: "MatMul"
  input: "gradients/dec_dense1/BiasAdd_grad/tuple/control_dependency"
  input: "dec_dense1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "gradients/dec_dense1/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "descriptor/Relu"
  input: "gradients/dec_dense1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dec_dense1/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dec_dense1/MatMul_grad/MatMul"
  input: "^gradients/dec_dense1/MatMul_grad/MatMul_1"
}
node {
  name: "gradients/dec_dense1/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dec_dense1/MatMul_grad/MatMul"
  input: "^gradients/dec_dense1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_dense1/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dec_dense1/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dec_dense1/MatMul_grad/MatMul_1"
  input: "^gradients/dec_dense1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dec_dense1/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Shape"
  op: "Shape"
  input: "descriptor/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Size"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/add"
  op: "Add"
  input: "bn_descriptor/moments/mean/reduction_indices"
  input: "gradients/bn_descriptor/moments/mean_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/mod"
  op: "FloorMod"
  input: "gradients/bn_descriptor/moments/mean_grad/add"
  input: "gradients/bn_descriptor/moments/mean_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/range/start"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/range/delta"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/range"
  op: "Range"
  input: "gradients/bn_descriptor/moments/mean_grad/range/start"
  input: "gradients/bn_descriptor/moments/mean_grad/Size"
  input: "gradients/bn_descriptor/moments/mean_grad/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Fill/value"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Fill"
  op: "Fill"
  input: "gradients/bn_descriptor/moments/mean_grad/Shape_1"
  input: "gradients/bn_descriptor/moments/mean_grad/Fill/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/DynamicStitch"
  op: "DynamicStitch"
  input: "gradients/bn_descriptor/moments/mean_grad/range"
  input: "gradients/bn_descriptor/moments/mean_grad/mod"
  input: "gradients/bn_descriptor/moments/mean_grad/Shape"
  input: "gradients/bn_descriptor/moments/mean_grad/Fill"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Maximum"
  op: "Maximum"
  input: "gradients/bn_descriptor/moments/mean_grad/DynamicStitch"
  input: "gradients/bn_descriptor/moments/mean_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/bn_descriptor/moments/mean_grad/Shape"
  input: "gradients/bn_descriptor/moments/mean_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_descriptor/moments/Squeeze_grad/Reshape"
  input: "gradients/bn_descriptor/moments/mean_grad/DynamicStitch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Tile"
  op: "Tile"
  input: "gradients/bn_descriptor/moments/mean_grad/Reshape"
  input: "gradients/bn_descriptor/moments/mean_grad/floordiv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Shape_2"
  op: "Shape"
  input: "descriptor/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Shape_3"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Prod"
  op: "Prod"
  input: "gradients/bn_descriptor/moments/mean_grad/Shape_2"
  input: "gradients/bn_descriptor/moments/mean_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Prod_1"
  op: "Prod"
  input: "gradients/bn_descriptor/moments/mean_grad/Shape_3"
  input: "gradients/bn_descriptor/moments/mean_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Maximum_1/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Maximum_1"
  op: "Maximum"
  input: "gradients/bn_descriptor/moments/mean_grad/Prod_1"
  input: "gradients/bn_descriptor/moments/mean_grad/Maximum_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/floordiv_1"
  op: "FloorDiv"
  input: "gradients/bn_descriptor/moments/mean_grad/Prod"
  input: "gradients/bn_descriptor/moments/mean_grad/Maximum_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/Cast"
  op: "Cast"
  input: "gradients/bn_descriptor/moments/mean_grad/floordiv_1"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_descriptor/moments/mean_grad/truediv"
  op: "RealDiv"
  input: "gradients/bn_descriptor/moments/mean_grad/Tile"
  input: "gradients/bn_descriptor/moments/mean_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/AddN_3"
  op: "AddN"
  input: "gradients/bn_descriptor/batchnorm/mul_1_grad/tuple/control_dependency"
  input: "gradients/bn_descriptor/moments/SquaredDifference_grad/tuple/control_dependency"
  input: "gradients/dec_dense1/MatMul_grad/tuple/control_dependency"
  input: "gradients/bn_descriptor/moments/mean_grad/truediv"
  attr {
    key: "N"
    value {
      i: 4
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_descriptor/batchnorm/mul_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/descriptor/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/AddN_3"
  input: "descriptor/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/descriptor/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/descriptor/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/descriptor/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/descriptor/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/descriptor/Relu_grad/ReluGrad"
}
node {
  name: "gradients/descriptor/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/descriptor/Relu_grad/ReluGrad"
  input: "^gradients/descriptor/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/descriptor/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/descriptor/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/descriptor/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/descriptor/MatMul_grad/MatMul"
  op: "MatMul"
  input: "gradients/descriptor/BiasAdd_grad/tuple/control_dependency"
  input: "descriptor/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "gradients/descriptor/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "dropout_dense1/cond/Merge"
  input: "gradients/descriptor/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/descriptor/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/descriptor/MatMul_grad/MatMul"
  input: "^gradients/descriptor/MatMul_grad/MatMul_1"
}
node {
  name: "gradients/descriptor/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/descriptor/MatMul_grad/MatMul"
  input: "^gradients/descriptor/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/descriptor/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/descriptor/MatMul_grad/MatMul_1"
  input: "^gradients/descriptor/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/descriptor/MatMul_grad/tuple/control_dependency"
  input: "dropout_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_dense1/cond/Merge_grad/cond_grad"
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/Merge_grad/cond_grad"
  input: "^gradients/dropout_dense1/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/Merge_grad/cond_grad:1"
  input: "^gradients/dropout_dense1/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/descriptor/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape"
  op: "Shape"
  input: "dropout_dense1/cond/dropout/div"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape_1"
  op: "Shape"
  input: "dropout_dense1/cond/dropout/Floor"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Mul"
  op: "Mul"
  input: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency_1"
  input: "dropout_dense1/cond/dropout/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Sum"
  op: "Sum"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Mul"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Reshape"
  op: "Reshape"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Sum"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Mul_1"
  op: "Mul"
  input: "dropout_dense1/cond/dropout/div"
  input: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Sum_1"
  op: "Sum"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Mul_1"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Sum_1"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_dense1/cond/dropout/mul_grad/Reshape"
  input: "^gradients/dropout_dense1/cond/dropout/mul_grad/Reshape_1"
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Reshape"
  input: "^gradients/dropout_dense1/cond/dropout/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_dense1/cond/dropout/mul_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/Reshape_1"
  input: "^gradients/dropout_dense1/cond/dropout/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_dense1/cond/dropout/mul_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/Switch_4"
  op: "Switch"
  input: "bn_dense1/batchnorm/add_1"
  input: "dropout_dense1/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_5"
  op: "Shape"
  input: "gradients/Switch_4:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_4/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_4"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_4"
  op: "Fill"
  input: "gradients/Shape_5"
  input: "gradients/zeros_4/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Identity/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency"
  input: "gradients/zeros_4"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Shape"
  op: "Shape"
  input: "dropout_dense1/cond/dropout/Shape/Switch:1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Shape"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv"
  op: "RealDiv"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/tuple/control_dependency"
  input: "dropout_dense1/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Sum"
  op: "Sum"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Reshape"
  op: "Reshape"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Sum"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Neg"
  op: "Neg"
  input: "dropout_dense1/cond/dropout/Shape/Switch:1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv_1"
  op: "RealDiv"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Neg"
  input: "dropout_dense1/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv_2"
  op: "RealDiv"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv_1"
  input: "dropout_dense1/cond/dropout/keep_prob"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/mul"
  op: "Mul"
  input: "gradients/dropout_dense1/cond/dropout/mul_grad/tuple/control_dependency"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/RealDiv_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Sum_1"
  op: "Sum"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/mul"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Sum_1"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dropout_dense1/cond/dropout/div_grad/Reshape"
  input: "^gradients/dropout_dense1/cond/dropout/div_grad/Reshape_1"
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Reshape"
  input: "^gradients/dropout_dense1/cond/dropout/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_dense1/cond/dropout/div_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/div_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/Reshape_1"
  input: "^gradients/dropout_dense1/cond/dropout/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_dense1/cond/dropout/div_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/Switch_5"
  op: "Switch"
  input: "bn_dense1/batchnorm/add_1"
  input: "dropout_dense1/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_6"
  op: "Shape"
  input: "gradients/Switch_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_5/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_5"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_5"
  op: "Fill"
  input: "gradients/Shape_6"
  input: "gradients/zeros_5/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/Shape/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_5"
  input: "gradients/dropout_dense1/cond/dropout/div_grad/tuple/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/AddN_4"
  op: "AddN"
  input: "gradients/dropout_dense1/cond/Identity/Switch_grad/cond_grad"
  input: "gradients/dropout_dense1/cond/dropout/Shape/Switch_grad/cond_grad"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dropout_dense1/cond/Identity/Switch_grad/cond_grad"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Shape"
  op: "Shape"
  input: "bn_dense1/batchnorm/mul_1"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 512
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Shape"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Sum"
  op: "Sum"
  input: "gradients/AddN_4"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Sum"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/AddN_4"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Sum_1"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/add_1_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/add_1_grad/Reshape_1"
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/Reshape_1"
  input: "^gradients/bn_dense1/batchnorm/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape"
  op: "Shape"
  input: "dense1/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 512
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Mul"
  op: "Mul"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency"
  input: "bn_dense1/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Sum"
  op: "Sum"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Mul"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Sum"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Mul_1"
  op: "Mul"
  input: "dense1/Relu"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Mul_1"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Sum_1"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/mul_1_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/mul_1_grad/Reshape_1"
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/Reshape_1"
  input: "^gradients/bn_dense1/batchnorm/mul_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/sub_grad/Neg"
  op: "Neg"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/sub_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency_1"
  input: "^gradients/bn_dense1/batchnorm/sub_grad/Neg"
}
node {
  name: "gradients/bn_dense1/batchnorm/sub_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/add_1_grad/tuple/control_dependency_1"
  input: "^gradients/bn_dense1/batchnorm/sub_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/sub_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/sub_grad/Neg"
  input: "^gradients/bn_dense1/batchnorm/sub_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/sub_grad/Neg"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
  op: "Mul"
  input: "gradients/bn_dense1/batchnorm/sub_grad/tuple/control_dependency_1"
  input: "bn_dense1/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_2_grad/Mul_1"
  op: "Mul"
  input: "gradients/bn_dense1/batchnorm/sub_grad/tuple/control_dependency_1"
  input: "bn_dense1/cond/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_2_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
  input: "^gradients/bn_dense1/batchnorm/mul_2_grad/Mul_1"
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_2_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
  input: "^gradients/bn_dense1/batchnorm/mul_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_2_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_2_grad/Mul_1"
  input: "^gradients/bn_dense1/batchnorm/mul_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_2_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/bn_dense1/batchnorm/mul_2_grad/tuple/control_dependency"
  input: "bn_dense1/cond/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/cond/Merge_grad/cond_grad"
}
node {
  name: "gradients/bn_dense1/cond/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/cond/Merge_grad/cond_grad"
  input: "^gradients/bn_dense1/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/cond/Merge_grad/cond_grad:1"
  input: "^gradients/bn_dense1/cond/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_2_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/AddN_5"
  op: "AddN"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/tuple/control_dependency_1"
  input: "gradients/bn_dense1/batchnorm/mul_2_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_1_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_grad/Mul"
  op: "Mul"
  input: "gradients/AddN_5"
  input: "bn_dense1/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_grad/Mul_1"
  op: "Mul"
  input: "gradients/AddN_5"
  input: "bn_dense1/batchnorm/Rsqrt"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/mul_grad/Mul"
  input: "^gradients/bn_dense1/batchnorm/mul_grad/Mul_1"
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_grad/Mul"
  input: "^gradients/bn_dense1/batchnorm/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_grad/Mul"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/mul_grad/Mul_1"
  input: "^gradients/bn_dense1/batchnorm/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "gradients/Switch_6"
  op: "Switch"
  input: "bn_dense1/moments/Squeeze"
  input: "bn_dense1/cond/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_7"
  op: "Shape"
  input: "gradients/Switch_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_6/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_6"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_6"
  op: "Fill"
  input: "gradients/Shape_7"
  input: "gradients/zeros_6/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/cond/Switch_1_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_6"
  input: "gradients/bn_dense1/cond/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/Rsqrt_grad/RsqrtGrad"
  op: "RsqrtGrad"
  input: "bn_dense1/batchnorm/Rsqrt"
  input: "gradients/bn_dense1/batchnorm/mul_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/Squeeze_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/Squeeze_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/cond/Switch_1_grad/cond_grad"
  input: "gradients/bn_dense1/moments/Squeeze_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 512
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_dense1/batchnorm/add_grad/Shape"
  input: "gradients/bn_dense1/batchnorm/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Sum"
  op: "Sum"
  input: "gradients/bn_dense1/batchnorm/Rsqrt_grad/RsqrtGrad"
  input: "gradients/bn_dense1/batchnorm/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/add_grad/Sum"
  input: "gradients/bn_dense1/batchnorm/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_dense1/batchnorm/Rsqrt_grad/RsqrtGrad"
  input: "gradients/bn_dense1/batchnorm/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_dense1/batchnorm/add_grad/Sum_1"
  input: "gradients/bn_dense1/batchnorm/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/batchnorm/add_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/add_grad/Reshape_1"
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/add_grad/Reshape"
  input: "^gradients/bn_dense1/batchnorm/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/batchnorm/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/batchnorm/add_grad/Reshape_1"
  input: "^gradients/bn_dense1/batchnorm/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond_1/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/bn_dense1/batchnorm/add_grad/tuple/control_dependency"
  input: "bn_dense1/cond_1/pred_id"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond_1/Merge_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/cond_1/Merge_grad/cond_grad"
}
node {
  name: "gradients/bn_dense1/cond_1/Merge_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/cond_1/Merge_grad/cond_grad"
  input: "^gradients/bn_dense1/cond_1/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/cond_1/Merge_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/cond_1/Merge_grad/cond_grad:1"
  input: "^gradients/bn_dense1/cond_1/Merge_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/Switch_7"
  op: "Switch"
  input: "bn_dense1/moments/Squeeze_1"
  input: "bn_dense1/cond_1/pred_id"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/Shape_8"
  op: "Shape"
  input: "gradients/Switch_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/zeros_7/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/Switch_7"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "gradients/zeros_7"
  op: "Fill"
  input: "gradients/Shape_8"
  input: "gradients/zeros_7/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/cond_1/Switch_1_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_7"
  input: "gradients/bn_dense1/cond_1/Merge_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/Squeeze_1_grad/Shape"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/Squeeze_1_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/cond_1/Switch_1_grad/cond_grad"
  input: "gradients/bn_dense1/moments/Squeeze_1_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Shape"
  op: "Shape"
  input: "bn_dense1/moments/SquaredDifference"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Size"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/add"
  op: "Add"
  input: "bn_dense1/moments/variance/reduction_indices"
  input: "gradients/bn_dense1/moments/variance_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/mod"
  op: "FloorMod"
  input: "gradients/bn_dense1/moments/variance_grad/add"
  input: "gradients/bn_dense1/moments/variance_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/range/start"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/range/delta"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/range"
  op: "Range"
  input: "gradients/bn_dense1/moments/variance_grad/range/start"
  input: "gradients/bn_dense1/moments/variance_grad/Size"
  input: "gradients/bn_dense1/moments/variance_grad/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Fill/value"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Fill"
  op: "Fill"
  input: "gradients/bn_dense1/moments/variance_grad/Shape_1"
  input: "gradients/bn_dense1/moments/variance_grad/Fill/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/DynamicStitch"
  op: "DynamicStitch"
  input: "gradients/bn_dense1/moments/variance_grad/range"
  input: "gradients/bn_dense1/moments/variance_grad/mod"
  input: "gradients/bn_dense1/moments/variance_grad/Shape"
  input: "gradients/bn_dense1/moments/variance_grad/Fill"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Maximum"
  op: "Maximum"
  input: "gradients/bn_dense1/moments/variance_grad/DynamicStitch"
  input: "gradients/bn_dense1/moments/variance_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/bn_dense1/moments/variance_grad/Shape"
  input: "gradients/bn_dense1/moments/variance_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/variance_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/moments/Squeeze_1_grad/Reshape"
  input: "gradients/bn_dense1/moments/variance_grad/DynamicStitch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Tile"
  op: "Tile"
  input: "gradients/bn_dense1/moments/variance_grad/Reshape"
  input: "gradients/bn_dense1/moments/variance_grad/floordiv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Shape_2"
  op: "Shape"
  input: "bn_dense1/moments/SquaredDifference"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Shape_3"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Prod"
  op: "Prod"
  input: "gradients/bn_dense1/moments/variance_grad/Shape_2"
  input: "gradients/bn_dense1/moments/variance_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Prod_1"
  op: "Prod"
  input: "gradients/bn_dense1/moments/variance_grad/Shape_3"
  input: "gradients/bn_dense1/moments/variance_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Maximum_1/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Maximum_1"
  op: "Maximum"
  input: "gradients/bn_dense1/moments/variance_grad/Prod_1"
  input: "gradients/bn_dense1/moments/variance_grad/Maximum_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/floordiv_1"
  op: "FloorDiv"
  input: "gradients/bn_dense1/moments/variance_grad/Prod"
  input: "gradients/bn_dense1/moments/variance_grad/Maximum_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/Cast"
  op: "Cast"
  input: "gradients/bn_dense1/moments/variance_grad/floordiv_1"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/variance_grad/truediv"
  op: "RealDiv"
  input: "gradients/bn_dense1/moments/variance_grad/Tile"
  input: "gradients/bn_dense1/moments/variance_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape"
  op: "Shape"
  input: "dense1/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/scalar"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/moments/variance_grad/truediv"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/mul"
  op: "Mul"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/scalar"
  input: "gradients/bn_dense1/moments/variance_grad/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/sub"
  op: "Sub"
  input: "dense1/Relu"
  input: "bn_dense1/moments/StopGradient"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/moments/variance_grad/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/mul_1"
  op: "Mul"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/mul"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Sum"
  op: "Sum"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/mul_1"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Sum"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Sum_1"
  op: "Sum"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/mul_1"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Reshape_1"
  op: "Reshape"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Sum_1"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/Neg"
  op: "Neg"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/bn_dense1/moments/SquaredDifference_grad/Neg"
  input: "^gradients/bn_dense1/moments/SquaredDifference_grad/Reshape"
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Reshape"
  input: "^gradients/bn_dense1/moments/SquaredDifference_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/SquaredDifference_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/SquaredDifference_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/Neg"
  input: "^gradients/bn_dense1/moments/SquaredDifference_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/SquaredDifference_grad/Neg"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Shape"
  op: "Shape"
  input: "dense1/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Size"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/add"
  op: "Add"
  input: "bn_dense1/moments/mean/reduction_indices"
  input: "gradients/bn_dense1/moments/mean_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/mod"
  op: "FloorMod"
  input: "gradients/bn_dense1/moments/mean_grad/add"
  input: "gradients/bn_dense1/moments/mean_grad/Size"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/range/start"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/range/delta"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/range"
  op: "Range"
  input: "gradients/bn_dense1/moments/mean_grad/range/start"
  input: "gradients/bn_dense1/moments/mean_grad/Size"
  input: "gradients/bn_dense1/moments/mean_grad/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Fill/value"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Fill"
  op: "Fill"
  input: "gradients/bn_dense1/moments/mean_grad/Shape_1"
  input: "gradients/bn_dense1/moments/mean_grad/Fill/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/DynamicStitch"
  op: "DynamicStitch"
  input: "gradients/bn_dense1/moments/mean_grad/range"
  input: "gradients/bn_dense1/moments/mean_grad/mod"
  input: "gradients/bn_dense1/moments/mean_grad/Shape"
  input: "gradients/bn_dense1/moments/mean_grad/Fill"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Maximum/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Maximum"
  op: "Maximum"
  input: "gradients/bn_dense1/moments/mean_grad/DynamicStitch"
  input: "gradients/bn_dense1/moments/mean_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/floordiv"
  op: "FloorDiv"
  input: "gradients/bn_dense1/moments/mean_grad/Shape"
  input: "gradients/bn_dense1/moments/mean_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/moments/mean_grad/Shape"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Reshape"
  op: "Reshape"
  input: "gradients/bn_dense1/moments/Squeeze_grad/Reshape"
  input: "gradients/bn_dense1/moments/mean_grad/DynamicStitch"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Tile"
  op: "Tile"
  input: "gradients/bn_dense1/moments/mean_grad/Reshape"
  input: "gradients/bn_dense1/moments/mean_grad/floordiv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Shape_2"
  op: "Shape"
  input: "dense1/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Shape_3"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Const"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Prod"
  op: "Prod"
  input: "gradients/bn_dense1/moments/mean_grad/Shape_2"
  input: "gradients/bn_dense1/moments/mean_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Const_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Prod_1"
  op: "Prod"
  input: "gradients/bn_dense1/moments/mean_grad/Shape_3"
  input: "gradients/bn_dense1/moments/mean_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Maximum_1/y"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Maximum_1"
  op: "Maximum"
  input: "gradients/bn_dense1/moments/mean_grad/Prod_1"
  input: "gradients/bn_dense1/moments/mean_grad/Maximum_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/floordiv_1"
  op: "FloorDiv"
  input: "gradients/bn_dense1/moments/mean_grad/Prod"
  input: "gradients/bn_dense1/moments/mean_grad/Maximum_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/Cast"
  op: "Cast"
  input: "gradients/bn_dense1/moments/mean_grad/floordiv_1"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/bn_dense1/moments/mean_grad/truediv"
  op: "RealDiv"
  input: "gradients/bn_dense1/moments/mean_grad/Tile"
  input: "gradients/bn_dense1/moments/mean_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/AddN_6"
  op: "AddN"
  input: "gradients/bn_dense1/batchnorm/mul_1_grad/tuple/control_dependency"
  input: "gradients/bn_dense1/moments/SquaredDifference_grad/tuple/control_dependency"
  input: "gradients/bn_dense1/moments/mean_grad/truediv"
  attr {
    key: "N"
    value {
      i: 3
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/bn_dense1/batchnorm/mul_1_grad/Reshape"
      }
    }
  }
}
node {
  name: "gradients/dense1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/AddN_6"
  input: "dense1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/dense1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/dense1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/dense1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dense1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/dense1/Relu_grad/ReluGrad"
}
node {
  name: "gradients/dense1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dense1/Relu_grad/ReluGrad"
  input: "^gradients/dense1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dense1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/dense1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dense1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/dense1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dense1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/dense1/MatMul_grad/MatMul"
  op: "MatMul"
  input: "gradients/dense1/BiasAdd_grad/tuple/control_dependency"
  input: "dense1/kernel/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "gradients/dense1/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "flatten"
  input: "gradients/dense1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "gradients/dense1/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/dense1/MatMul_grad/MatMul"
  input: "^gradients/dense1/MatMul_grad/MatMul_1"
}
node {
  name: "gradients/dense1/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/dense1/MatMul_grad/MatMul"
  input: "^gradients/dense1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dense1/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dense1/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/dense1/MatMul_grad/MatMul_1"
  input: "^gradients/dense1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/dense1/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "gradients/flatten_grad/Rank"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "gradients/flatten_grad/mod"
  op: "FloorMod"
  input: "flatten/axis"
  input: "gradients/flatten_grad/Rank"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/flatten_grad/Shape"
  op: "Shape"
  input: "Flatten/flatten/Reshape"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/flatten_grad/ShapeN"
  op: "ShapeN"
  input: "Flatten/flatten/Reshape"
  input: "scales"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/flatten_grad/ConcatOffset"
  op: "ConcatOffset"
  input: "gradients/flatten_grad/mod"
  input: "gradients/flatten_grad/ShapeN"
  input: "gradients/flatten_grad/ShapeN:1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
}
node {
  name: "gradients/flatten_grad/Slice"
  op: "Slice"
  input: "gradients/dense1/MatMul_grad/tuple/control_dependency"
  input: "gradients/flatten_grad/ConcatOffset"
  input: "gradients/flatten_grad/ShapeN"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/flatten_grad/Slice_1"
  op: "Slice"
  input: "gradients/dense1/MatMul_grad/tuple/control_dependency"
  input: "gradients/flatten_grad/ConcatOffset:1"
  input: "gradients/flatten_grad/ShapeN:1"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/flatten_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/flatten_grad/Slice"
  input: "^gradients/flatten_grad/Slice_1"
}
node {
  name: "gradients/flatten_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/flatten_grad/Slice"
  input: "^gradients/flatten_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/flatten_grad/Slice"
      }
    }
  }
}
node {
  name: "gradients/flatten_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/flatten_grad/Slice_1"
  input: "^gradients/flatten_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/flatten_grad/Slice_1"
      }
    }
  }
}
node {
  name: "gradients/Flatten/flatten/Reshape_grad/Shape"
  op: "Shape"
  input: "conv5/Relu"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/Flatten/flatten/Reshape_grad/Reshape"
  op: "Reshape"
  input: "gradients/flatten_grad/tuple/control_dependency"
  input: "gradients/Flatten/flatten/Reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/conv5/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/Flatten/flatten/Reshape_grad/Reshape"
  input: "conv5/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/conv5/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/conv5/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/conv5/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv5/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv5/Relu_grad/ReluGrad"
}
node {
  name: "gradients/conv5/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv5/Relu_grad/ReluGrad"
  input: "^gradients/conv5/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv5/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/conv5/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv5/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv5/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv5/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/Shape"
  op: "Shape"
  input: "pool2/MaxPool3D"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/Conv3DBackpropInputV2"
  op: "Conv3DBackpropInputV2"
  input: "gradients/conv5/Conv3D_grad/Shape"
  input: "conv5/kernel/read"
  input: "gradients/conv5/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000@\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "pool2/MaxPool3D"
  input: "gradients/conv5/Conv3D_grad/Shape_1"
  input: "gradients/conv5/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv5/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv5/Conv3D_grad/Conv3DBackpropInputV2"
}
node {
  name: "gradients/conv5/Conv3D_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv5/Conv3D_grad/Conv3DBackpropInputV2"
  input: "^gradients/conv5/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv5/Conv3D_grad/Conv3DBackpropInputV2"
      }
    }
  }
}
node {
  name: "gradients/conv5/Conv3D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv5/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv5/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv5/Conv3D_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "gradients/pool2/MaxPool3D_grad/MaxPool3DGrad"
  op: "MaxPool3DGrad"
  input: "conv3/Relu"
  input: "pool2/MaxPool3D"
  input: "gradients/conv5/Conv3D_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "TInput"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv3/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/pool2/MaxPool3D_grad/MaxPool3DGrad"
  input: "conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/conv3/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/conv3/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/conv3/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv3/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv3/Relu_grad/ReluGrad"
}
node {
  name: "gradients/conv3/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv3/Relu_grad/ReluGrad"
  input: "^gradients/conv3/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv3/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/conv3/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv3/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv3/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv3/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/Shape"
  op: "Shape"
  input: "pool1/MaxPool3D"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/Conv3DBackpropInputV2"
  op: "Conv3DBackpropInputV2"
  input: "gradients/conv3/Conv3D_grad/Shape"
  input: "conv3/kernel/read"
  input: "gradients/conv3/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "pool1/MaxPool3D"
  input: "gradients/conv3/Conv3D_grad/Shape_1"
  input: "gradients/conv3/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv3/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv3/Conv3D_grad/Conv3DBackpropInputV2"
}
node {
  name: "gradients/conv3/Conv3D_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv3/Conv3D_grad/Conv3DBackpropInputV2"
  input: "^gradients/conv3/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv3/Conv3D_grad/Conv3DBackpropInputV2"
      }
    }
  }
}
node {
  name: "gradients/conv3/Conv3D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv3/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv3/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv3/Conv3D_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "gradients/pool1/MaxPool3D_grad/MaxPool3DGrad"
  op: "MaxPool3DGrad"
  input: "conv1/Relu"
  input: "pool1/MaxPool3D"
  input: "gradients/conv3/Conv3D_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "TInput"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/pool1/MaxPool3D_grad/MaxPool3DGrad"
  input: "conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "gradients/conv1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "gradients/conv1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "gradients/conv1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv1/Relu_grad/ReluGrad"
}
node {
  name: "gradients/conv1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv1/Relu_grad/ReluGrad"
  input: "^gradients/conv1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "gradients/conv1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv1/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/conv1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/Shape"
  op: "Shape"
  input: "InputScope/input"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/Conv3DBackpropInputV2"
  op: "Conv3DBackpropInputV2"
  input: "gradients/conv1/Conv3D_grad/Shape"
  input: "conv1/kernel/read"
  input: "gradients/conv1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/Shape_1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000\001\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/Conv3DBackpropFilterV2"
  op: "Conv3DBackpropFilterV2"
  input: "InputScope/input"
  input: "gradients/conv1/Conv3D_grad/Shape_1"
  input: "gradients/conv1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NDHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^gradients/conv1/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv1/Conv3D_grad/Conv3DBackpropInputV2"
}
node {
  name: "gradients/conv1/Conv3D_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/conv1/Conv3D_grad/Conv3DBackpropInputV2"
  input: "^gradients/conv1/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv1/Conv3D_grad/Conv3DBackpropInputV2"
      }
    }
  }
}
node {
  name: "gradients/conv1/Conv3D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/conv1/Conv3D_grad/Conv3DBackpropFilterV2"
  input: "^gradients/conv1/Conv3D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/conv1/Conv3D_grad/Conv3DBackpropFilterV2"
      }
    }
  }
}
node {
  name: "beta1_power/initial_value"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "beta1_power"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "beta1_power/Assign"
  op: "Assign"
  input: "beta1_power"
  input: "beta1_power/initial_value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "beta1_power/read"
  op: "Identity"
  input: "beta1_power"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "beta2_power/initial_value"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9990000128746033
      }
    }
  }
}
node {
  name: "beta2_power"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "beta2_power/Assign"
  op: "Assign"
  input: "beta2_power"
  input: "beta2_power/initial_value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "beta2_power/read"
  op: "Identity"
  input: "beta2_power"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "conv1/kernel/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 1
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv1/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/kernel/Adam/Assign"
  op: "Assign"
  input: "conv1/kernel/Adam"
  input: "conv1/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/kernel/Adam/read"
  op: "Identity"
  input: "conv1/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/kernel/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 1
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv1/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/kernel/Adam_1/Assign"
  op: "Assign"
  input: "conv1/kernel/Adam_1"
  input: "conv1/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/kernel/Adam_1/read"
  op: "Identity"
  input: "conv1/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
}
node {
  name: "conv1/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv1/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/bias/Adam/Assign"
  op: "Assign"
  input: "conv1/bias/Adam"
  input: "conv1/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/bias/Adam/read"
  op: "Identity"
  input: "conv1/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
}
node {
  name: "conv1/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv1/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv1/bias/Adam_1/Assign"
  op: "Assign"
  input: "conv1/bias/Adam_1"
  input: "conv1/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv1/bias/Adam_1/read"
  op: "Identity"
  input: "conv1/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "conv3/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "conv3/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "conv3/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/kernel/Adam/Assign"
  op: "Assign"
  input: "conv3/kernel/Adam"
  input: "conv3/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/kernel/Adam/read"
  op: "Identity"
  input: "conv3/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv3/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "conv3/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "conv3/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "conv3/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/kernel/Adam_1/Assign"
  op: "Assign"
  input: "conv3/kernel/Adam_1"
  input: "conv3/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/kernel/Adam_1/read"
  op: "Identity"
  input: "conv3/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
}
node {
  name: "conv3/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv3/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/bias/Adam/Assign"
  op: "Assign"
  input: "conv3/bias/Adam"
  input: "conv3/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/bias/Adam/read"
  op: "Identity"
  input: "conv3/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
}
node {
  name: "conv3/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv3/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv3/bias/Adam_1/Assign"
  op: "Assign"
  input: "conv3/bias/Adam_1"
  input: "conv3/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv3/bias/Adam_1/read"
  op: "Identity"
  input: "conv3/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000@\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "conv5/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "conv5/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "conv5/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 64
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/kernel/Adam/Assign"
  op: "Assign"
  input: "conv5/kernel/Adam"
  input: "conv5/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/kernel/Adam/read"
  op: "Identity"
  input: "conv5/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000@\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv5/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "conv5/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "conv5/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "conv5/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 64
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/kernel/Adam_1/Assign"
  op: "Assign"
  input: "conv5/kernel/Adam_1"
  input: "conv5/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/kernel/Adam_1/read"
  op: "Identity"
  input: "conv5/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
}
node {
  name: "conv5/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv5/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/bias/Adam/Assign"
  op: "Assign"
  input: "conv5/bias/Adam"
  input: "conv5/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/bias/Adam/read"
  op: "Identity"
  input: "conv5/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
}
node {
  name: "conv5/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "conv5/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "conv5/bias/Adam_1/Assign"
  op: "Assign"
  input: "conv5/bias/Adam_1"
  input: "conv5/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "conv5/bias/Adam_1/read"
  op: "Identity"
  input: "conv5/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\003@\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "dense1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "dense1/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dense1/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 16387
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/kernel/Adam/Assign"
  op: "Assign"
  input: "dense1/kernel/Adam"
  input: "dense1/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/kernel/Adam/read"
  op: "Identity"
  input: "dense1/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\003@\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dense1/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "dense1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "dense1/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dense1/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 16387
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/kernel/Adam_1/Assign"
  op: "Assign"
  input: "dense1/kernel/Adam_1"
  input: "dense1/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/kernel/Adam_1/read"
  op: "Identity"
  input: "dense1/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
}
node {
  name: "dense1/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dense1/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/bias/Adam/Assign"
  op: "Assign"
  input: "dense1/bias/Adam"
  input: "dense1/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/bias/Adam/read"
  op: "Identity"
  input: "dense1/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
}
node {
  name: "dense1/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dense1/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dense1/bias/Adam_1/Assign"
  op: "Assign"
  input: "dense1/bias/Adam_1"
  input: "dense1/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dense1/bias/Adam_1/read"
  op: "Identity"
  input: "dense1/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam/Assign"
  op: "Assign"
  input: "bn_dense1/gamma/Adam"
  input: "bn_dense1/gamma/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam/read"
  op: "Identity"
  input: "bn_dense1/gamma/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam_1/Assign"
  op: "Assign"
  input: "bn_dense1/gamma/Adam_1"
  input: "bn_dense1/gamma/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/gamma/Adam_1/read"
  op: "Identity"
  input: "bn_dense1/gamma/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
}
node {
  name: "bn_dense1/beta/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/beta/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/beta/Adam/Assign"
  op: "Assign"
  input: "bn_dense1/beta/Adam"
  input: "bn_dense1/beta/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/beta/Adam/read"
  op: "Identity"
  input: "bn_dense1/beta/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "bn_dense1/beta/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_dense1/beta/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_dense1/beta/Adam_1/Assign"
  op: "Assign"
  input: "bn_dense1/beta/Adam_1"
  input: "bn_dense1/beta/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_dense1/beta/Adam_1/read"
  op: "Identity"
  input: "bn_dense1/beta/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "descriptor/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "descriptor/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "descriptor/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/kernel/Adam/Assign"
  op: "Assign"
  input: "descriptor/kernel/Adam"
  input: "descriptor/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/kernel/Adam/read"
  op: "Identity"
  input: "descriptor/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "descriptor/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "descriptor/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1/Assign"
  op: "Assign"
  input: "descriptor/kernel/Adam_1"
  input: "descriptor/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/kernel/Adam_1/read"
  op: "Identity"
  input: "descriptor/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
}
node {
  name: "descriptor/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "descriptor/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/bias/Adam/Assign"
  op: "Assign"
  input: "descriptor/bias/Adam"
  input: "descriptor/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/bias/Adam/read"
  op: "Identity"
  input: "descriptor/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
}
node {
  name: "descriptor/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "descriptor/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "descriptor/bias/Adam_1/Assign"
  op: "Assign"
  input: "descriptor/bias/Adam_1"
  input: "descriptor/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "descriptor/bias/Adam_1/read"
  op: "Identity"
  input: "descriptor/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam/Assign"
  op: "Assign"
  input: "bn_descriptor/gamma/Adam"
  input: "bn_descriptor/gamma/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam/read"
  op: "Identity"
  input: "bn_descriptor/gamma/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam_1/Assign"
  op: "Assign"
  input: "bn_descriptor/gamma/Adam_1"
  input: "bn_descriptor/gamma/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/gamma/Adam_1/read"
  op: "Identity"
  input: "bn_descriptor/gamma/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam/Assign"
  op: "Assign"
  input: "bn_descriptor/beta/Adam"
  input: "bn_descriptor/beta/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam/read"
  op: "Identity"
  input: "bn_descriptor/beta/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam_1/Assign"
  op: "Assign"
  input: "bn_descriptor/beta/Adam_1"
  input: "bn_descriptor/beta/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "bn_descriptor/beta/Adam_1/read"
  op: "Identity"
  input: "bn_descriptor/beta/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
}
node {
  name: "classes/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000]\007\000\000"
      }
    }
  }
}
node {
  name: "classes/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "classes/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "classes/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "classes/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "classes/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/kernel/Adam/Assign"
  op: "Assign"
  input: "classes/kernel/Adam"
  input: "classes/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/kernel/Adam/read"
  op: "Identity"
  input: "classes/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000]\007\000\000"
      }
    }
  }
}
node {
  name: "classes/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "classes/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "classes/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "classes/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "classes/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/kernel/Adam_1/Assign"
  op: "Assign"
  input: "classes/kernel/Adam_1"
  input: "classes/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/kernel/Adam_1/read"
  op: "Identity"
  input: "classes/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
}
node {
  name: "classes/bias/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1885
      }
    }
  }
}
node {
  name: "classes/bias/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "classes/bias/Adam/Initializer/zeros"
  op: "Fill"
  input: "classes/bias/Adam/Initializer/zeros/shape_as_tensor"
  input: "classes/bias/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "classes/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/bias/Adam/Assign"
  op: "Assign"
  input: "classes/bias/Adam"
  input: "classes/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/bias/Adam/read"
  op: "Identity"
  input: "classes/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
}
node {
  name: "classes/bias/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1885
      }
    }
  }
}
node {
  name: "classes/bias/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "classes/bias/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "classes/bias/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "classes/bias/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "classes/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 1885
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "classes/bias/Adam_1/Assign"
  op: "Assign"
  input: "classes/bias/Adam_1"
  input: "classes/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "classes/bias/Adam_1/read"
  op: "Identity"
  input: "classes/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000\000 \000\000"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "dec_dense1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "dec_dense1/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam/Assign"
  op: "Assign"
  input: "dec_dense1/kernel/Adam"
  input: "dec_dense1/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam/read"
  op: "Identity"
  input: "dec_dense1/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "@\000\000\000\000 \000\000"
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "dec_dense1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "dec_dense1/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 64
        }
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1/Assign"
  op: "Assign"
  input: "dec_dense1/kernel/Adam_1"
  input: "dec_dense1/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/kernel/Adam_1/read"
  op: "Identity"
  input: "dec_dense1/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 8192
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam/Initializer/zeros"
  op: "Fill"
  input: "dec_dense1/bias/Adam/Initializer/zeros/shape_as_tensor"
  input: "dec_dense1/bias/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_dense1/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/bias/Adam/Assign"
  op: "Assign"
  input: "dec_dense1/bias/Adam"
  input: "dec_dense1/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/bias/Adam/read"
  op: "Identity"
  input: "dec_dense1/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 8192
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "dec_dense1/bias/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "dec_dense1/bias/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 8192
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1/Assign"
  op: "Assign"
  input: "dec_dense1/bias/Adam_1"
  input: "dec_dense1/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_dense1/bias/Adam_1/read"
  op: "Identity"
  input: "dec_dense1/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "dec_conv1/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "dec_conv1/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam/Assign"
  op: "Assign"
  input: "dec_conv1/kernel/Adam"
  input: "dec_conv1/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam/read"
  op: "Identity"
  input: "dec_conv1/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "dec_conv1/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "dec_conv1/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1/Assign"
  op: "Assign"
  input: "dec_conv1/kernel/Adam_1"
  input: "dec_conv1/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv1/kernel/Adam_1/read"
  op: "Identity"
  input: "dec_conv1/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam/Initializer/zeros"
  op: "Fill"
  input: "dec_conv2/kernel/Adam/Initializer/zeros/shape_as_tensor"
  input: "dec_conv2/kernel/Adam/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam/Assign"
  op: "Assign"
  input: "dec_conv2/kernel/Adam"
  input: "dec_conv2/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam/read"
  op: "Identity"
  input: "dec_conv2/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 5
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\003\000\000\000 \000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1/Initializer/zeros"
  op: "Fill"
  input: "dec_conv2/kernel/Adam_1/Initializer/zeros/shape_as_tensor"
  input: "dec_conv2/kernel/Adam_1/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1/Assign"
  op: "Assign"
  input: "dec_conv2/kernel/Adam_1"
  input: "dec_conv2/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_conv2/kernel/Adam_1/read"
  op: "Identity"
  input: "dec_conv2/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 1
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam/Assign"
  op: "Assign"
  input: "dec_reshape/kernel/Adam"
  input: "dec_reshape/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam/read"
  op: "Identity"
  input: "dec_reshape/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 3
          }
          dim {
            size: 1
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 1
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam_1/Assign"
  op: "Assign"
  input: "dec_reshape/kernel/Adam_1"
  input: "dec_reshape/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "dec_reshape/kernel/Adam_1/read"
  op: "Identity"
  input: "dec_reshape/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
}
node {
  name: "train_op/learning_rate"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.999999747378752e-05
      }
    }
  }
}
node {
  name: "train_op/beta1"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "train_op/beta2"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9990000128746033
      }
    }
  }
}
node {
  name: "train_op/epsilon"
  op: "Const"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999993922529e-09
      }
    }
  }
}
node {
  name: "train_op/update_conv1/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "conv1/kernel"
  input: "conv1/kernel/Adam"
  input: "conv1/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv1/Conv3D_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_conv1/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "conv1/bias"
  input: "conv1/bias/Adam"
  input: "conv1/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_conv3/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "conv3/kernel"
  input: "conv3/kernel/Adam"
  input: "conv3/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv3/Conv3D_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_conv3/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "conv3/bias"
  input: "conv3/bias/Adam"
  input: "conv3/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv3/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_conv5/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "conv5/kernel"
  input: "conv5/kernel/Adam"
  input: "conv5/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv5/Conv3D_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_conv5/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "conv5/bias"
  input: "conv5/bias/Adam"
  input: "conv5/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/conv5/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dense1/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dense1/kernel"
  input: "dense1/kernel/Adam"
  input: "dense1/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dense1/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dense1/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "dense1/bias"
  input: "dense1/bias/Adam"
  input: "dense1/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dense1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_bn_dense1/gamma/ApplyAdam"
  op: "ApplyAdam"
  input: "bn_dense1/gamma"
  input: "bn_dense1/gamma/Adam"
  input: "bn_dense1/gamma/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/bn_dense1/batchnorm/mul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_bn_dense1/beta/ApplyAdam"
  op: "ApplyAdam"
  input: "bn_dense1/beta"
  input: "bn_dense1/beta/Adam"
  input: "bn_dense1/beta/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/bn_dense1/batchnorm/sub_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_descriptor/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "descriptor/kernel"
  input: "descriptor/kernel/Adam"
  input: "descriptor/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/descriptor/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_descriptor/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "descriptor/bias"
  input: "descriptor/bias/Adam"
  input: "descriptor/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/descriptor/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_bn_descriptor/gamma/ApplyAdam"
  op: "ApplyAdam"
  input: "bn_descriptor/gamma"
  input: "bn_descriptor/gamma/Adam"
  input: "bn_descriptor/gamma/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/bn_descriptor/batchnorm/mul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_bn_descriptor/beta/ApplyAdam"
  op: "ApplyAdam"
  input: "bn_descriptor/beta"
  input: "bn_descriptor/beta/Adam"
  input: "bn_descriptor/beta/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/bn_descriptor/batchnorm/sub_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_classes/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "classes/kernel"
  input: "classes/kernel/Adam"
  input: "classes/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/classes/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_classes/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "classes/bias"
  input: "classes/bias/Adam"
  input: "classes/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/classes/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dec_dense1/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dec_dense1/kernel"
  input: "dec_dense1/kernel/Adam"
  input: "dec_dense1/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dec_dense1/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dec_dense1/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "dec_dense1/bias"
  input: "dec_dense1/bias/Adam"
  input: "dec_dense1/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dec_dense1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dec_conv1/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dec_conv1/kernel"
  input: "dec_conv1/kernel/Adam"
  input: "dec_conv1/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dec_conv1/conv3d_transpose_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dec_conv2/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dec_conv2/kernel"
  input: "dec_conv2/kernel/Adam"
  input: "dec_conv2/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dec_conv2/conv3d_transpose_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/update_dec_reshape/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dec_reshape/kernel"
  input: "dec_reshape/kernel/Adam"
  input: "dec_reshape/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "train_op/learning_rate"
  input: "train_op/beta1"
  input: "train_op/beta2"
  input: "train_op/epsilon"
  input: "gradients/dec_reshape/conv3d_transpose_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train_op/mul"
  op: "Mul"
  input: "beta1_power/read"
  input: "train_op/beta1"
  input: "^train_op/update_bn_dense1/beta/ApplyAdam"
  input: "^train_op/update_bn_dense1/gamma/ApplyAdam"
  input: "^train_op/update_bn_descriptor/beta/ApplyAdam"
  input: "^train_op/update_bn_descriptor/gamma/ApplyAdam"
  input: "^train_op/update_classes/bias/ApplyAdam"
  input: "^train_op/update_classes/kernel/ApplyAdam"
  input: "^train_op/update_conv1/bias/ApplyAdam"
  input: "^train_op/update_conv1/kernel/ApplyAdam"
  input: "^train_op/update_conv3/bias/ApplyAdam"
  input: "^train_op/update_conv3/kernel/ApplyAdam"
  input: "^train_op/update_conv5/bias/ApplyAdam"
  input: "^train_op/update_conv5/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv1/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv2/kernel/ApplyAdam"
  input: "^train_op/update_dec_dense1/bias/ApplyAdam"
  input: "^train_op/update_dec_dense1/kernel/ApplyAdam"
  input: "^train_op/update_dec_reshape/kernel/ApplyAdam"
  input: "^train_op/update_dense1/bias/ApplyAdam"
  input: "^train_op/update_dense1/kernel/ApplyAdam"
  input: "^train_op/update_descriptor/bias/ApplyAdam"
  input: "^train_op/update_descriptor/kernel/ApplyAdam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "train_op/Assign"
  op: "Assign"
  input: "beta1_power"
  input: "train_op/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train_op/mul_1"
  op: "Mul"
  input: "beta2_power/read"
  input: "train_op/beta2"
  input: "^train_op/update_bn_dense1/beta/ApplyAdam"
  input: "^train_op/update_bn_dense1/gamma/ApplyAdam"
  input: "^train_op/update_bn_descriptor/beta/ApplyAdam"
  input: "^train_op/update_bn_descriptor/gamma/ApplyAdam"
  input: "^train_op/update_classes/bias/ApplyAdam"
  input: "^train_op/update_classes/kernel/ApplyAdam"
  input: "^train_op/update_conv1/bias/ApplyAdam"
  input: "^train_op/update_conv1/kernel/ApplyAdam"
  input: "^train_op/update_conv3/bias/ApplyAdam"
  input: "^train_op/update_conv3/kernel/ApplyAdam"
  input: "^train_op/update_conv5/bias/ApplyAdam"
  input: "^train_op/update_conv5/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv1/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv2/kernel/ApplyAdam"
  input: "^train_op/update_dec_dense1/bias/ApplyAdam"
  input: "^train_op/update_dec_dense1/kernel/ApplyAdam"
  input: "^train_op/update_dec_reshape/kernel/ApplyAdam"
  input: "^train_op/update_dense1/bias/ApplyAdam"
  input: "^train_op/update_dense1/kernel/ApplyAdam"
  input: "^train_op/update_descriptor/bias/ApplyAdam"
  input: "^train_op/update_descriptor/kernel/ApplyAdam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
}
node {
  name: "train_op/Assign_1"
  op: "Assign"
  input: "beta2_power"
  input: "train_op/mul_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train_op"
  op: "NoOp"
  input: "^bn_dense1/cond_2/Merge"
  input: "^bn_dense1/cond_3/Merge"
  input: "^bn_descriptor/cond_2/Merge"
  input: "^bn_descriptor/cond_3/Merge"
  input: "^train_op/Assign"
  input: "^train_op/Assign_1"
  input: "^train_op/update_bn_dense1/beta/ApplyAdam"
  input: "^train_op/update_bn_dense1/gamma/ApplyAdam"
  input: "^train_op/update_bn_descriptor/beta/ApplyAdam"
  input: "^train_op/update_bn_descriptor/gamma/ApplyAdam"
  input: "^train_op/update_classes/bias/ApplyAdam"
  input: "^train_op/update_classes/kernel/ApplyAdam"
  input: "^train_op/update_conv1/bias/ApplyAdam"
  input: "^train_op/update_conv1/kernel/ApplyAdam"
  input: "^train_op/update_conv3/bias/ApplyAdam"
  input: "^train_op/update_conv3/kernel/ApplyAdam"
  input: "^train_op/update_conv5/bias/ApplyAdam"
  input: "^train_op/update_conv5/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv1/kernel/ApplyAdam"
  input: "^train_op/update_dec_conv2/kernel/ApplyAdam"
  input: "^train_op/update_dec_dense1/bias/ApplyAdam"
  input: "^train_op/update_dec_dense1/kernel/ApplyAdam"
  input: "^train_op/update_dec_reshape/kernel/ApplyAdam"
  input: "^train_op/update_dense1/bias/ApplyAdam"
  input: "^train_op/update_dense1/kernel/ApplyAdam"
  input: "^train_op/update_descriptor/bias/ApplyAdam"
  input: "^train_op/update_descriptor/kernel/ApplyAdam"
}
node {
  name: "y_prob"
  op: "Softmax"
  input: "classes/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "ArgMax/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "ArgMax"
  op: "ArgMax"
  input: "classes/BiasAdd"
  input: "ArgMax/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "ArgMax_1/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "ArgMax_1"
  op: "ArgMax"
  input: "y_true"
  input: "ArgMax_1/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "Equal"
  op: "Equal"
  input: "ArgMax"
  input: "ArgMax_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "Cast"
  op: "Cast"
  input: "Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "Const_4"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "accuracy"
  op: "Mean"
  input: "Cast"
  input: "Const_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "roc_auc"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "summary/loss/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "summary/loss"
      }
    }
  }
}
node {
  name: "summary/loss"
  op: "ScalarSummary"
  input: "summary/loss/tags"
  input: "loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "summary/loss_c/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "summary/loss_c"
      }
    }
  }
}
node {
  name: "summary/loss_c"
  op: "ScalarSummary"
  input: "summary/loss_c/tags"
  input: "loss_c"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "summary/loss_r/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "summary/loss_r"
      }
    }
  }
}
node {
  name: "summary/loss_r"
  op: "ScalarSummary"
  input: "summary/loss_r/tags"
  input: "Neg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "summary/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "summary/accuracy"
      }
    }
  }
}
node {
  name: "summary/accuracy"
  op: "ScalarSummary"
  input: "summary/accuracy/tags"
  input: "accuracy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "summary/roc_auc/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "summary/roc_auc"
      }
    }
  }
}
node {
  name: "summary/roc_auc"
  op: "ScalarSummary"
  input: "summary/roc_auc/tags"
  input: "roc_auc"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "save/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "model"
      }
    }
  }
}
node {
  name: "save/SaveV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 70
          }
        }
        string_val: "beta1_power"
        string_val: "beta2_power"
        string_val: "bn_dense1/beta"
        string_val: "bn_dense1/beta/Adam"
        string_val: "bn_dense1/beta/Adam_1"
        string_val: "bn_dense1/gamma"
        string_val: "bn_dense1/gamma/Adam"
        string_val: "bn_dense1/gamma/Adam_1"
        string_val: "bn_dense1/moving_mean"
        string_val: "bn_dense1/moving_variance"
        string_val: "bn_descriptor/beta"
        string_val: "bn_descriptor/beta/Adam"
        string_val: "bn_descriptor/beta/Adam_1"
        string_val: "bn_descriptor/gamma"
        string_val: "bn_descriptor/gamma/Adam"
        string_val: "bn_descriptor/gamma/Adam_1"
        string_val: "bn_descriptor/moving_mean"
        string_val: "bn_descriptor/moving_variance"
        string_val: "classes/bias"
        string_val: "classes/bias/Adam"
        string_val: "classes/bias/Adam_1"
        string_val: "classes/kernel"
        string_val: "classes/kernel/Adam"
        string_val: "classes/kernel/Adam_1"
        string_val: "conv1/bias"
        string_val: "conv1/bias/Adam"
        string_val: "conv1/bias/Adam_1"
        string_val: "conv1/kernel"
        string_val: "conv1/kernel/Adam"
        string_val: "conv1/kernel/Adam_1"
        string_val: "conv3/bias"
        string_val: "conv3/bias/Adam"
        string_val: "conv3/bias/Adam_1"
        string_val: "conv3/kernel"
        string_val: "conv3/kernel/Adam"
        string_val: "conv3/kernel/Adam_1"
        string_val: "conv5/bias"
        string_val: "conv5/bias/Adam"
        string_val: "conv5/bias/Adam_1"
        string_val: "conv5/kernel"
        string_val: "conv5/kernel/Adam"
        string_val: "conv5/kernel/Adam_1"
        string_val: "dec_conv1/kernel"
        string_val: "dec_conv1/kernel/Adam"
        string_val: "dec_conv1/kernel/Adam_1"
        string_val: "dec_conv2/kernel"
        string_val: "dec_conv2/kernel/Adam"
        string_val: "dec_conv2/kernel/Adam_1"
        string_val: "dec_dense1/bias"
        string_val: "dec_dense1/bias/Adam"
        string_val: "dec_dense1/bias/Adam_1"
        string_val: "dec_dense1/kernel"
        string_val: "dec_dense1/kernel/Adam"
        string_val: "dec_dense1/kernel/Adam_1"
        string_val: "dec_reshape/kernel"
        string_val: "dec_reshape/kernel/Adam"
        string_val: "dec_reshape/kernel/Adam_1"
        string_val: "dense1/bias"
        string_val: "dense1/bias/Adam"
        string_val: "dense1/bias/Adam_1"
        string_val: "dense1/kernel"
        string_val: "dense1/kernel/Adam"
        string_val: "dense1/kernel/Adam_1"
        string_val: "descriptor/bias"
        string_val: "descriptor/bias/Adam"
        string_val: "descriptor/bias/Adam_1"
        string_val: "descriptor/kernel"
        string_val: "descriptor/kernel/Adam"
        string_val: "descriptor/kernel/Adam_1"
        string_val: "global_step"
      }
    }
  }
}
node {
  name: "save/SaveV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 70
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/SaveV2"
  op: "SaveV2"
  input: "save/Const"
  input: "save/SaveV2/tensor_names"
  input: "save/SaveV2/shape_and_slices"
  input: "beta1_power"
  input: "beta2_power"
  input: "bn_dense1/beta"
  input: "bn_dense1/beta/Adam"
  input: "bn_dense1/beta/Adam_1"
  input: "bn_dense1/gamma"
  input: "bn_dense1/gamma/Adam"
  input: "bn_dense1/gamma/Adam_1"
  input: "bn_dense1/moving_mean"
  input: "bn_dense1/moving_variance"
  input: "bn_descriptor/beta"
  input: "bn_descriptor/beta/Adam"
  input: "bn_descriptor/beta/Adam_1"
  input: "bn_descriptor/gamma"
  input: "bn_descriptor/gamma/Adam"
  input: "bn_descriptor/gamma/Adam_1"
  input: "bn_descriptor/moving_mean"
  input: "bn_descriptor/moving_variance"
  input: "classes/bias"
  input: "classes/bias/Adam"
  input: "classes/bias/Adam_1"
  input: "classes/kernel"
  input: "classes/kernel/Adam"
  input: "classes/kernel/Adam_1"
  input: "conv1/bias"
  input: "conv1/bias/Adam"
  input: "conv1/bias/Adam_1"
  input: "conv1/kernel"
  input: "conv1/kernel/Adam"
  input: "conv1/kernel/Adam_1"
  input: "conv3/bias"
  input: "conv3/bias/Adam"
  input: "conv3/bias/Adam_1"
  input: "conv3/kernel"
  input: "conv3/kernel/Adam"
  input: "conv3/kernel/Adam_1"
  input: "conv5/bias"
  input: "conv5/bias/Adam"
  input: "conv5/bias/Adam_1"
  input: "conv5/kernel"
  input: "conv5/kernel/Adam"
  input: "conv5/kernel/Adam_1"
  input: "dec_conv1/kernel"
  input: "dec_conv1/kernel/Adam"
  input: "dec_conv1/kernel/Adam_1"
  input: "dec_conv2/kernel"
  input: "dec_conv2/kernel/Adam"
  input: "dec_conv2/kernel/Adam_1"
  input: "dec_dense1/bias"
  input: "dec_dense1/bias/Adam"
  input: "dec_dense1/bias/Adam_1"
  input: "dec_dense1/kernel"
  input: "dec_dense1/kernel/Adam"
  input: "dec_dense1/kernel/Adam_1"
  input: "dec_reshape/kernel"
  input: "dec_reshape/kernel/Adam"
  input: "dec_reshape/kernel/Adam_1"
  input: "dense1/bias"
  input: "dense1/bias/Adam"
  input: "dense1/bias/Adam_1"
  input: "dense1/kernel"
  input: "dense1/kernel/Adam"
  input: "dense1/kernel/Adam_1"
  input: "descriptor/bias"
  input: "descriptor/bias/Adam"
  input: "descriptor/bias/Adam_1"
  input: "descriptor/kernel"
  input: "descriptor/kernel/Adam"
  input: "descriptor/kernel/Adam_1"
  input: "global_step"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_INT32
      }
    }
  }
}
node {
  name: "save/control_dependency"
  op: "Identity"
  input: "save/Const"
  input: "^save/SaveV2"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@save/Const"
      }
    }
  }
}
node {
  name: "save/RestoreV2/tensor_names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 70
          }
        }
        string_val: "beta1_power"
        string_val: "beta2_power"
        string_val: "bn_dense1/beta"
        string_val: "bn_dense1/beta/Adam"
        string_val: "bn_dense1/beta/Adam_1"
        string_val: "bn_dense1/gamma"
        string_val: "bn_dense1/gamma/Adam"
        string_val: "bn_dense1/gamma/Adam_1"
        string_val: "bn_dense1/moving_mean"
        string_val: "bn_dense1/moving_variance"
        string_val: "bn_descriptor/beta"
        string_val: "bn_descriptor/beta/Adam"
        string_val: "bn_descriptor/beta/Adam_1"
        string_val: "bn_descriptor/gamma"
        string_val: "bn_descriptor/gamma/Adam"
        string_val: "bn_descriptor/gamma/Adam_1"
        string_val: "bn_descriptor/moving_mean"
        string_val: "bn_descriptor/moving_variance"
        string_val: "classes/bias"
        string_val: "classes/bias/Adam"
        string_val: "classes/bias/Adam_1"
        string_val: "classes/kernel"
        string_val: "classes/kernel/Adam"
        string_val: "classes/kernel/Adam_1"
        string_val: "conv1/bias"
        string_val: "conv1/bias/Adam"
        string_val: "conv1/bias/Adam_1"
        string_val: "conv1/kernel"
        string_val: "conv1/kernel/Adam"
        string_val: "conv1/kernel/Adam_1"
        string_val: "conv3/bias"
        string_val: "conv3/bias/Adam"
        string_val: "conv3/bias/Adam_1"
        string_val: "conv3/kernel"
        string_val: "conv3/kernel/Adam"
        string_val: "conv3/kernel/Adam_1"
        string_val: "conv5/bias"
        string_val: "conv5/bias/Adam"
        string_val: "conv5/bias/Adam_1"
        string_val: "conv5/kernel"
        string_val: "conv5/kernel/Adam"
        string_val: "conv5/kernel/Adam_1"
        string_val: "dec_conv1/kernel"
        string_val: "dec_conv1/kernel/Adam"
        string_val: "dec_conv1/kernel/Adam_1"
        string_val: "dec_conv2/kernel"
        string_val: "dec_conv2/kernel/Adam"
        string_val: "dec_conv2/kernel/Adam_1"
        string_val: "dec_dense1/bias"
        string_val: "dec_dense1/bias/Adam"
        string_val: "dec_dense1/bias/Adam_1"
        string_val: "dec_dense1/kernel"
        string_val: "dec_dense1/kernel/Adam"
        string_val: "dec_dense1/kernel/Adam_1"
        string_val: "dec_reshape/kernel"
        string_val: "dec_reshape/kernel/Adam"
        string_val: "dec_reshape/kernel/Adam_1"
        string_val: "dense1/bias"
        string_val: "dense1/bias/Adam"
        string_val: "dense1/bias/Adam_1"
        string_val: "dense1/kernel"
        string_val: "dense1/kernel/Adam"
        string_val: "dense1/kernel/Adam_1"
        string_val: "descriptor/bias"
        string_val: "descriptor/bias/Adam"
        string_val: "descriptor/bias/Adam_1"
        string_val: "descriptor/kernel"
        string_val: "descriptor/kernel/Adam"
        string_val: "descriptor/kernel/Adam_1"
        string_val: "global_step"
      }
    }
  }
}
node {
  name: "save/RestoreV2/shape_and_slices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 70
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2/tensor_names"
  input: "save/RestoreV2/shape_and_slices"
  device: "/device:CPU:0"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_INT32
      }
    }
  }
}
node {
  name: "save/Assign"
  op: "Assign"
  input: "beta1_power"
  input: "save/RestoreV2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_1"
  op: "Assign"
  input: "beta2_power"
  input: "save/RestoreV2:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_2"
  op: "Assign"
  input: "bn_dense1/beta"
  input: "save/RestoreV2:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_3"
  op: "Assign"
  input: "bn_dense1/beta/Adam"
  input: "save/RestoreV2:3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_4"
  op: "Assign"
  input: "bn_dense1/beta/Adam_1"
  input: "save/RestoreV2:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_5"
  op: "Assign"
  input: "bn_dense1/gamma"
  input: "save/RestoreV2:5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_6"
  op: "Assign"
  input: "bn_dense1/gamma/Adam"
  input: "save/RestoreV2:6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_7"
  op: "Assign"
  input: "bn_dense1/gamma/Adam_1"
  input: "save/RestoreV2:7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_8"
  op: "Assign"
  input: "bn_dense1/moving_mean"
  input: "save/RestoreV2:8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_9"
  op: "Assign"
  input: "bn_dense1/moving_variance"
  input: "save/RestoreV2:9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_dense1/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_10"
  op: "Assign"
  input: "bn_descriptor/beta"
  input: "save/RestoreV2:10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_11"
  op: "Assign"
  input: "bn_descriptor/beta/Adam"
  input: "save/RestoreV2:11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_12"
  op: "Assign"
  input: "bn_descriptor/beta/Adam_1"
  input: "save/RestoreV2:12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_13"
  op: "Assign"
  input: "bn_descriptor/gamma"
  input: "save/RestoreV2:13"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_14"
  op: "Assign"
  input: "bn_descriptor/gamma/Adam"
  input: "save/RestoreV2:14"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_15"
  op: "Assign"
  input: "bn_descriptor/gamma/Adam_1"
  input: "save/RestoreV2:15"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_16"
  op: "Assign"
  input: "bn_descriptor/moving_mean"
  input: "save/RestoreV2:16"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_17"
  op: "Assign"
  input: "bn_descriptor/moving_variance"
  input: "save/RestoreV2:17"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@bn_descriptor/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_18"
  op: "Assign"
  input: "classes/bias"
  input: "save/RestoreV2:18"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_19"
  op: "Assign"
  input: "classes/bias/Adam"
  input: "save/RestoreV2:19"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_20"
  op: "Assign"
  input: "classes/bias/Adam_1"
  input: "save/RestoreV2:20"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_21"
  op: "Assign"
  input: "classes/kernel"
  input: "save/RestoreV2:21"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_22"
  op: "Assign"
  input: "classes/kernel/Adam"
  input: "save/RestoreV2:22"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_23"
  op: "Assign"
  input: "classes/kernel/Adam_1"
  input: "save/RestoreV2:23"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@classes/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_24"
  op: "Assign"
  input: "conv1/bias"
  input: "save/RestoreV2:24"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_25"
  op: "Assign"
  input: "conv1/bias/Adam"
  input: "save/RestoreV2:25"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_26"
  op: "Assign"
  input: "conv1/bias/Adam_1"
  input: "save/RestoreV2:26"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_27"
  op: "Assign"
  input: "conv1/kernel"
  input: "save/RestoreV2:27"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_28"
  op: "Assign"
  input: "conv1/kernel/Adam"
  input: "save/RestoreV2:28"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_29"
  op: "Assign"
  input: "conv1/kernel/Adam_1"
  input: "save/RestoreV2:29"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_30"
  op: "Assign"
  input: "conv3/bias"
  input: "save/RestoreV2:30"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_31"
  op: "Assign"
  input: "conv3/bias/Adam"
  input: "save/RestoreV2:31"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_32"
  op: "Assign"
  input: "conv3/bias/Adam_1"
  input: "save/RestoreV2:32"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_33"
  op: "Assign"
  input: "conv3/kernel"
  input: "save/RestoreV2:33"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_34"
  op: "Assign"
  input: "conv3/kernel/Adam"
  input: "save/RestoreV2:34"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_35"
  op: "Assign"
  input: "conv3/kernel/Adam_1"
  input: "save/RestoreV2:35"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv3/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_36"
  op: "Assign"
  input: "conv5/bias"
  input: "save/RestoreV2:36"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_37"
  op: "Assign"
  input: "conv5/bias/Adam"
  input: "save/RestoreV2:37"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_38"
  op: "Assign"
  input: "conv5/bias/Adam_1"
  input: "save/RestoreV2:38"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_39"
  op: "Assign"
  input: "conv5/kernel"
  input: "save/RestoreV2:39"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_40"
  op: "Assign"
  input: "conv5/kernel/Adam"
  input: "save/RestoreV2:40"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_41"
  op: "Assign"
  input: "conv5/kernel/Adam_1"
  input: "save/RestoreV2:41"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@conv5/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_42"
  op: "Assign"
  input: "dec_conv1/kernel"
  input: "save/RestoreV2:42"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_43"
  op: "Assign"
  input: "dec_conv1/kernel/Adam"
  input: "save/RestoreV2:43"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_44"
  op: "Assign"
  input: "dec_conv1/kernel/Adam_1"
  input: "save/RestoreV2:44"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_45"
  op: "Assign"
  input: "dec_conv2/kernel"
  input: "save/RestoreV2:45"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_46"
  op: "Assign"
  input: "dec_conv2/kernel/Adam"
  input: "save/RestoreV2:46"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_47"
  op: "Assign"
  input: "dec_conv2/kernel/Adam_1"
  input: "save/RestoreV2:47"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_conv2/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_48"
  op: "Assign"
  input: "dec_dense1/bias"
  input: "save/RestoreV2:48"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_49"
  op: "Assign"
  input: "dec_dense1/bias/Adam"
  input: "save/RestoreV2:49"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_50"
  op: "Assign"
  input: "dec_dense1/bias/Adam_1"
  input: "save/RestoreV2:50"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_51"
  op: "Assign"
  input: "dec_dense1/kernel"
  input: "save/RestoreV2:51"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_52"
  op: "Assign"
  input: "dec_dense1/kernel/Adam"
  input: "save/RestoreV2:52"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_53"
  op: "Assign"
  input: "dec_dense1/kernel/Adam_1"
  input: "save/RestoreV2:53"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_54"
  op: "Assign"
  input: "dec_reshape/kernel"
  input: "save/RestoreV2:54"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_55"
  op: "Assign"
  input: "dec_reshape/kernel/Adam"
  input: "save/RestoreV2:55"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_56"
  op: "Assign"
  input: "dec_reshape/kernel/Adam_1"
  input: "save/RestoreV2:56"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dec_reshape/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_57"
  op: "Assign"
  input: "dense1/bias"
  input: "save/RestoreV2:57"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_58"
  op: "Assign"
  input: "dense1/bias/Adam"
  input: "save/RestoreV2:58"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_59"
  op: "Assign"
  input: "dense1/bias/Adam_1"
  input: "save/RestoreV2:59"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_60"
  op: "Assign"
  input: "dense1/kernel"
  input: "save/RestoreV2:60"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_61"
  op: "Assign"
  input: "dense1/kernel/Adam"
  input: "save/RestoreV2:61"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_62"
  op: "Assign"
  input: "dense1/kernel/Adam_1"
  input: "save/RestoreV2:62"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@dense1/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_63"
  op: "Assign"
  input: "descriptor/bias"
  input: "save/RestoreV2:63"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_64"
  op: "Assign"
  input: "descriptor/bias/Adam"
  input: "save/RestoreV2:64"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_65"
  op: "Assign"
  input: "descriptor/bias/Adam_1"
  input: "save/RestoreV2:65"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/bias"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_66"
  op: "Assign"
  input: "descriptor/kernel"
  input: "save/RestoreV2:66"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_67"
  op: "Assign"
  input: "descriptor/kernel/Adam"
  input: "save/RestoreV2:67"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_68"
  op: "Assign"
  input: "descriptor/kernel/Adam_1"
  input: "save/RestoreV2:68"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@descriptor/kernel"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_69"
  op: "Assign"
  input: "global_step"
  input: "save/RestoreV2:69"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@global_step"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/restore_all"
  op: "NoOp"
  input: "^save/Assign"
  input: "^save/Assign_1"
  input: "^save/Assign_10"
  input: "^save/Assign_11"
  input: "^save/Assign_12"
  input: "^save/Assign_13"
  input: "^save/Assign_14"
  input: "^save/Assign_15"
  input: "^save/Assign_16"
  input: "^save/Assign_17"
  input: "^save/Assign_18"
  input: "^save/Assign_19"
  input: "^save/Assign_2"
  input: "^save/Assign_20"
  input: "^save/Assign_21"
  input: "^save/Assign_22"
  input: "^save/Assign_23"
  input: "^save/Assign_24"
  input: "^save/Assign_25"
  input: "^save/Assign_26"
  input: "^save/Assign_27"
  input: "^save/Assign_28"
  input: "^save/Assign_29"
  input: "^save/Assign_3"
  input: "^save/Assign_30"
  input: "^save/Assign_31"
  input: "^save/Assign_32"
  input: "^save/Assign_33"
  input: "^save/Assign_34"
  input: "^save/Assign_35"
  input: "^save/Assign_36"
  input: "^save/Assign_37"
  input: "^save/Assign_38"
  input: "^save/Assign_39"
  input: "^save/Assign_4"
  input: "^save/Assign_40"
  input: "^save/Assign_41"
  input: "^save/Assign_42"
  input: "^save/Assign_43"
  input: "^save/Assign_44"
  input: "^save/Assign_45"
  input: "^save/Assign_46"
  input: "^save/Assign_47"
  input: "^save/Assign_48"
  input: "^save/Assign_49"
  input: "^save/Assign_5"
  input: "^save/Assign_50"
  input: "^save/Assign_51"
  input: "^save/Assign_52"
  input: "^save/Assign_53"
  input: "^save/Assign_54"
  input: "^save/Assign_55"
  input: "^save/Assign_56"
  input: "^save/Assign_57"
  input: "^save/Assign_58"
  input: "^save/Assign_59"
  input: "^save/Assign_6"
  input: "^save/Assign_60"
  input: "^save/Assign_61"
  input: "^save/Assign_62"
  input: "^save/Assign_63"
  input: "^save/Assign_64"
  input: "^save/Assign_65"
  input: "^save/Assign_66"
  input: "^save/Assign_67"
  input: "^save/Assign_68"
  input: "^save/Assign_69"
  input: "^save/Assign_7"
  input: "^save/Assign_8"
  input: "^save/Assign_9"
}
node {
  name: "Merge/MergeSummary"
  op: "MergeSummary"
  input: "summary/loss"
  input: "summary/loss_c"
  input: "summary/loss_r"
  input: "summary/accuracy"
  attr {
    key: "N"
    value {
      i: 4
    }
  }
}
node {
  name: "Merge_1/MergeSummary"
  op: "MergeSummary"
  input: "summary/roc_auc"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
}
node {
  name: "init"
  op: "NoOp"
  input: "^beta1_power/Assign"
  input: "^beta2_power/Assign"
  input: "^bn_dense1/beta/Adam/Assign"
  input: "^bn_dense1/beta/Adam_1/Assign"
  input: "^bn_dense1/beta/Assign"
  input: "^bn_dense1/gamma/Adam/Assign"
  input: "^bn_dense1/gamma/Adam_1/Assign"
  input: "^bn_dense1/gamma/Assign"
  input: "^bn_dense1/moving_mean/Assign"
  input: "^bn_dense1/moving_variance/Assign"
  input: "^bn_descriptor/beta/Adam/Assign"
  input: "^bn_descriptor/beta/Adam_1/Assign"
  input: "^bn_descriptor/beta/Assign"
  input: "^bn_descriptor/gamma/Adam/Assign"
  input: "^bn_descriptor/gamma/Adam_1/Assign"
  input: "^bn_descriptor/gamma/Assign"
  input: "^bn_descriptor/moving_mean/Assign"
  input: "^bn_descriptor/moving_variance/Assign"
  input: "^classes/bias/Adam/Assign"
  input: "^classes/bias/Adam_1/Assign"
  input: "^classes/bias/Assign"
  input: "^classes/kernel/Adam/Assign"
  input: "^classes/kernel/Adam_1/Assign"
  input: "^classes/kernel/Assign"
  input: "^conv1/bias/Adam/Assign"
  input: "^conv1/bias/Adam_1/Assign"
  input: "^conv1/bias/Assign"
  input: "^conv1/kernel/Adam/Assign"
  input: "^conv1/kernel/Adam_1/Assign"
  input: "^conv1/kernel/Assign"
  input: "^conv3/bias/Adam/Assign"
  input: "^conv3/bias/Adam_1/Assign"
  input: "^conv3/bias/Assign"
  input: "^conv3/kernel/Adam/Assign"
  input: "^conv3/kernel/Adam_1/Assign"
  input: "^conv3/kernel/Assign"
  input: "^conv5/bias/Adam/Assign"
  input: "^conv5/bias/Adam_1/Assign"
  input: "^conv5/bias/Assign"
  input: "^conv5/kernel/Adam/Assign"
  input: "^conv5/kernel/Adam_1/Assign"
  input: "^conv5/kernel/Assign"
  input: "^dec_conv1/kernel/Adam/Assign"
  input: "^dec_conv1/kernel/Adam_1/Assign"
  input: "^dec_conv1/kernel/Assign"
  input: "^dec_conv2/kernel/Adam/Assign"
  input: "^dec_conv2/kernel/Adam_1/Assign"
  input: "^dec_conv2/kernel/Assign"
  input: "^dec_dense1/bias/Adam/Assign"
  input: "^dec_dense1/bias/Adam_1/Assign"
  input: "^dec_dense1/bias/Assign"
  input: "^dec_dense1/kernel/Adam/Assign"
  input: "^dec_dense1/kernel/Adam_1/Assign"
  input: "^dec_dense1/kernel/Assign"
  input: "^dec_reshape/kernel/Adam/Assign"
  input: "^dec_reshape/kernel/Adam_1/Assign"
  input: "^dec_reshape/kernel/Assign"
  input: "^dense1/bias/Adam/Assign"
  input: "^dense1/bias/Adam_1/Assign"
  input: "^dense1/bias/Assign"
  input: "^dense1/kernel/Adam/Assign"
  input: "^dense1/kernel/Adam_1/Assign"
  input: "^dense1/kernel/Assign"
  input: "^descriptor/bias/Adam/Assign"
  input: "^descriptor/bias/Adam_1/Assign"
  input: "^descriptor/bias/Assign"
  input: "^descriptor/kernel/Adam/Assign"
  input: "^descriptor/kernel/Adam_1/Assign"
  input: "^descriptor/kernel/Assign"
  input: "^global_step/Assign"
}
versions {
  producer: 26
}
