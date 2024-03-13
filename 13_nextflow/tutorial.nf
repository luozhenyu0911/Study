"""
1 splitLetters 步骤 这个步骤会将输入参数 params.str 中的字符串 "Hello world!" 拆分成多个大小为 6 字节的片段，并将每个片段输出到一个单独的文件中（文件名以 "chunk_" 开头）。输出路径通过 output 声明指定。等价于，printf 'Hello world!'| split -b 6 - chunk_ 

2 convertToUpper 步骤 这个步骤会读取 splitLetters 步骤输出的文件，并将每个文件中的小写字母转换为大写字母。每个文件的输出通过标准输出传递。在上述工作流程中，splitLetters 步骤的输出被 flatten 操作符扁平化成一个文件列表，然后传递给 convertToUpper 步骤进行处理。最终的输出通过 view 操作符进行修饰，去除末尾的空格并输出到标准输出。
"""


params.str = 'Hello world!'

process splitLetters {
  output:
    path 'chunk_*'

  """
  printf '${params.str}' | split -b 6 - chunk_
  """
}

process convertToUpper {
  input:
    path x
  output:
    stdout

  """
  cat $x | tr '[a-z]' '[A-Z]'
  """
}

workflow {
  splitLetters | flatten | convertToUpper | view { it.trim() }
}