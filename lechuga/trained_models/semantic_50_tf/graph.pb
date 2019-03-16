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
          size: 64
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
        tensor_content: "@\000\000\000@\000\000\000"
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
        float_val: -0.21650634706020355
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
        float_val: 0.21650634706020355
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
            size: 64
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
  input: "InputScope/input"
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
  input: "dense1/Relu"
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
        s: "loc:@dense1/Relu"
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
  input: "dense1/Relu"
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
        s: "loc:@dense1/Relu"
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
  name: "prediction/kernel/Initializer/random_uniform/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
        tensor_content: "@\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "prediction/kernel/Initializer/random_uniform/min"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
        float_val: -0.29925280809402466
      }
    }
  }
}
node {
  name: "prediction/kernel/Initializer/random_uniform/max"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
        float_val: 0.29925280809402466
      }
    }
  }
}
node {
  name: "prediction/kernel/Initializer/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "prediction/kernel/Initializer/random_uniform/shape"
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
        s: "loc:@prediction/kernel"
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
  name: "prediction/kernel/Initializer/random_uniform/sub"
  op: "Sub"
  input: "prediction/kernel/Initializer/random_uniform/max"
  input: "prediction/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/kernel/Initializer/random_uniform/mul"
  op: "Mul"
  input: "prediction/kernel/Initializer/random_uniform/RandomUniform"
  input: "prediction/kernel/Initializer/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/kernel/Initializer/random_uniform"
  op: "Add"
  input: "prediction/kernel/Initializer/random_uniform/mul"
  input: "prediction/kernel/Initializer/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/kernel"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
          size: 3
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
  name: "prediction/kernel/Assign"
  op: "Assign"
  input: "prediction/kernel"
  input: "prediction/kernel/Initializer/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
  name: "prediction/kernel/read"
  op: "Identity"
  input: "prediction/kernel"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/bias/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "prediction/bias"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/Assign"
  op: "Assign"
  input: "prediction/bias"
  input: "prediction/bias/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/read"
  op: "Identity"
  input: "prediction/bias"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
      }
    }
  }
}
node {
  name: "prediction/MatMul"
  op: "MatMul"
  input: "dropout_dense1/cond/Merge"
  input: "prediction/kernel/read"
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
  name: "prediction/BiasAdd"
  op: "BiasAdd"
  input: "prediction/MatMul"
  input: "prediction/bias/read"
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
  name: "OutputScope/output_read/y"
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
  name: "OutputScope/output_read"
  op: "Add"
  input: "prediction/BiasAdd"
  input: "OutputScope/output_read/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
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
  input: "prediction/BiasAdd"
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
  input: "prediction/BiasAdd"
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
  input: "prediction/BiasAdd"
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
  name: "Mean"
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
  name: "gradients/Shape"
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
          }
        }
      }
    }
  }
}
node {
  name: "gradients/grad_ys_0"
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
  name: "gradients/Mean_grad/Reshape/shape"
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
  name: "gradients/Mean_grad/Reshape"
  op: "Reshape"
  input: "gradients/Fill"
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
  input: "softmax_cross_entropy_with_logits/Reshape_2"
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
  input: "softmax_cross_entropy_with_logits/Reshape_2"
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
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_2_grad/Shape"
  op: "Shape"
  input: "softmax_cross_entropy_with_logits"
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
  input: "gradients/Mean_grad/truediv"
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
  name: "gradients/zeros_like"
  op: "ZerosLike"
  input: "softmax_cross_entropy_with_logits:1"
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
  name: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Shape"
  op: "Shape"
  input: "prediction/BiasAdd"
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
  name: "gradients/prediction/BiasAdd_grad/BiasAddGrad"
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
  name: "gradients/prediction/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^gradients/prediction/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
}
node {
  name: "gradients/prediction/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/softmax_cross_entropy_with_logits/Reshape_grad/Reshape"
  input: "^gradients/prediction/BiasAdd_grad/tuple/group_deps"
  attr {
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
  name: "gradients/prediction/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/prediction/BiasAdd_grad/BiasAddGrad"
  input: "^gradients/prediction/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/prediction/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "gradients/prediction/MatMul_grad/MatMul"
  op: "MatMul"
  input: "gradients/prediction/BiasAdd_grad/tuple/control_dependency"
  input: "prediction/kernel/read"
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
  name: "gradients/prediction/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "dropout_dense1/cond/Merge"
  input: "gradients/prediction/BiasAdd_grad/tuple/control_dependency"
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
  name: "gradients/prediction/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^gradients/prediction/MatMul_grad/MatMul"
  input: "^gradients/prediction/MatMul_grad/MatMul_1"
}
node {
  name: "gradients/prediction/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "gradients/prediction/MatMul_grad/MatMul"
  input: "^gradients/prediction/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/prediction/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/prediction/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "gradients/prediction/MatMul_grad/MatMul_1"
  input: "^gradients/prediction/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@gradients/prediction/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/cond_grad"
  op: "Switch"
  input: "gradients/prediction/MatMul_grad/tuple/control_dependency"
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
        s: "loc:@gradients/prediction/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/Merge_grad/tuple/group_deps"
  op: "NoOp"
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
        s: "loc:@gradients/prediction/MatMul_grad/MatMul"
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
        s: "loc:@gradients/prediction/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "gradients/dropout_dense1/cond/dropout/mul_grad/Shape"
  op: "Shape"
  input: "dropout_dense1/cond/dropout/div"
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
  name: "gradients/Switch"
  op: "Switch"
  input: "dense1/Relu"
  input: "dropout_dense1/cond/pred_id"
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
  name: "gradients/dropout_dense1/cond/Identity/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/dropout_dense1/cond/Merge_grad/tuple/control_dependency"
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
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Shape"
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
  name: "gradients/dropout_dense1/cond/dropout/div_grad/Shape_1"
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
  name: "gradients/Switch_1"
  op: "Switch"
  input: "dense1/Relu"
  input: "dropout_dense1/cond/pred_id"
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
  name: "gradients/dropout_dense1/cond/dropout/Shape/Switch_grad/cond_grad"
  op: "Merge"
  input: "gradients/zeros_1"
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
  name: "gradients/AddN"
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
  name: "gradients/dense1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "gradients/AddN"
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
  input: "InputScope/input"
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
  name: "beta1_power/initial_value"
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
        s: "loc:@dense1/bias"
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
        s: "loc:@dense1/bias"
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
        tensor_content: "@\000\000\000@\000\000\000"
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
        tensor_content: "@\000\000\000@\000\000\000"
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
            size: 64
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
            size: 64
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
  name: "prediction/kernel/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
          dim {
            size: 3
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "prediction/kernel/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
          size: 3
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
  name: "prediction/kernel/Adam/Assign"
  op: "Assign"
  input: "prediction/kernel/Adam"
  input: "prediction/kernel/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
  name: "prediction/kernel/Adam/read"
  op: "Identity"
  input: "prediction/kernel/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/kernel/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
          dim {
            size: 3
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "prediction/kernel/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
          size: 3
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
  name: "prediction/kernel/Adam_1/Assign"
  op: "Assign"
  input: "prediction/kernel/Adam_1"
  input: "prediction/kernel/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
  name: "prediction/kernel/Adam_1/read"
  op: "Identity"
  input: "prediction/kernel/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
      }
    }
  }
}
node {
  name: "prediction/bias/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "prediction/bias/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/Adam/Assign"
  op: "Assign"
  input: "prediction/bias/Adam"
  input: "prediction/bias/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/Adam/read"
  op: "Identity"
  input: "prediction/bias/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
      }
    }
  }
}
node {
  name: "prediction/bias/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "prediction/bias/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/Adam_1/Assign"
  op: "Assign"
  input: "prediction/bias/Adam_1"
  input: "prediction/bias/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "prediction/bias/Adam_1/read"
  op: "Identity"
  input: "prediction/bias/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
      }
    }
  }
}
node {
  name: "Adam/learning_rate"
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
        float_val: 9.999999747378752e-05
      }
    }
  }
}
node {
  name: "Adam/beta1"
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
  name: "Adam/beta2"
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
        float_val: 0.9990000128746033
      }
    }
  }
}
node {
  name: "Adam/epsilon"
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
        float_val: 9.99999993922529e-09
      }
    }
  }
}
node {
  name: "Adam/update_dense1/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "dense1/kernel"
  input: "dense1/kernel/Adam"
  input: "dense1/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "Adam/learning_rate"
  input: "Adam/beta1"
  input: "Adam/beta2"
  input: "Adam/epsilon"
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
  name: "Adam/update_dense1/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "dense1/bias"
  input: "dense1/bias/Adam"
  input: "dense1/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "Adam/learning_rate"
  input: "Adam/beta1"
  input: "Adam/beta2"
  input: "Adam/epsilon"
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
  name: "Adam/update_prediction/kernel/ApplyAdam"
  op: "ApplyAdam"
  input: "prediction/kernel"
  input: "prediction/kernel/Adam"
  input: "prediction/kernel/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "Adam/learning_rate"
  input: "Adam/beta1"
  input: "Adam/beta2"
  input: "Adam/epsilon"
  input: "gradients/prediction/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/kernel"
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
  name: "Adam/update_prediction/bias/ApplyAdam"
  op: "ApplyAdam"
  input: "prediction/bias"
  input: "prediction/bias/Adam"
  input: "prediction/bias/Adam_1"
  input: "beta1_power/read"
  input: "beta2_power/read"
  input: "Adam/learning_rate"
  input: "Adam/beta1"
  input: "Adam/beta2"
  input: "Adam/epsilon"
  input: "gradients/prediction/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@prediction/bias"
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
  name: "Adam/mul"
  op: "Mul"
  input: "beta1_power/read"
  input: "Adam/beta1"
  input: "^Adam/update_dense1/bias/ApplyAdam"
  input: "^Adam/update_dense1/kernel/ApplyAdam"
  input: "^Adam/update_prediction/bias/ApplyAdam"
  input: "^Adam/update_prediction/kernel/ApplyAdam"
  attr {
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
  name: "Adam/Assign"
  op: "Assign"
  input: "beta1_power"
  input: "Adam/mul"
  attr {
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
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "Adam/mul_1"
  op: "Mul"
  input: "beta2_power/read"
  input: "Adam/beta2"
  input: "^Adam/update_dense1/bias/ApplyAdam"
  input: "^Adam/update_dense1/kernel/ApplyAdam"
  input: "^Adam/update_prediction/bias/ApplyAdam"
  input: "^Adam/update_prediction/kernel/ApplyAdam"
  attr {
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
  name: "Adam/Assign_1"
  op: "Assign"
  input: "beta2_power"
  input: "Adam/mul_1"
  attr {
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
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "Adam"
  op: "NoOp"
  input: "^Adam/Assign"
  input: "^Adam/Assign_1"
  input: "^Adam/update_dense1/bias/ApplyAdam"
  input: "^Adam/update_dense1/kernel/ApplyAdam"
  input: "^Adam/update_prediction/bias/ApplyAdam"
  input: "^Adam/update_prediction/kernel/ApplyAdam"
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
  input: "prediction/BiasAdd"
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
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "Mean_1"
  op: "Mean"
  input: "Cast"
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
  name: "loss/tags"
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
        string_val: "loss"
      }
    }
  }
}
node {
  name: "loss"
  op: "ScalarSummary"
  input: "loss/tags"
  input: "Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "accuracy/tags"
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
        string_val: "accuracy"
      }
    }
  }
}
node {
  name: "accuracy"
  op: "ScalarSummary"
  input: "accuracy/tags"
  input: "Mean_1"
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
            size: 14
          }
        }
        string_val: "beta1_power"
        string_val: "beta2_power"
        string_val: "dense1/bias"
        string_val: "dense1/bias/Adam"
        string_val: "dense1/bias/Adam_1"
        string_val: "dense1/kernel"
        string_val: "dense1/kernel/Adam"
        string_val: "dense1/kernel/Adam_1"
        string_val: "prediction/bias"
        string_val: "prediction/bias/Adam"
        string_val: "prediction/bias/Adam_1"
        string_val: "prediction/kernel"
        string_val: "prediction/kernel/Adam"
        string_val: "prediction/kernel/Adam_1"
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
            size: 14
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
  input: "dense1/bias"
  input: "dense1/bias/Adam"
  input: "dense1/bias/Adam_1"
  input: "dense1/kernel"
  input: "dense1/kernel/Adam"
  input: "dense1/kernel/Adam_1"
  input: "prediction/bias"
  input: "prediction/bias/Adam"
  input: "prediction/bias/Adam_1"
  input: "prediction/kernel"
  input: "prediction/kernel/Adam"
  input: "prediction/kernel/Adam_1"
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
            size: 14
          }
        }
        string_val: "beta1_power"
        string_val: "beta2_power"
        string_val: "dense1/bias"
        string_val: "dense1/bias/Adam"
        string_val: "dense1/bias/Adam_1"
        string_val: "dense1/kernel"
        string_val: "dense1/kernel/Adam"
        string_val: "dense1/kernel/Adam_1"
        string_val: "prediction/bias"
        string_val: "prediction/bias/Adam"
        string_val: "prediction/bias/Adam_1"
        string_val: "prediction/kernel"
        string_val: "prediction/kernel/Adam"
        string_val: "prediction/kernel/Adam_1"
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
            size: 14
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
  name: "save/Assign_2"
  op: "Assign"
  input: "dense1/bias"
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
  name: "save/Assign_3"
  op: "Assign"
  input: "dense1/bias/Adam"
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
  name: "save/Assign_4"
  op: "Assign"
  input: "dense1/bias/Adam_1"
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
  name: "save/Assign_5"
  op: "Assign"
  input: "dense1/kernel"
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
  name: "save/Assign_6"
  op: "Assign"
  input: "dense1/kernel/Adam"
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
  name: "save/Assign_7"
  op: "Assign"
  input: "dense1/kernel/Adam_1"
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
  name: "save/Assign_8"
  op: "Assign"
  input: "prediction/bias"
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
        s: "loc:@prediction/bias"
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
  input: "prediction/bias/Adam"
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
        s: "loc:@prediction/bias"
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
  input: "prediction/bias/Adam_1"
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
        s: "loc:@prediction/bias"
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
  input: "prediction/kernel"
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
        s: "loc:@prediction/kernel"
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
  input: "prediction/kernel/Adam"
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
        s: "loc:@prediction/kernel"
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
  input: "prediction/kernel/Adam_1"
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
        s: "loc:@prediction/kernel"
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
  input: "^save/Assign_2"
  input: "^save/Assign_3"
  input: "^save/Assign_4"
  input: "^save/Assign_5"
  input: "^save/Assign_6"
  input: "^save/Assign_7"
  input: "^save/Assign_8"
  input: "^save/Assign_9"
}
node {
  name: "Merge/MergeSummary"
  op: "MergeSummary"
  input: "loss"
  input: "accuracy"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
}
node {
  name: "init"
  op: "NoOp"
  input: "^beta1_power/Assign"
  input: "^beta2_power/Assign"
  input: "^dense1/bias/Adam/Assign"
  input: "^dense1/bias/Adam_1/Assign"
  input: "^dense1/bias/Assign"
  input: "^dense1/kernel/Adam/Assign"
  input: "^dense1/kernel/Adam_1/Assign"
  input: "^dense1/kernel/Assign"
  input: "^prediction/bias/Adam/Assign"
  input: "^prediction/bias/Adam_1/Assign"
  input: "^prediction/bias/Assign"
  input: "^prediction/kernel/Adam/Assign"
  input: "^prediction/kernel/Adam_1/Assign"
  input: "^prediction/kernel/Assign"
}
versions {
  producer: 26
}
