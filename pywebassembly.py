#!/usr/bin/env python3

"""
University of Illinois/NCSA Open Source License
Copyright (c) 2018 Paul Dworzanski
All rights reserved.

Developed by: 		Paul Dworzanski
                        Ethereum Foundation
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal with the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimers.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimers in the documentation and/or other materials provided with the distribution.
Neither the names of Paul Dworzanski, Ethereum Foundation, nor the names of its contributors may be used to endorse or promote products derived from this Software without specific prior written permission.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
"""





"""
This code follows the WebAssembly spec closely. Differences from spec follow.
 - We drop types and just hold values eg instead of `i32.const 5`, we just hold value `5`. This is done for locals, globals, and the value stack. The only place types remain are arguments when using the API to invoke an exported function, which is useful for type-checking, but we may choose to relax this in favor of checking whether each value meets requirements for its type.
- Floating-point operations use the Python `float`, which are 64-bit on modern computers. We truncate to 32-bit when necessary. We use the `math` module for floating-point tools and the `struct` module to encode/decode binary. The `NaN` is difficult to modify in Python, so we completely ignore `NaN`'s significand, unlike the spec. We are considering re-implementing floating-point operations using:
   - ctypes.c_float and ctypes.c_double, but these may have less features
   - numpy.float32 and numpy.float64, but these are less portable
   - the decimal module, tuned to behave like IEEE754-2008
 - Unlike the spec, we modify the `store` in-place. Make a deep-copy if needed.
 - Exection in the spec uses rewrite/substitution rules on the instruction sequence, but this would be inefficient, so, like most implementations, we maintain stacks instead of modifying the instruction sequence. This is explained more in section 4.4.5 below.
 - In instantiate_module() we also return the return value, since there seems to be no other way to get the value returned by the start function. We will approach the spec writers about this.
"""


import math	#for some floating-point methods
import struct	#for encoding/decoding floats


verbose = 0


###############
###############
# 2 STRUCTURE #
###############
###############

#Chapter 2 defines the abstract syntax, which is used throughout the implementation. Not much is needed from this section, since most abstrct syntax is nested lists and dictionaries

# 2.2.3 FLOATING-POINT

# functions in this sectio are not currently used since we decided to use native Python floats, and struct.pack()/unpack() to encode/decode, but we may use these later to pass the rest of the NaN tests

def spec_fN(N,f):
  fNmag = spec_fNmag(N,f)
  if f>=0:
    return fNmag
  else:
    return -1*fNmag

def spec_fNmag(N,f):
  M=spec_signif(N)
  E=spec_expon(N)
  e=bitstring[1:E+1]
  m=bitstring[E+1:]
  if -1*(2**(E-1)) + 2 <= e <= 2**(E-1)-1:
    pass

def spec_signif(N):
  if verbose>=1: print("spec_signif(",N,")")
  if N==32:
    return 23
  elif N==64:
    return 52
  else:
    return None

def spec_signif_inv(signif):
  if verbose>=1: print("spec_signif_inv(",signif,")")
  if signif == 23:
    return 32
  elif signif == 52:
    return 64
  else:
    return None

def spec_expon(N):
  if verbose>=1: print("spec_expon(",N,")")
  if N==32:
    return 8
  elif N==64:
    return 11
  else:
    return None

def spec_expon_inv(expon):
  if verbose>=1: print("spec_expon_inv(",expon,")")
  if expon == 8:
    return 32
  elif expon == 11:
    return 64
  else:
    return None


# 2.3.8 EXTERNAL TYPES

#similar things are defined in 2.5.10 and 4.2.11, we will reuse these for those

def spec_funcs(star):
  funcs = []
  for e in star:
    if e[0] == 'func':
      funcs += [e[1]]
  return funcs

def spec_tables(star):
  tables = []
  for e in star:
    if e[0] == 'table':
      tables += [e[1]]
  return tables

def spec_mems(star):
  mems = []
  for e in star:
    if e[0] == 'mem':
      mems += [e[1]]
  return mems

def spec_globals(star):
  globals_ = []
  for e in star:
    if e[0] == 'global':
      globals_ += [e[1]]
  return globals_







################
################
# 3 VALIDATION #
################
################

#Chapter 3 defines validation rules over the abstract syntax. These rules constrain the syntax, but provide properties such as type-safety. An almost-complete implementation is available as a feature-branch.


###########
# 3.2 TYPES
###########

# 3.2.1 LIMITS

def spec_validate_limit(limits,k):
  n=limits["min"]
  m=limits["max"]
  if n>k: raise Exception("invalid")
  if m != None and (m>k or m<n): raise Exception("invalid")
  return k

# 3.2.2 FUNCTION TYPES

def spec_validate_functype(ft):
  if len(ft[1])>1: raise Exception("invalid")
  return ft

# 3.2.3 TABLE TYPES

def spec_validate_tabletype(tt):
  limits, elemtype = tt
  spec_validate_limit(limits,2**32)
  return tt

# 3.2.4 MEMORY TYPES

def spec_validate_memtype(limits):
  spec_validate_limit(limits,2**16)
  return limits

# 3.2.5 GLOBAL TYPES

def spec_validate_globaltype(globaltype):
  return globaltype #TODO: always valid, maybe should check whether mut and valtype are both ok


##################
# 3.3 INSTRUCTIONS
##################

# 3.3.1 NUMERIC INSTRUCTIONS

def spec_validate_t_const(t):
  return [],[t]

def spec_validate_t_unop(t):
  return [t],[t]

def spec_validate_t_binop(t):
  return [t,t],[t]

def spec_validate_t_testop(t):
  return [t],['i32']

def spec_validate_t_relop(t):
  return [t, t],['i32']

def spec_validate_t2_cvtop_t1(t1,t2):
  return [t1],[t2]


# 3.3.2  PARAMETRIC INSTRUCTIONS

def spec_validate_drop():
  return ["t"], []

def spec_validate_select():
  return ["t", "t", "i32"],["t"]

# 3.3.3 VARIABLE INSTRUCTIONS

def spec_validate_get_local(C,x):
  if len(C["locals"]) <= x: raise Exception("invalid")
  t = C["locals"][x]
  return [],[t] 

def spec_validate_set_local(C,x):
  if len(C["locals"]) <= x: raise Exception("invalid")
  t = C["locals"][x]
  return [t],[]

def spec_validate_tee_local(C,x):
  if len(C["locals"]) <= x: raise Exception("invalid")
  t = C["locals"][x]
  return [t],[t]

def spec_validate_get_global(C,x):
  if len(C["globals"]) <= x: raise Exception("invalid")
  mut,t = C.globals[x]
  return [],[t]

def spec_validate_set_global(C,x):
  if len(C["globals"]) <= x: raise Exception("invalid")
  mut,t = C.globals[x]
  if mut!="var": raise Exception("invalid")
  return [t],[]


# 3.3.4 MEMORY INSTRUCTIONS

def spec_validate_t_load(C,t,memarg):
  if len(C["mems"])<1: raise Exception("invalid")
  tval = int(t[1:2]) # invariant: t has form: letter digit digit  eg i32
  if 2**memarg["align"]>tval//8: raise Exception("invalid")
  return ["i32"],[t]

def spec_validate_tloadNsx(C,t,N,memarg):
  if len(C["mems"])<1: raise Exception("invalid")
  if 2**memarg["align"]>N//8: raise Exception("invalid")
  return ["i32"],[t]

def spec_validate_tstore(C,t,memarg):
  if len(C["mems"])<1: raise Exception("invalid")
  tval = int(t[1:2]) # invariant: t has form: letter digit digit  eg i32
  if 2**memarg["align"]>tval//8: raise Exception("invalid")
  return ["i32",t],[]

def spec_validate_tstoreN(C,t,N,memarg):
  if len(C["mems"])<1: raise Exception("invalid")
  if 2**memarg["align"]>N//8: raise Exception("invalid")
  return ["i32",t],[]

def spec_validate_memorysize(C):
  if len(C["mems"])<1: raise Exception("invalid")
  return [],["i32"]

def spec_validate_memorygrow(C):
  if len(C["mems"])<1: raise Exception("invalid")
  return ["i32"],["i32"]


# 3.3.5 CONTROL INSTRUCTIONS

def spec_validate_nop():
  return [],[]

def spec_validate_uneachable():
  return ["t1*"],["t2*"]

def spec_validate_block(C,tq,instrstar):
  C["labels"].append([tq] if tq else [])
  type_ = spec_validate_instrstar(C,instrstar)  
  C["labels"].pop()
  if type_ != ([],[tq] if tq else []): raise Exception("invalid")
  return type_

def spec_validate_loop(C,tq,instrstar):
  C["labels"].append([])
  type_ = spec_validate_instrstar(C,instrstar)  
  C["labels"].pop()
  if type_ != ([],[tq] if tq else []): raise Exception("invalid")
  return type_

def spec_validate_if(C,tq,instrstar1,instrstar2):
  C["labels"].append([tq] if tq else [])
  type_ = spec_validate_instrstar(C,instrstar1)  
  if type_ != ([],[tq] if tq else []): raise Exception("invalid")
  type_ = spec_validate_instrstar(C,instrstar2)  
  if type_ != ([],[tq] if tq else []): raise Exception("invalid")
  C["labels"].pop()
  return ["i32"],[tq] if tq else []

def spec_validate_br(C,l):
  if len(C["labels"]) <= l: raise Exception("invalid")
  tq_in_brackets = C["labels"][l]
  return ["t1*"] + tq_in_brackets, ["t2*"]
  
def spec_validate_br_if(C,l):
  if len(C["labels"]) <= l: raise Exception("invalid")
  tq_in_brackets = C["labels"][l]
  return tq_in_brackets + ["i32"], tq_in_brackets

def spec_validate_br_table(C,lstar,lN):
  if len(C["labels"]) <= lN: raise Exception("invalid")
  tq_in_brackets = C["labels"][lN]
  for li in lstar:
    if len(C["labels"]) <= li: raise Exception("invalid")
    if C["labels"][li] != tq_in_brackets: raise Exception("invalid")
  return ["t1*"] + tq_in_brackes + ["i32"], ["t2*"]

def spec_validate_return(C):
  if C["return"] == None: raise Exception("invalid")
  tq_in_brackets = C["return"]
  return ["t1*"] + tq_in_brackes + ["i32"], ["t2*"]

def spec_validate_call(C,x):
  if len(C["funcs"]) <= x: raise Exception("invalid")
  return C["funcs"][x]

def spec_validate_call_indirect(C,x):
  if C["tables"]==None or len(C["tables"]) < 1: raise Exception("invalid")
  limits,elemtype = C["tables"][0]
  if elemtype != "anyfunc": raise Exception("invalid")
  if C["types"]==None or len(C["types"]) <= x: raise Exception("invalid")
  return C["types"][x][0]+["i32"],C["types"][x][1]


# 3.3.6 INSTRUCTION SEQUENCES

# We use the algorithm in the appendix for validating instruction sequences

# 3.3.7 EXPRESSIONS

def spec_validate_expr(C,expr):
  opd_stack = []
  ctrl_stack = []
  iterate_through_expression_and_validate_each_opcode(expr,C,opd_stack,ctrl_stack) # call to the algorithm in the appendix
  if len(opd_stack)>1: raise Exception("invalid")
  else: return opd_stack

def spec_validate_const_instr(C,instr):
  if instr[0] not in {"i32.const","i64.const","f32.const","f64.const","get_global"}: raise Exception("invalid")
  if instr[0] == "get_global" and C["globals"][instr[1]][0] != "const": raise Exception("invalid")
  return "const"

def spec_validate_const_expr(C,expr):
  #expr is in AST form
  stack = []
  for e in expr[:-1]:
    spec_validate_const_instr(C,e)
  if expr[-1][0] != "end": raise Exception("invalid")
  return "const"


#############
# 3.4 MODULES
#############

# 3.4.1 FUNCTIONS

def spec_validate_func(C,func,raw=None):
  x = func["type"]
  if len(C["types"])<=x: raise Exception("invalid")
  t1 = C["types"][x][0]
  t2 = C["types"][x][1]
  C["locals"] = t1 + func["locals"]
  C["labels"] = t2
  C["return"] = t2
  # validate body using algorithm in appendix
  instrstar = [["block",t2,func["body"]]] # spec didn't nest func body in a block, but algorithm in appendix gives errors otherwise
  ft = spec_validate_expr(C,instrstar)
  #clear out function-specific things
  C["locals"] = []
  C["labels"] = []
  C["return"] = []
  return ft


# 3.4.2 TABLES

def spec_validate_table(table):
  return spec_validate_tabletype(table["type"])


# 3.4.3 MEMORIES

def spec_validate_mem(mem):
  ret = spec_validate_memtype(mem["type"])
  if mem["type"]["min"]>65536: raise Exception("invalid")
  if mem["type"]["max"] and mem["type"]["max"]>65536: raise Exception("invalid")
  return ret


# 3.4.4 GLOBALS

def spec_validate_global(C,global_):
  #print("spec_validate_global(",C,global_,")")
  spec_validate_globaltype(global_["type"])
  # validate expr, but wrap it in a block first since empty control stack gives errors
  # but first wrap in block with appropriate return type
  instrstar = [["block",global_["type"][1],global_["init"]]]
  ret = spec_validate_expr(C,instrstar)
  if ret != [global_["type"][1]]: raise Exception("invalid")
  ret = spec_validate_const_expr(C,global_["init"])
  return global_["type"]


# 3.4.5 ELEMENT SEGMENT

def spec_validate_elem(C,elem):
  x = elem["table"]
  if "tables" not in C or len(C["tables"])<=x: raise Exception("invalid")
  tabletype = C["tables"][x]
  limits = tabletype[0]
  elemtype = tabletype[1]
  if elemtype != "anyfunc": raise Exception("invalid")
  # first wrap in block with appropriate return type
  instrstar = [["block","i32",elem["offset"]]]
  ret = spec_validate_expr(C,instrstar)
  if ret != ["i32"]: raise Exception("invalid")
  spec_validate_const_expr(C,elem["offset"])
  for y in elem["init"]:
    if len(C["funcs"])<=y: raise Exception("invalid")
  return 0


# 3.4.6 DATA SEGMENTS

def spec_validate_data(C,data):
  x = data["data"]
  if len(C["mems"])<=x: raise Exception("invalid")
  instrstar = [["block","i32",data["offset"]]]
  ret = spec_validate_expr(C,instrstar)
  if ret != ["i32"]: raise Exception("invalid")
  spec_validate_const_expr(C,data["offset"])
  return 0


# 3.4.7 START FUNCTION

def spec_validate_start(C,start):
  x = start["func"]
  if len(C["funcs"])<=x: raise Exception("invalid")
  if C["funcs"][x] != [[],[]]: raise Exception("invalid")
  return 0
  

# 3.4.8 EXPORTS

def spec_validate_export(C,export):
  return spec_validate_exportdesc(C,export["desc"])
  
def spec_validate_exportdesc(C,exportdesc):
  #print("C",C)
  #print("exportdesc",exportdesc)
  x = exportdesc[1]
  if exportdesc[0]=="func":
    if len(C["funcs"])<=x: raise Exception("invalid")
    return ["func",C["funcs"][x]]
  elif exportdesc[0]=="table":
    if len(C["tables"])<=x: raise Exception("invalid")
    return ["table",C["tables"][x]]
  elif exportdesc[0]=="mem":
    if len(C["mems"])<=x: raise Exception("invalid")
    return ["mem",C["mems"][x]]
  elif exportdesc[0]=="global":
    #print("global")
    #print(len(C["globals"]),x)
    if len(C["globals"])<=x: raise Exception("invalid")
    mut,t = C["globals"][x]
    #print(mut)
    #if mut != "const": raise Exception("invalid") #TODO: this was in the spec, but tests fail linking.wast: $Mg exports a mutable global, seems not to parse in wabt
    return ["global",C["globals"][x]]
  else: raise Exception("invalid")
  

# 3.4.9 IMPORTS

def spec_validate_import(C,import_):
  return spec_validate_importdesc(C,import_["desc"])
  
def spec_validate_importdesc(C,importdesc):
  if importdesc[0]=="func":
    x = importdesc[1]
    if len(C["funcs"])<=x: raise Exception("invalid")
    return ["func",C["types"][x]]
  elif importdesc[0]=="table":
    tabletype = importdesc[1]
    spec_validate_tabletype(tabletype)
    return ["table",tabletype]
  elif importdesc[0]=="mem":
    memtype = importdesc[1]
    spec_validate_memtype(memtype)
    return ["mem",memtype]
  elif importdesc[0]=="global":
    globaltype = importdesc[1]
    spec_validate_globaltype(globaltype)
    #if globaltype[0] != "const": raise Exception("invalid") #TODO: this was in the spec, but tests fail linking.wast: $Mg exports a mutable global, seems not to parse in wabt
    return ["global",globaltype]
  else: raise Exception("invalid")



# 3.4.10 MODULE

def spec_validate_module(mod):
  # mod is the module to validate
  ftstar = []
  for func in mod["funcs"]:
    if len(mod["types"]) <= func["type"]: raise Exception("invalid") # this was not explicit in spec, how about other *tstar
    ftstar += [mod["types"][func["type"]]]
  ttstar = [ table["type"] for table in mod["tables"] ]
  mtstar = [ mem["type"] for mem in mod["mems"] ]
  gtstar = [ global_["type"] for global_ in mod["globals"] ]
  itstar = []
  for import_ in mod["imports"]:
    if import_["desc"][0] == "func":
      if len(mod["types"])<=import_["desc"][1]: raise Exception("invalid") # this was not explicit in spec
      itstar.append( ["func",mod["types"][import_["desc"][1]]] )
    else:
      itstar.append( import_["desc"] )
  # let i_tstar be the concatenation of imports of each type
  iftstar = spec_funcs(itstar) #[it[1] for it in itstar if it[0]=="func"]
  ittstar = spec_tables(itstar) #[it[1] for it in itstar if it[0]=="table"]
  imtstar = spec_mems(itstar) #[it[1] for it in itstar if it[0]=="mem"]
  igtstar = spec_globals(itstar) #[it[1] for it in itstar if it[0]=="global"]
  # let C and Cprime be contexts
  C = {"types":		mod["types"],
       "funcs":		iftstar + ftstar,
       "tables":	ittstar + ttstar,
       "mems":		imtstar + mtstar,
       "globals":	igtstar + gtstar,
       "locals":	[],
       "labels":	[],
       "return":	[] }
  #print("C",C)
  Cprime = {
       "types":		[],
       "funcs":		[],
       "tables":	[],
       "mems":		[],
       "globals":	igtstar,
       "locals":	[],
       "labels":	[],
       "returns":	[] }
  # et* is needed later, here is a good place to do it
  etstar = []
  for export in mod["exports"]:
    if export["desc"][0] == "func":
      if len(C["funcs"])<=export["desc"][1]: raise Exception("invalid") # this was not explicit in spec
      etstar.append( [ "func",C["funcs"][export["desc"][1]] ] )
    elif export["desc"][0] == "table":
      if len(C["tables"])<=export["desc"][1]: raise Exception("invalid") # this was not explicit in spec
      etstar.append( ["table",C["tables"][export["desc"][1]]] )
    elif export["desc"][0] == "mem":
      if len(C["mems"])<=export["desc"][1]: raise Exception("invalid") # this was not explicit in spec
      etstar.append( ["mem",C["mems"][export["desc"][1]]] )
    elif export["desc"][0] == "global":
      if len(C["globals"])<=export["desc"][1]: raise Exception("invalid") # this was not explicit in spec
      etstar.append( ["global",C["globals"][export["desc"][1]]] )
  # under the context C
  for functypei in mod["types"]:
    spec_validate_functype(functypei)
  for i,func in enumerate(mod["funcs"]):
    ft = spec_validate_func(C, func)
    if ft != ftstar[i][1]: raise Exception("invalid")
  for i,table in enumerate(mod["tables"]):
    tt = spec_validate_table(table)
    if tt != ttstar[i]: raise Exception("invalid")
  for i,mem in enumerate(mod["mems"]):
    mt = spec_validate_mem(mem)
    if mt != mtstar[i]: raise Exception("invalid")
  for i,global_ in enumerate(mod["globals"]):
    gt = spec_validate_global(Cprime,global_)
    if gt != gtstar[i]: raise Exception("invalid")
  for elem in mod["elem"]:
    spec_validate_elem(C,elem)
  for data in mod["data"]:
    spec_validate_data(C,data)
  if mod["start"]:
    spec_validate_start(C,mod["start"])
  for i,import_ in enumerate(mod["imports"]):
    it = spec_validate_import(C,import_)
    if it != itstar[i]: raise Exception("invalid")
  #print("ok9")
  #print("mod[\"exports\"]",mod["exports"])
  for i,export in enumerate(mod["exports"]):
    et = spec_validate_export(C,export)
    #print("ok9.5")
    if et != etstar[i]: raise Exception("invalid")
  #print("ok10")
  if len(C["tables"])>1: raise Exception("invalid")
  if len(C["mems"])>1: raise Exception("invalid")
  # export names must be unique
  exportnames = set()
  for export in mod["exports"]:
    if export["name"] in exportnames: raise Exception("invalid")
    exportnames.add(export["name"])
  return [itstar, etstar]











###############
###############
# 4 EXECUTION #
###############
###############

#Chapter 4 defines execution semantics over the abstract syntax.
  

##############
# 4.3 NUMERICS
##############

def spec_trunc(q):
  if verbose>=1: print("spec_trunc(",q,")")
  # round towards zero
  # q can be float or rational as tuple (numerator,denominator)
  if type(q)==tuple: #rational
    result = q[0]//q[1] #rounds towards negative infinity
    if result < 0 and q[1]*result != q[0]:
      return result+1
    else:
      return result
  elif type(q)==float:
    #using ftrunc instead
    return int(q) 


# 4.3.1 REPRESENTATIONS

# bits are string of 1s and 0s
# bytes are bytearray (maybe can also read from memoryview)

def spec_bitst(t,c):
  if verbose>=1: print("spec_bitst(",t,c,")")
  N = int(t[1:3])
  if t[0]=='i':
    return spec_bitsiN(N,c)
  elif t[0]=='f':
    return spec_bitsfN(N,c)

def spec_bitst_inv(t,bits):
  if verbose>=1: print("spec_bitst_inv(",t,bits,")")
  N = int(t[1:3])
  if t[0]=='i':
    return spec_bitsiN_inv(N,bits)
  elif t[0]=='f':
    return spec_bitsfN_inv(N,bits)

def spec_bitsiN(N,i):
  if verbose>=1: print("spec_bitsiN(",N,i,")")
  return spec_ibitsN(N,i)

def spec_bitsiN_inv(N,bits):
  if verbose>=1: print("spec_bitsiN_inv(",N,bits,")")
  return spec_ibitsN_inv(N,bits)

def spec_bitsfN(N,z):
  if verbose>=1: print("spec_bitsfN(",N,z,")")
  return spec_fbitsN(N,z)

def spec_bitsfN_inv(N,bits):
  if verbose>=1: print("spec_bitsfN_inv(",N,bits,")")
  return spec_fbitsN_inv(N,bits)


# Integers

def spec_ibitsN(N,i):
  if verbose>=1: print("spec_ibitsN(",N,i,")")
  #print(bin(i)[2:].zfill(N))
  return bin(i)[2:].zfill(N)

def spec_ibitsN_inv(N,bits):
  if verbose>=1: print("spec_ibitsN_inv(",N,bits,")")
  return int(bits,2)


# Floating-Point

def spec_fbitsN(N,z):
  if verbose>=1: print("spec_fbitsN(",N,z,")")
  if N==32:
    z_bytes = struct.pack('>f',z)
  elif N==64:
    z_bytes = struct.pack('>d',z)
  #stryct.pack() gave us bytes, need bits
  bits = ''
  for byte in z_bytes:
    bits += bin( int(byte) ).lstrip('0b').zfill(8)
  return bits

def spec_fbitsN_inv(N,bits):
  # this is used by reinterpret
  if verbose>=1: print("spec_fbitsN_inv(",N,bits,")")
  #will use struct.unpack() so need bytearray
  bytes_ = bytearray()
  for i in range(len(bits)//8):
    bytes_ += bytearray( [int(bits[8*i:8*(i+1)],2)] )
  if N==32:
    z = struct.unpack('>f',bytes_)[0]
  elif N==64:
    z = struct.unpack('>d',bytes_)[0]
  return z

def spec_fsign(z):
  bytes_ = spec_bytest("f"+str(64),z)
  #print("fsign bytes_",bytes_, [bin(byte).lstrip('0b').zfill(8) for byte in bytes_])
  sign = bytes_[-1] & 0b10000000	#-1 since littleendian
  #print("spec_fsign(",z,")",sign)
  if sign: return 1
  else: return 0
  #z_bytes = struct.pack('d',z)
  #if bin(z_bytes[0]).replace('0b','')[0] == '1':
  #  return 1
  #else:
  #  return 0

# decided to just use struct.pack() and struct.unpack()
# other options to represent floating point numbers:
#   float which is 64-bit, for 32-bit, can truncate significand and exponent after each operation
#   ctypes.c_float and ctypes.c_double 
#   numpy.float32 and numpy.float64


# Storage

def spec_bytest(t,i):
  if verbose>=1: print("spec_bytest(",t,i,")")
  if t[0]=='i':
    bits = spec_bitsiN(int(t[1:3]),i)
  elif t[0]=='f':
    bits = spec_bitsfN(int(t[1:3]),i)
  return spec_littleendian(bits)

def spec_bytest_inv(t,bytes_):
  if verbose>=1: print("spec_bytest_inv(",t,bytes_,")")
  bits = spec_littleendian_inv(bytes_)
  if t[0]=='i':
    return spec_bitsiN_inv(int(t[1:3]),bits)
  elif t[0]=='f':
    return spec_bitsfN_inv(int(t[1:3]),bits)


def spec_bytesiN(N,i):
  if verbose>=1: print("spec_bytesiN(",N,i,")")
  bits = spec_bitsiN(N,i)
  #convert bits to bytes
  bytes_ = bytearray()
  for byteIdx in range(0,len(bits),8):
    bytes_ += bytearray([int(bits[byteIdx:byteIdx+8],2)])
  return bytes_

def spec_bytesiN_inv(N,bytes_):
  if verbose>=1: print("spec_bytesiN_inv(",N,bytes_,")")
  bits=""
  for byte in bytes_:
    bits += spec_ibitsN(8,byte)
  return spec_ibitsN_inv(N,bits)


# TODO: these are unused, but might use when refactor floats to pass NaN significand tests
def spec_bytesfN(N,z):
  if verbose>=1: print("spec_bytesfN(",N,z,")")
  if N==32:
    z_bytes = struct.pack('>f',z)
  elif N==64:
    z_bytes = struct.pack('>d',z)
  return z_bytes
  
def spec_bytesfN_inv(N,bytes_):
  if verbose>=1: print("spec_bytesfN_inv(",N,bytes_,")")
  if N==32:
    z = struct.unpack('>f',bytes_)[0]
  elif N==64:
    z = struct.unpack('>d',bytes_)[0]
  return z


def spec_littleendian(d):
  if verbose>=1: print("spec_littleendian(",d,")")
  #same behavior for both 32 and 64-bit values
  #this assumes len(d) is divisible by 8
  if len(d)==0: return bytearray()
  d18 = d[:8]
  d2Nm8 = d[8:]
  d18_as_int = spec_ibitsN_inv(8,d18)
  return spec_littleendian(d2Nm8) + bytearray([d18_as_int])
  #return bytearray([d18_as_int]) + spec_littleendian(d2Nm8) 

def spec_littleendian_inv(bytes_):
  if verbose>=1: print("spec_littleendian_inv(",bytes_,")")
  #same behavior for both 32 and 64-bit values
  #this assumes len(d) is divisible by 8
  #this converts bytes to bits
  if len(bytes_)==0: return ''
  bits = bin( int(bytes_[-1]) ).lstrip('0b').zfill(8)
  return bits + spec_littleendian_inv( bytes_[:-1] )
  #bits = bin( int(bytes_[0]) ).lstrip('0b').zfill(8)
  #return spec_littleendian_inv( bytes_[1:] ) + bits



# 4.3.2 INTEGER OPERATIONS


#two's comlement
def spec_signediN(N,i):
  if verbose>=1: print("spec_signediN(",N,i,")")
  if 0<=i<2**(N-1):
    return i
  elif 2**(N-1)<=i<2**N:
    return i-2**N
  #alternative 2's comlement
  #  return i - int((i << 1) & 2**N) #https://stackoverflow.com/a/36338336

def spec_signediN_inv(N,i):
  if verbose>=1: print("spec_signediN_inv(",N,i,")")
  if 0<=i<2**(N-1):
    return i
  elif -1*(2**(N-1))<=i<0:
    return i+2**N
  else:
    return None

def spec_iaddN(N,i1,i2):
  if verbose>=1: print("spec_iaddN(",N,i1,i2,")")
  return (i1+i2) % 2**N

def spec_isubN(N,i1,i2):
  if verbose>=1: print("spec_isubN(",N,i1,i2,")")
  return (i1-i2+2**N) % 2**N

def spec_imulN(N,i1,i2):
  if verbose>=1: print("spec_imulN(",N,i1,i2,")")
  return (i1*i2) % 2**N

def spec_idiv_uN(N,i1,i2):
  if verbose>=1: print("spec_idiv_uN(",N,i1,i2,")")
  if i2==0: raise Exception("trap")
  return spec_trunc((i1,i2))

def spec_idiv_sN(N,i1,i2):
  if verbose>=1: print("spec_idiv_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if j2==0: raise Exception("trap")
  #assuming j1 and j2 are N-bit
  if j1//j2 == 2**(N-1): raise Exception("trap")
  return spec_signediN_inv(N,spec_trunc((j1,j2)))

def spec_irem_uN(N,i1,i2):
  if verbose>=1: print("spec_irem_uN(",i1,i2,")")
  if i2==0:raise Exception("trap")
  return i1-i2*spec_trunc((i1,i2))

def spec_irem_sN(N,i1,i2):
  if verbose>=1: print("spec_irem_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if i2==0: raise Exception("trap")
  #print(j1,j2,spec_trunc((j1,j2)))
  return spec_signediN_inv(N,j1-j2*spec_trunc((j1,j2)))
  
def spec_iandN(N,i1,i2):
  if verbose>=1: print("spec_iandN(",N,i1,i2,")")
  return i1 & i2

def spec_iorN(N,i1,i2):
  if verbose>=1: print("spec_iorN(",N,i1,i2,")")
  return i1 | i2

def spec_ixorN(N,i1,i2):
  if verbose>=1: print("spec_ixorN(",N,i1,i2,")")
  return i1 ^ i2
 
def spec_ishlN(N,i1,i2):
  if verbose>=1: print("spec_ishlN(",N,i1,i2,")")
  k = i2 % N
  return (i1 << k) % (2**N)

def spec_ishr_uN(N,i1,i2):
  if verbose>=1: print("spec_ishr_uN(",N,i1,i2,")")
  j2 = i2 % N
  return i1 >> j2
  
def spec_ishr_sN(N,i1,i2):
  if verbose>=1: print("spec_ishr_sN(",N,i1,i2,")")
  #print("spec_ishr_sN(",N,i1,i2,")")
  k = i2 % N
  #print(k)
  d0d1Nmkm1d2k = spec_ibitsN(N,i1)
  d0 = d0d1Nmkm1d2k[0]
  d1Nmkm1 = d0d1Nmkm1d2k[1:N-k]
  #print(d0*k)
  #print(d0*(k+1) + d1Nmkm1)
  return spec_ibitsN_inv(N, d0*(k+1) + d1Nmkm1 )

def spec_irotlN(N,i1,i2):
  if verbose>=1: print("spec_irotlN(",N,i1,i2,")")
  k = i2 % N
  d1kd2Nmk = spec_ibitsN(N,i1)
  d2Nmk = d1kd2Nmk[k:]
  d1k = d1kd2Nmk[:k]
  return spec_ibitsN_inv(N, d2Nmk+d1k )

def spec_irotrN(N,i1,i2):
  if verbose>=1: print("spec_irotrN(",N,i1,i2,")")
  k = i2 % N
  d1Nmkd2k = spec_ibitsN(N,i1)
  d1Nmk = d1Nmkd2k[:N-k]
  d2k = d1Nmkd2k[N-k:]
  return spec_ibitsN_inv(N, d2k+d1Nmk )

def spec_iclzN(N,i):
  if verbose>=1: print("spec_iclzN(",N,i,")")
  k = 0
  for b in spec_ibitsN(N,i):
    if b=='0':
      k+=1
    else:
      break
  return k

def spec_ictzN(N,i):
  if verbose>=1: print("spec_ictzN(",N,i,")")
  k = 0
  for b in reversed(spec_ibitsN(N,i)):
    if b=='0':
      k+=1
    else:
      break
  return k

def spec_ipopcntN(N,i):
  if verbose>=1: print("spec_ipopcntN(",N,i,")")
  k = 0
  for b in spec_ibitsN(N,i):
    if b=='1':
      k+=1
  return k

def spec_ieqzN(N,i):
  if verbose>=1: print("spec_ieqzN(",N,i,")")
  if i==0:
    return 1
  else:
    return 0

def spec_ieqN(N,i1,i2):
  if verbose>=1: print("spec_ieqN(",N,i1,i2,")")
  if i1==i2:
    return 1
  else:
    return 0

def spec_ineN(N,i1,i2):
  if verbose>=1: print("spec_ineN(",N,i1,i2,")")
  if i1!=i2:
    return 1
  else:
    return 0

def spec_ilt_uN(N,i1,i2):
  if verbose>=1: print("spec_ilt_uN(",N,i1,i2,")")
  if i1<i2:
    return 1
  else:
    return 0

def spec_ilt_sN(N,i1,i2):
  if verbose>=1: print("spec_ilt_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if j1<j2:
    return 1
  else:
    return 0

def spec_igt_uN(N,i1,i2):
  if verbose>=1: print("spec_igt_uN(",N,i1,i2,")")
  if i1>i2:
    return 1
  else:
    return 0

def spec_igt_sN(N,i1,i2):
  if verbose>=1: print("spec_igt_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if j1>j2:
    return 1
  else:
    return 0

def spec_ile_uN(N,i1,i2):
  if verbose>=1: print("spec_ile_uN(",N,i2,i1,")")
  if i1<=i2:
    return 1
  else:
    return 0

def spec_ile_sN(N,i1,i2):
  if verbose>=1: print("spec_ile_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if j1<=j2:
    return 1
  else:
    return 0

def spec_ige_uN(N,i1,i2):
  if verbose>=1: print("spec_ige_uN(",N,i1,i2,")")
  if i1>=i2:
    return 1
  else:
    return 0

def spec_ige_sN(N,i1,i2):
  if verbose>=1: print("spec_ige_sN(",N,i1,i2,")")
  j1 = spec_signediN(N,i1)
  j2 = spec_signediN(N,i2)
  if j1>=j2:
    return 1
  else:
    return 0


# 4.3.3 FLOATING-POINT OPERATIONS


def spec_fabsN(N,z):
  if verbose>=1: print("spec_fabsN(",N,z,")")
  #print("spec_fabsN(",N,z,")")
  sign = spec_fsign(z)
  #print(sign)
  if sign == 0:
    return z
  else:
    return spec_fnegN(N,z)

def spec_fnegN(N,z):
  if verbose>=1: print("spec_fnegN(",N,z,")")
  #get bytes and sign
  bytes_ = spec_bytest("f64",z)	#64 since errors if z too bit for 32
  sign = spec_fsign(z)
  if sign == 0:
    bytes_[-1] |= 0b10000000	#-1 since littleendian
  else:
    bytes_[-1] &= 0b01111111	#-1 since littleendian
  z = spec_bytest_inv("f64",bytes_)	#64 since errors if z too bit for 32
  return z

def spec_fceilN(N,z):
  if verbose>=1: print("spec_fceilN(",N,z,")")
  if math.isnan(z):
    return z
  elif math.isinf(z):
    return z
  elif z==0:
    return z
  elif -1.0<z<0.0:
    return -0.0
  else:
    return float(math.ceil(z))

def spec_ffloorN(N,z):
  if verbose>=1: print("spec_ffloorN(",N,z,")")
  if math.isnan(z):
    return z
  elif math.isinf(z):
    return z
  elif z==0:
    return z
  elif 0.0<z<1.0:
    return 0.0
  else:
    return float(math.floor(z))

def spec_ftruncN(N,z):
  if verbose>=1: print("spec_ftruncN(",N,z,")")
  if math.isnan(z):
    return z
  elif math.isinf(z):
    return z
  elif z==0:
    return z
  elif 0.0<z<1.0:
    return 0.0
  elif -1.0<z<0.0:
    return -0.0
  else:
    magnitude = spec_fabsN(N,z)
    floormagnitude = spec_ffloorN(N,magnitude)
    return floormagnitude * (-1 if spec_fsign(z) else 1) 	#math.floor(z)) + spec_fsign(z) 

def spec_fnearestN(N,z):
  if verbose>=1: print("spec_fnearestN(",N,z,")")
  if math.isnan(z):
    return z
  elif math.isinf(z):
    return z
  elif z==0:
    return z
  elif 0.0 < z <= 0.5:
    return 0.0
  elif -0.5 <= z < 0.0:
    return -0.0
  else:
    return float(round(z))

def spec_fsqrtN(N,z):
  if verbose>=1: print("spec_fsqrtN(",N,z,")")
  if math.isnan(z) or (spec_fsign(z)==1 and z!=0):
    return float('nan')
  else:
    return math.sqrt(z)

def spec_faddN(N,z1,z2):
  if verbose>=1: print("spec_faddN(",N,z1,z2,")")
  res = z1+z2
  if N==32:
    res = spec_demoteMN(64,32,res)
  return res

def spec_fsubN(N,z1,z2):
  if verbose>=1: print("spec_fsubN(",N,z1,z2,")")
  res = z1-z2
  #print("z1-z2:",z1-z2)
  if N==32:
    res = spec_demoteMN(64,32,res)
    #print("demoted z1-z2:",res)
  return res

def spec_fmulN(N,z1,z2):
  if verbose>=1: print("spec_fmulN(",N,z1,z2,")")
  res = z1*z2
  if N==32:
    res = spec_demoteMN(64,32,res)
  return res

def spec_fdivN(N,z1,z2):
  if verbose>=1: print("spec_fdivN(",N,z1,z2,")")
  if math.isnan(z1):
    return z1
  elif math.isnan(z2):
    return z2
  elif math.isinf(z1) and math.isinf(z2):
    return float('nan')
  elif z1==0.0 and z2==0.0:
    return float('nan')
  elif z1==0.0 and z2==0.0:
    return float('nan')
  elif math.isinf(z1):
    if spec_fsign(z1) == spec_fsign(z2):
      return float('inf')
    else:
      return -float('inf')
  elif math.isinf(z2):
    if spec_fsign(z1) == spec_fsign(z2):
      return 0.0
    else:
      return -0.0
  elif z1==0:
    if spec_fsign(z1) == spec_fsign(z2):
      return 0.0
    else:
      return -0.0
  elif z2==0:
    if spec_fsign(z1) == spec_fsign(z2):
      return float('inf')
    else:
      return -float('inf')
  else:
    res = z1/z2
    if N==32:
      res = spec_demoteMN(64,32,res)
    return res

def spec_fminN(N,z1,z2):
  if verbose>=1: print("spec_fminN(",N,z1,z2,")")
  if math.isnan(z1):
    return z1
  elif math.isnan(z2):
    return z2
  elif z1==-float('inf') or z2==-float('inf'):
    return -float('inf')
  elif z1 == float('inf'):
    return z2
  elif z2 == float('inf'):
    return z1
  elif z1==z2==0.0:
    if spec_fsign(z1) != spec_fsign(z2):
      return -0.0
    else:
      return z1
  elif z1 <= z2:
    return z1
  else:
    return z2

def spec_fmaxN(N,z1,z2):
  if verbose>=1: print("spec_fmaxN(",N,z1,z2,")")
  if math.isnan(z1):
    return z1
  elif math.isnan(z2):
    return z2
  elif z1==float('inf') or z2==float('inf') :
    return float('inf')
  elif z1 == -float('inf'):
    return z2
  elif z2 == -float('inf'):
    return z1
  elif z1==z2==0.0:
    if spec_fsign(z1) != spec_fsign(z2):
      return 0.0
    else:
      return z1
  elif z1 <= z2:
    return z2
  else:
    return z1

def spec_fcopysignN(N,z1,z2):
  if verbose>=1: print("spec_fcopysignN(",N,z1,z2,")")
  z1sign = spec_fsign(z1)
  z2sign = spec_fsign(z2)
  if z1sign == z2sign:
    return z1
  else:
    z1bytes = spec_bytest("f"+str(N),z1)
    if z1sign == 0:
      z1bytes[-1] |= 0b10000000		#-1 since littleendian
    else:
      z1bytes[-1] &= 0b01111111		#-1 since littleendian
    z1 = spec_bytest_inv("f"+str(N),z1bytes)
    return z1

def spec_feqN(N,z1,z2):
  if verbose>=1: print("spec_feqN(",N,z1,z2,")")
  if z1==z2:
    return 1
  else:
    return 0

def spec_fneN(N,z1,z2):
  if verbose>=1: print("spec_fneN(",N,z1,z2,")")
  if z1 != z2:
    return 1
  else:
    return 0

def spec_fltN(N,z1,z2):
  if verbose>=1: print("spec_fltN(",N,z1,z2,")")
  if math.isnan(z1):
    return 0
  elif math.isnan(z2):
    return 0
  elif spec_bitsfN(N,z1)==spec_bitsfN(N,z2):
    return 0
  elif z1==float('inf'):
    return 0
  elif z1==-float('inf'):
    return 1
  elif z2==float('inf'):
    return 1
  elif z2==-float('inf'):
    return 0
  elif z1==z2==0:
    return 0
  elif z1 < z2:
    return 1
  else:
    return 0

def spec_fgtN(N,z1,z2):
  if verbose>=1: print("spec_fgtN(",N,z1,z2,")")
  if math.isnan(z1):
    return 0
  elif math.isnan(z2):
    return 0
  elif spec_bitsfN(N,z1)==spec_bitsfN(N,z2):
    return 0
  elif z1==float('inf'):
    return 1
  elif z1==-float('inf'):
    return 0
  elif z2==float('inf'):
    return 0
  elif z2==-float('inf'):
    return 1
  elif z1==z2==0:
    return 0
  elif z1 > z2:
    return 1
  else:
    return 0

def spec_fleN(N,z1,z2):
  if verbose>=1: print("spec_fleN(",N,z1,z2,")")
  if math.isnan(z1):
    return 0
  elif math.isnan(z2):
    return 0
  elif spec_bitsfN(N,z1)==spec_bitsfN(N,z2):
    return 1
  elif z1==float('inf'):
    return 0
  elif z1==-float('inf'):
    return 1
  elif z2==float('inf'):
    return 1
  elif z2==-float('inf'):
    return 0
  elif z1==z2==0:
    return 1
  elif z1 <= z2:
    return 1
  else:
    return 0

def spec_fgeN(N,z1,z2):
  if verbose>=1: print("spec_fgeN(",N,z1,z2,")")
  if math.isnan(z1):
    return 0
  elif math.isnan(z2):
    return 0
  elif spec_bitsfN(N,z1)==spec_bitsfN(N,z2):
    return 1
  elif z1==float('inf'):
    return 1
  elif z1==-float('inf'):
    return 0
  elif z2==float('inf'):
    return 0
  elif z2==-float('inf'):
    return 1
  elif z1==z2==0:
    return 1
  elif z1 >= z2:
    return 1
  else:
    return 0



# 4.3.4 CONVERSIONS

def spec_extend_uMN(M,N,i):
  if verbose>=1: print("spec_extend_uMN(",i,")")
  return i

def spec_extend_sMN(M,N,i):
  if verbose>=1: print("spec_extend_sMN(",M,N,i,")")
  #print("spec_extend_sMN(",M,N,i,")")
  j = spec_signediN(M,i)
  return spec_signediN_inv(N,j)

def spec_wrapMN(M,N,i):
  if verbose>=1: print("spec_wrapMN(",M,N,i,")")
  #print("spec_wrapMN(",M,N,i,")")
  return i % (2**N)

def spec_trunc_uMN(M,N,z):
  if verbose>=1: print("spec_trunc_uMN(",M,N,z,")")
  if math.isnan(z) or math.isinf(z): raise Exception("trap")
  ztrunc = spec_ftruncN(M,z) 
  if -1 < ztrunc < 2**N:
    return int(ztrunc)
  else: raise Exception("trap")

def spec_trunc_sMN(M,N,z):
  if verbose>=1: print("spec_trunc_sMN(",M,N,z,")")
  if math.isnan(z) or math.isinf(z): raise Exception("trap")
  ztrunc = spec_ftruncN(M,z) 
  if -(2**(N-1))-1 < ztrunc < 2**(N-1):
    iztrunc = int(ztrunc)
    if iztrunc < 0:
      return spec_signediN_inv(N,iztrunc)
    else:
      return iztrunc
  else:
    raise Exception("trap")

def spec_promoteMN(M,N,z):
  if verbose>=1: print("spec_promoteMN(",M,N,z,")")
  return z

def spec_demoteMN(M,N,z):
  if verbose>=1: print("spec_demoteMN(",M,N,z,")")
  absz = spec_fabsN(N,z)
  #limitN = 2**(2**(spec_expon(N)-1))
  limitN = 2**128 * (1 - 2**-25)	#this FLT_MAX is slightly different than the Wasm spec's 2**127
  if absz >= limitN:
    signz = spec_fsign(z)
    if signz:
      return -float('inf')
    else:
      return float('inf')
  bytes_ = spec_bytest('f32',z)
  z32 = spec_bytest_inv('f32',bytes_)
  return z32

def spec_convert_uMN(M,N,i):
  if verbose>=1: print("spec_convert_uMN(",M,N,i,")")
  limitN = 2**(2**(spec_expon(N)-1))
  if i >= limitN:
    return float('inf')
  return float(i)

def spec_convert_sMN(M,N,i):
  if verbose>=1: print("spec_convert_sMN(",M,N,i,")")
  limitN = 2**(2**(spec_expon(N)-1))
  #print("limitN",limitN)
  if i >= limitN:
    return float('inf')
  if i <= -1*limitN:
    return -float('inf')
  i = spec_signediN(M,i)
  return float(i)

def spec_reinterprett1t2(t1,t2,c):
  if verbose>=1: print("spec_reinterprett1t2(",t1,t2,c,")")
  #print("spec_reinterprett1t2(",t1,t2,c,")")
  bits = spec_bitst(t1,c)
  #print(bits)
  return spec_bitst_inv(t2,bits)


##################
# 4.4 INSTRUCTIONS
##################

# S is the store

# 4.4.1 NUMERIC INSTRUCTIONS

def spec_tconst(config):
  if verbose>=1: print("spec_tconst(",")")
  S = config["S"]
  c = config["instrstar"][config["idx"]][1]
  if verbose>=1: print("spec_tconst(",c,")")
  config["operand_stack"] += [c]
  config["idx"] += 1

def spec_tunop(config):	# t is in {'i32','i64','f32','f64'}
  if verbose>=1: print("spec_tunop(",")")
  S = config["S"]
  instr = config["instrstar"][config["idx"]][0]
  t = instr[0:3]
  op = opcode2exec[instr][1]
  c1 = config["operand_stack"].pop()
  c = op(int(t[1:3]),c1)
  if c == "trap": return c
  config["operand_stack"].append(c)
  config["idx"] += 1

def spec_tbinop(config):
  if verbose>=1: print("spec_tbinop(",")")
  S = config["S"]
  instr = config["instrstar"][config["idx"]][0]
  t = instr[0:3]
  op = opcode2exec[instr][1]
  c2 = config["operand_stack"].pop()
  c1 = config["operand_stack"].pop()
  c = op(int(t[1:3]),c1,c2)
  if c == "trap": return c
  config["operand_stack"].append(c)
  config["idx"] += 1
  
def spec_ttestop(config):
  if verbose>=1: print("spec_ttestop(",")")
  S = config["S"]
  instr = config["instrstar"][config["idx"]][0]
  t = instr[0:3]
  op = opcode2exec[instr][1]
  c1 = config["operand_stack"].pop()
  c = op(int(t[1:3]),c1)
  if c == "trap": return c
  config["operand_stack"].append(c)
  config["idx"] += 1
  
def spec_trelop(config):
  if verbose>=1: print("spec_trelop(",")")
  S = config["S"]
  instr = config["instrstar"][config["idx"]][0]
  t = instr[0:3]
  op = opcode2exec[instr][1]
  c2 = config["operand_stack"].pop()
  c1 = config["operand_stack"].pop()
  c = op(int(t[1:3]),c1,c2)
  if c == "trap": return c
  config["operand_stack"].append(c)
  config["idx"] += 1

def spec_t2cvtopt1(config):
  if verbose>=1: print("spec_t2crtopt1(",")")
  S = config["S"]
  instr = config["instrstar"][config["idx"]][0]
  t2 = instr[0:3]
  t1 = instr[-3:]
  op = opcode2exec[instr][1]
  c1 = config["operand_stack"].pop()
  if instr[4:15] == "reinterpret":
    c2 = op(t1,t2,c1)
  else:
    c2 = op(int(t1[1:]),int(t2[1:]),c1)
  if c2 == "trap": return c2
  config["operand_stack"].append(c2)
  config["idx"] += 1


# 4.4.2 PARAMETRIC INSTRUCTIONS
 
def spec_drop(config):
  if verbose>=1: print("spec_drop(",")")
  S = config["S"]
  config["operand_stack"].pop()
  config["idx"] += 1
  
def spec_select(config):
  if verbose>=1: print("spec_select(",")")
  S = config["S"]
  operand_stack = config["operand_stack"]
  c = operand_stack.pop()
  val1 = operand_stack.pop()
  val2 = operand_stack.pop()
  if not c:
    operand_stack.append(val1)
  else:
    operand_stack.append(val2)
  config["idx"] += 1

# 4.4.3 VARIABLE INSTRUCTIONS

def spec_get_local(config):
  if verbose>=1: print("spec_get_local(",")")
  S = config["S"]
  F = config["F"]
  x = config["instrstar"][config["idx"]][1]
  #print(F)
  #print(F[-1])
  #print(F[-1]["locals"])
  #print(x)
  val = F[-1]["locals"][x]
  config["operand_stack"].append(val)
  config["idx"] += 1

def spec_set_local(config):
  if verbose>=1: print("spec_set_local(",")")
  S = config["S"]
  F = config["F"]
  x = config["instrstar"][config["idx"]][1]
  val = config["operand_stack"].pop()
  F[-1]["locals"][x] = val
  config["idx"] += 1

def spec_tee_local(config):
  if verbose>=1: print("spec_tee_local(",")")
  S = config["S"]
  x = config["instrstar"][config["idx"]][1]
  operand_stack = config["operand_stack"]
  val = operand_stack.pop()
  operand_stack.append(val)
  operand_stack.append(val)
  spec_set_local(config)
  #config["idx"] += 1
  
def spec_get_global(config):
  if verbose>=1: print("spec_get_global(",")")
  S = config["S"]
  F = config["F"]
  #print("F[-1]",F[-1])
  x = config["instrstar"][config["idx"]][1]
  a = F[-1]["module"]["globaladdrs"][x]
  glob = S["globals"][a]
  val = glob["value"][1]	#*** omit the type eg 'i32.const', just get the value, see above for how this is different from the spec
  config["operand_stack"].append(val)
  config["idx"] += 1

def spec_set_global(config):
  if verbose>=1: print("spec_set_global(",")")
  S = config["S"]
  F = config["F"]
  x = config["instrstar"][config["idx"]][1]
  a = F[-1]["module"]["globaladdrs"][x]
  glob = S["globals"][a]
  val = config["operand_stack"].pop()
  glob["value"][1] = val
  config["idx"] += 1


# 4.4.4 MEMORY INSTRUCTIONS

# this is for both t.load and t.loadN_sx
def spec_tload(config):
  if verbose>=1: print("spec_tload(",")")
  S = config["S"]
  F = config["F"]
  instr = config["instrstar"][config["idx"]][0]
  memarg = config["instrstar"][config["idx"]][1]
  t = instr[:3]
  # 3
  a = F[-1]["module"]["memaddrs"][0]
  # 5
  mem = S["mems"][a]
  # 7
  i = config["operand_stack"].pop()
  # 8
  ea = i+memarg["offset"] 
  # 9
  sxflag = False
  if instr[3:] != ".load":  # N is part of the opcode eg i32.load8_s has N=8
    if instr[-1] == "s":
      sxflag = True
    N = int(instr[8:10].strip("_"))
  else:
    N=int(t[1:])
  # 10
  if ea+N//8 > len(mem["data"]): raise Exception("trap")
  # 11
  bstar = mem["data"][ea:ea+N//8]
  # 12
  if sxflag:
    n = spec_bytest_inv(t,bstar)
    c = spec_extend_sMN(N,int(t[1:]),n)
  else:
    c = spec_bytest_inv(t,bstar)
  # 13
  config["operand_stack"].append(c)
  if verbose>=2: print("loaded",c,"from memory locations",ea,"to",ea+N//8)
  config["idx"] += 1

def spec_tstore(config):
  if verbose>=1: print("spec_tstore(",")")
  S = config["S"]
  F = config["F"]
  instr = config["instrstar"][config["idx"]][0]
  memarg = config["instrstar"][config["idx"]][1]
  t = instr[:3]
  # 3
  a = F[-1]["module"]["memaddrs"][0]
  # 5
  mem = S["mems"][a]
  # 7
  c = config["operand_stack"].pop()
  # 9
  i = config["operand_stack"].pop()
  # 10
  ea = i+memarg["offset"]
  # 11
  Nflag = False 
  if instr[3:] != ".store":  # N is part of the instruction, eg i32.store8
    Nflag = True
    N=int(instr[9:])
  else:
    N=int(t[1:])
  # 12
  if ea+N//8 > len(mem["data"]): raise Exception("trap")
  # 13
  if Nflag:
    M=int(t[1:])
    c = spec_wrapMN(M,N,c)
    bstar = spec_bytest(t,c)
  else:
    bstar = spec_bytest(t,c)
  # 15
  mem["data"][ea:ea+N//8] = bstar[:N//8]
  #if verbose>=2: print("stored",[bin(byte).strip('0b').zfill(8) for byte in bstar[:N//8]],"to memory locations",ea,"to",ea+N//8)
  config["idx"] += 1

def spec_memorysize(config):
  if verbose>=1: print("spec_memorysize(",")")
  S = config["S"]
  F = config["F"]
  a = F[-1]["module"]["memaddrs"][0]
  mem = S["mems"][a]
  sz = len(mem["data"])//65536  #page size = 64 Ki = 65536
  config["operand_stack"].append(sz)
  config["idx"] += 1

def spec_memorygrow(config):
  if verbose>=1: print("spec_memorygrow(",")")
  S = config["S"]
  F = config["F"]
  a = F[-1]["module"]["memaddrs"][0]
  mem = S["mems"][a]
  sz = len(mem["data"])//65536  #page size = 64 Ki = 65536
  n = config["operand_stack"].pop()
  spec_growmem(mem,n)
  if sz+n == len(mem["data"])//65536: #success
    config["operand_stack"].append(sz)
  else: 
    config["operand_stack"].append(2**32-1) #put -1 on top of stack
  config["idx"] += 1
    
  
# 4.4.5 CONTROL INSTRUCTIONS


"""
 This implementation deviates from the spec as follows.
   - Three stacks are maintained, operands, control-flow labels, and function-call frames.
     Operand_stack holds only values, control_stack holds only labels. The function-call frames are mainted implicitly in Python function calls -- this will be changed, putting function call frames into the label stack or into their own stack.
   - `config` inculdes store S, frame F, instr_list, idx into this instr_list, operand_stack, and control_stack.
   - Each label L has extra value for height of operand stack when it started, continuation when it is branched to, and end when it's last instruction is called.
"""

def spec_nop(config):
  if verbose>=1: print("spec_nop(",")")
  config["idx"] += 1

def spec_unreachable(config):
  if verbose>=1: print("spec_unreachable(",")")
  raise Exception("trap")


def spec_block(config):
  if verbose>=1: print("spec_block(",")")
  instrstar = config["instrstar"]
  idx = config["idx"]
  operand_stack = config["operand_stack"]
  control_stack = config["control_stack"]
  t = instrstar[idx][1]
  # 1
  if type(t) == str:
    n=1
  elif type(t) == list:
    n=len(t)
  # 2
  continuation = [instrstar,idx+1]
  L = {"arity":n, "height":len(operand_stack), "continuation":continuation, "end":continuation}
  # 3
  spec_enter_block(config,instrstar[idx][2],L)
  #control_stack.append(L)
  #config["instrstar"] = instrstar[idx][2]
  #config["idx"] = 0

def spec_loop(config):
  if verbose>=1: print("spec_loop(",")")
  instrstar = config["instrstar"]
  idx = config["idx"]
  operand_stack = config["operand_stack"]
  control_stack = config["control_stack"]
  # 1
  continuation = [instrstar[idx][2],0]
  end = [instrstar,idx+1]
  L = {"arity":0, "height":len(operand_stack), "continuation":continuation, "end":end, "loop_flag":1}
  # 2
  spec_enter_block(config,instrstar[idx][2],L)
  #control_stack.append(L)
  #config["instrstar"] = instrstar[idx][2]
  #config["idx"] = 0

def spec_if(config):
  if verbose>=1: print("spec_if(",")")
  instrstar = config["instrstar"]
  idx = config["idx"]
  operand_stack = config["operand_stack"]
  control_stack = config["control_stack"]
  # 2
  c = operand_stack.pop()
  # 3
  t = instrstar[idx][1]
  if type(t) == str: n=1
  elif type(t) == list: n=len(t)
  # 4
  continuation = [instrstar,idx+1]
  L = {"arity":n, "height":len(operand_stack), "continuation":continuation, "end":continuation}
  # 5
  if c:
    spec_enter_block(config,instrstar[idx][2],L)
  # 6
  else:
    spec_enter_block(config,instrstar[idx][3],L)

def spec_br(config, l = None):
  if verbose>=1: print("spec_br(",")")
  operand_stack = config["operand_stack"]
  control_stack = config["control_stack"]
  if l == None:
    l = config["instrstar"][config["idx"]][1]
  # 2
  L = control_stack[-1*(l+1)]
  # 3
  n = L["arity"]
  # 5
  valn = []
  if n>0:
    valn = operand_stack[-1*n:]
  # 6
  del operand_stack[ L["height"]: ]
  if "loop_flag" in L: # branching to loop starts at beginning of loop, so don't delete
    if l>0:
      del control_stack[-1*l:]
    config["idx"] = 0
  else:
    del control_stack[-1*(l+1):]
  # 7
  operand_stack += valn
  # 8
  config["instrstar"],config["idx"] = L["continuation"]

def spec_br_if(config):
  if verbose>=1: print("spec_br_if(",")")
  l = config["instrstar"][config["idx"]][1]
  # 2
  c = config["operand_stack"].pop()
  # 3
  if c!=0: spec_br(config,l)
  # 4
  else: config["idx"] += 1

def spec_br_table(config):
  if verbose>=1: print("spec_br_table(",")")
  lstar = config["instrstar"][config["idx"]][1]
  lN = config["instrstar"][config["idx"]][2]
  # 2
  i = config["operand_stack"].pop()
  #print(lstar,lN)
  # 3
  if i < len(lstar):
    li = lstar[i]
    spec_br(config,li)
  # 4
  else:
    spec_br(config,lN)


def spec_return(config):
  if verbose>=1: print("spec_return(",")")
  operand_stack = config["operand_stack"]
  # 1
  F = config["F"][-1]
  # 2
  n = F["arity"]
  # 4
  valn = []
  if n>0:
    valn = operand_stack[-1*n:]
    # 6
    del operand_stack[F["height"]:]
  # 8
  config["F"].pop()
  # 9
  operand_stack += valn
  config["instrstar"], config["idx"], config["control_stack"] = F["continuation"]


def spec_call(config):
  if verbose>=1: print("spec_call(",")")
  operand_stack = config["operand_stack"]
  instr = config["instrstar"][config["idx"]]
  x = instr[1]
  # 1
  F = config["F"][-1]
  # 3
  a = F["module"]["funcaddrs"][x]
  # 4
  ret = spec_invoke_function_address(config,a)
  if ret=="exhaustion": return ret

def spec_call_indirect(config):
  if verbose>=1: print("spec_call_indirect(",")")
  S = config["S"]
  # 1
  F = config["F"][-1]
  # 3
  ta = F["module"]["tableaddrs"][0]
  # 5
  tab = S["tables"][ta]
  # 7
  x = config["instrstar"][config["idx"]][1]
  ftexpect = F["module"]["types"][x]
  # 9
  i = config["operand_stack"].pop()
  # 10
  if len(tab["elem"])<=i: raise Exception("trap")
  # 11
  if tab["elem"][i] == None: raise Exception("trap")
  # 12
  a = tab["elem"][i]
  # 14
  f = S["funcs"][a]
  # 15
  ftactual = f["type"]
  # 16
  if ftexpect != ftactual: raise Exception("trap")
  # 17
  ret = spec_invoke_function_address(config,a)
  if ret=="exhaustion": return ret


# 4.4.6 BLOCKS

def spec_enter_block(config,instrstar,L):
  # 1
  config["control_stack"].append(L)
  # 2
  config["instrstar"] = instrstar
  config["idx"] = 0

# this is unused, just done in spec_expr() since need to check if label stack is empty
def spec_exit_block(config):
  # 4
  L = config["control_stack"].pop()
  # 6
  config["instrstar"],config["idx"] = L["end"]
  


  

# 4.4.7 FUNCTION CALLS

# this is called by spac_call() and spec_call_indirect()
def spec_invoke_function_address(config, a=None):
  if verbose>=1: print("spec_invoke_function_address(",a,")")
  # a is address
  S = config["S"]
  F = config["F"]
  if len(F)>1024: #TODO: this is not part of spec, but this is required to pass tests. Tests pass with limit 10000, maybe more
    return "exhaustion"
  instrstar = config["instrstar"]
  idx = config["idx"]
  operand_stack  = config["operand_stack"]
  control_stack  = config["control_stack"]
  if a==None:
    a=config["instrstar"][config["idx"]][1]
  # 2
  f = S["funcs"][a]
  # 3
  t1n,t2m = f["type"]
  if "code" in f:
    #print("a",a)
    #print("f[code]",f["code"])
    #print("f[type]",f["type"])
    # 5
    tstar = f["code"]["locals"]
    # 6
    instrstarend = f["code"]["body"]
    # 8
    valn = []
    if len(t1n)>0:
      valn = operand_stack[-1*len(t1n):]
      del operand_stack[-1*len(t1n):]
    # 9
    val0star = []
    for t in tstar:
      if t[0]=='i':
        val0star += [0]
      if t[0]=='f':
        val0star += [0.0]
    # 10 & 11
    #print("valn",valn)
    #print("val0star",val0star)
    F += [{ "module": f["module"], "locals": valn+val0star, "arity":len(t2m), "height":len(operand_stack), "continuation":[instrstar, idx+1, control_stack], }]
    # 12
    retval = [] if not t2m else t2m[0]
    blockinstrstarendend = [["block", retval,instrstarend],["end"]]
    config["instrstar"] = blockinstrstarendend
    config["idx"] = 0
    config["control_stack"] = []
    #config_new = {"S":S,"F":F,"instrstar":blockinstrstarendend,"idx":0,"operand_stack":[],"control_stack":[]}
    #ret = spec_expr(config_new)
    #if ret=="trap": return ret
    #operand_stack += config_new["operand_stack"]
    #print("operand_stack after:",operand_stack)
    #config["instrstar"], config["idx"] = F[-1]["continuation"]
    #F.pop()
  elif "hostcode" in f:
    valn = []
    if len(t1n)>0:
      valn = operand_stack[-1*len(t1n):]
      #print("operand_stack",operand_stack)
      del operand_stack[-1*len(t1n):]
    S,ret = f["hostcode"](S,valn)
    if ret=="trap": return ret
    operand_stack+=ret
    config["idx"]+=1


# this is unused for now
# this is called when end of function reached without return or trap aborting it
def spec_return_from_func(config):
  if verbose>=1: print("spec_return_from_func() !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  # 1
  F = config["F"][-1]
  # 2,3,4,7 not needed since we have separate operand stack
  # 6
  config["F"].pop()
  # 8
  config["instrstar"], config["idx"], config["control_stack"] = F["continuation"]
  #print("config stuff")
  #print(config["instrstar"])
  #print(config["idx"],config["control_stack"])
  


def spec_end(config):
  if verbose>=1: print("spec_end()")
  if len(config["control_stack"])>=1:
    #print("ending block")
    spec_exit_block(config)
  else:
    #print("F:",config["F"][-1])
    if len(config["F"])>=1 and "continuation" in config["F"][-1]: #continuation for case of init elem or data or global 
      #print("ending function")
      spec_return_from_func(config)
    else:
      #print("config[F]",config["F"])
      #print("ending done")
      return "done"
    


# 4.4.8 EXPRESSIONS

#Map each opcode to the function(s) to invoke when it is encountered. For opcodes with two functions, the second function is called by the first function.
opcode2exec = {
"unreachable":	(spec_unreachable,),
"nop":		(spec_nop,),
"block":	(spec_block,),				# blocktype in* end
"loop":		(spec_loop,),				# blocktype in* end
"if":		(spec_if,),				# blocktype in1* else? in2* end
"else":		(spec_end,),				# in2*
"end":		(spec_end,),
"br":		(spec_br,),				# labelidx
"br_if":	(spec_br_if,),				# labelidx
"br_table":	(spec_br_table,),			# labelidx* labelidx
"return":	(spec_return,),
"call":		(spec_call,),				# funcidx
"call_indirect":(spec_call_indirect,),			# typeidx 0x00

"drop":		(spec_drop,),
"select":	(spec_select,),

"get_local":	(spec_get_local,),			# localidx
"set_local":	(spec_set_local,),			# localidx
"tee_local":	(spec_tee_local,),			# localidx
"get_global":	(spec_get_global,),			# globalidx
"set_global":	(spec_set_global,),			# globalidx

"i32.load":	(spec_tload,),				# memarg
"i64.load":	(spec_tload,),				# memarg
"f32.load":	(spec_tload,),				# memarg
"f64.load":	(spec_tload,), 				# memarg
"i32.load8_s":	(spec_tload,), 				# memarg
"i32.load8_u":	(spec_tload,), 				# memarg
"i32.load16_s":	(spec_tload,),				# memarg
"i32.load16_u":	(spec_tload,),				# memarg
"i64.load8_s":	(spec_tload,),				# memarg
"i64.load8_u":	(spec_tload,), 				# memarg
"i64.load16_s":	(spec_tload,), 				# memarg
"i64.load16_u":	(spec_tload,), 				# memarg
"i64.load32_s":	(spec_tload,), 				# memarg
"i64.load32_u":	(spec_tload,), 				# memarg
"i32.store":	(spec_tstore,), 			# memarg
"i64.store":	(spec_tstore,), 			# memarg
"f32.store":	(spec_tstore,), 			# memarg
"f64.store":	(spec_tstore,), 			# memarg
"i32.store8":	(spec_tstore,), 			# memarg
"i32.store16":	(spec_tstore,), 			# memarg
"i64.store8":	(spec_tstore,), 			# memarg
"i64.store16":	(spec_tstore,), 			# memarg
"i64.store32":	(spec_tstore,),				# memarg
"memory.size":	(spec_memorysize,),
"memory.grow":	(spec_memorygrow,),

"i32.const":	(spec_tconst,),				# i32
"i64.const":	(spec_tconst,),				# i64
"f32.const":	(spec_tconst,),				# f32
"f64.const":	(spec_tconst,),				# f64

"i32.eqz":	(spec_ttestop,spec_ieqzN),
"i32.eq":	(spec_trelop,spec_ieqN),
"i32.ne":	(spec_trelop,spec_ineN),
"i32.lt_s":	(spec_trelop,spec_ilt_sN),
"i32.lt_u":	(spec_trelop,spec_ilt_uN),
"i32.gt_s":	(spec_trelop,spec_igt_sN),
"i32.gt_u":	(spec_trelop,spec_igt_uN),
"i32.le_s":	(spec_trelop,spec_ile_sN),
"i32.le_u":	(spec_trelop,spec_ile_uN),
"i32.ge_s":	(spec_trelop,spec_ige_sN),
"i32.ge_u":	(spec_trelop,spec_ige_uN),

"i64.eqz":	(spec_ttestop,spec_ieqzN),
"i64.eq":	(spec_trelop,spec_ieqN),
"i64.ne":	(spec_trelop,spec_ineN),
"i64.lt_s":	(spec_trelop,spec_ilt_sN),
"i64.lt_u":	(spec_trelop,spec_ilt_uN),
"i64.gt_s":	(spec_trelop,spec_igt_sN),
"i64.gt_u":	(spec_trelop,spec_igt_uN),
"i64.le_s":	(spec_trelop,spec_ile_sN),
"i64.le_u":	(spec_trelop,spec_ile_uN),
"i64.ge_s":	(spec_trelop,spec_ige_sN),
"i64.ge_u":	(spec_trelop,spec_ige_uN),

"f32.eq":	(spec_trelop,spec_feqN),
"f32.ne":	(spec_trelop,spec_fneN),
"f32.lt":	(spec_trelop,spec_fltN),
"f32.gt":	(spec_trelop,spec_fgtN),
"f32.le":	(spec_trelop,spec_fleN),
"f32.ge":	(spec_trelop,spec_fgeN),

"f64.eq":	(spec_trelop,spec_feqN),
"f64.ne":	(spec_trelop,spec_fneN),
"f64.lt":	(spec_trelop,spec_fltN),
"f64.gt":	(spec_trelop,spec_fgtN),
"f64.le":	(spec_trelop,spec_fleN),
"f64.ge":	(spec_trelop,spec_fgeN),

"i32.clz":	(spec_tunop,spec_iclzN),
"i32.ctz":	(spec_tunop,spec_ictzN),
"i32.popcnt":	(spec_tunop,spec_ipopcntN),
"i32.add":	(spec_tbinop,spec_iaddN),
"i32.sub":	(spec_tbinop,spec_isubN),
"i32.mul":	(spec_tbinop,spec_imulN),
"i32.div_s":	(spec_tbinop,spec_idiv_sN),
"i32.div_u":	(spec_tbinop,spec_idiv_uN),
"i32.rem_s":	(spec_tbinop,spec_irem_sN),
"i32.rem_u":	(spec_tbinop,spec_irem_uN),
"i32.and":	(spec_tbinop,spec_iandN),
"i32.or":	(spec_tbinop,spec_iorN),
"i32.xor":	(spec_tbinop,spec_ixorN),
"i32.shl":	(spec_tbinop,spec_ishlN),
"i32.shr_s":	(spec_tbinop,spec_ishr_sN),
"i32.shr_u":	(spec_tbinop,spec_ishr_uN),
"i32.rotl":	(spec_tbinop,spec_irotlN),
"i32.rotr":	(spec_tbinop,spec_irotrN),

"i64.clz":	(spec_tunop,spec_iclzN),
"i64.ctz":	(spec_tunop,spec_ictzN),
"i64.popcnt":	(spec_tunop,spec_ipopcntN),
"i64.add":	(spec_tbinop,spec_iaddN),
"i64.sub":	(spec_tbinop,spec_isubN),
"i64.mul":	(spec_tbinop,spec_imulN),
"i64.div_s":	(spec_tbinop,spec_idiv_sN),
"i64.div_u":	(spec_tbinop,spec_idiv_uN),
"i64.rem_s":	(spec_tbinop,spec_irem_sN),
"i64.rem_u":	(spec_tbinop,spec_irem_uN),
"i64.and":	(spec_tbinop,spec_iandN),
"i64.or":	(spec_tbinop,spec_iorN),
"i64.xor":	(spec_tbinop,spec_ixorN),
"i64.shl":	(spec_tbinop,spec_ishlN),
"i64.shr_s":	(spec_tbinop,spec_ishr_sN),
"i64.shr_u":	(spec_tbinop,spec_ishr_uN),
"i64.rotl":	(spec_tbinop,spec_irotlN),
"i64.rotr":	(spec_tbinop,spec_irotrN),

"f32.abs":	(spec_tunop,spec_fabsN),
"f32.neg":	(spec_tunop,spec_fnegN),
"f32.ceil":	(spec_tunop,spec_fceilN),
"f32.floor":	(spec_tunop,spec_ffloorN),
"f32.trunc":	(spec_tunop,spec_ftruncN),
"f32.nearest":	(spec_tunop,spec_fnearestN),
"f32.sqrt":	(spec_tunop,spec_fsqrtN),
"f32.add":	(spec_tbinop,spec_faddN),
"f32.sub":	(spec_tbinop,spec_fsubN),
"f32.mul":	(spec_tbinop,spec_fmulN),
"f32.div":	(spec_tbinop,spec_fdivN),
"f32.min":	(spec_tbinop,spec_fminN),
"f32.max":	(spec_tbinop,spec_fmaxN),
"f32.copysign":	(spec_tbinop,spec_fcopysignN),

"f64.abs":	(spec_tunop,spec_fabsN),
"f64.neg":	(spec_tunop,spec_fnegN),
"f64.ceil":	(spec_tunop,spec_fceilN),
"f64.floor":	(spec_tunop,spec_ffloorN),
"f64.trunc":	(spec_tunop,spec_ftruncN),
"f64.nearest":	(spec_tunop,spec_fnearestN),
"f64.sqrt":	(spec_tunop,spec_fsqrtN),
"f64.add":	(spec_tbinop,spec_faddN),
"f64.sub":	(spec_tbinop,spec_fsubN),
"f64.mul":	(spec_tbinop,spec_fmulN),
"f64.div":	(spec_tbinop,spec_fdivN),
"f64.min":	(spec_tbinop,spec_fminN),
"f64.max":	(spec_tbinop,spec_fmaxN),
"f64.copysign":	(spec_tbinop,spec_fcopysignN),

"i32.wrap/i64":		(spec_t2cvtopt1,spec_wrapMN),
"i32.trunc_s/f32":	(spec_t2cvtopt1,spec_trunc_sMN),
"i32.trunc_u/f32":	(spec_t2cvtopt1,spec_trunc_uMN),
"i32.trunc_s/f64":	(spec_t2cvtopt1,spec_trunc_sMN),
"i32.trunc_u/f64":	(spec_t2cvtopt1,spec_trunc_uMN),
"i64.extend_s/i32":	(spec_t2cvtopt1,spec_extend_sMN),
"i64.extend_u/i32":	(spec_t2cvtopt1,spec_extend_uMN),
"i64.trunc_s/f32":	(spec_t2cvtopt1,spec_trunc_sMN),
"i64.trunc_u/f32":	(spec_t2cvtopt1,spec_trunc_uMN),
"i64.trunc_s/f64":	(spec_t2cvtopt1,spec_trunc_sMN),
"i64.trunc_u/f64":	(spec_t2cvtopt1,spec_trunc_uMN),
"f32.convert_s/i32":	(spec_t2cvtopt1,spec_convert_sMN),
"f32.convert_u/i32":	(spec_t2cvtopt1,spec_convert_uMN),
"f32.convert_s/i64":	(spec_t2cvtopt1,spec_convert_sMN),
"f32.convert_u/i64":	(spec_t2cvtopt1,spec_convert_uMN),
"f32.demote/f64":	(spec_t2cvtopt1,spec_demoteMN),
"f64.convert_s/i32":	(spec_t2cvtopt1,spec_convert_sMN),
"f64.convert_u/i32":	(spec_t2cvtopt1,spec_convert_uMN),
"f64.convert_s/i64":	(spec_t2cvtopt1,spec_convert_sMN),
"f64.convert_u/i64":	(spec_t2cvtopt1,spec_convert_uMN),
"f64.promote/f32":	(spec_t2cvtopt1,spec_promoteMN),
"i32.reinterpret/f32":	(spec_t2cvtopt1,spec_reinterprett1t2),
"i64.reinterpret/f64":	(spec_t2cvtopt1,spec_reinterprett1t2),
"f32.reinterpret/i32":	(spec_t2cvtopt1,spec_reinterprett1t2),
"f64.reinterpret/i64":	(spec_t2cvtopt1,spec_reinterprett1t2),

"invoke":		(spec_invoke_function_address,)
}







# this is the main loop over instr* end
# this is not in the spec
def instrstarend_loop(config):
  if verbose>=1: print("instrstar_loop()")
  while 1:
    instr = config["instrstar"][config["idx"]][0]  # idx<len(instrs) since instrstar[-1]=="end" which changes instrstar
    #print()
    #print(" ",instr)
    #immediate = None if len(config["instrstar"][config["idx"]])==1 else config["instrstar"][config["idx"]][1]
    ret = opcode2exec[instr][0](config)
    #print("  len(F)",len(config["F"]))
    #print("  config[control_stack]",config["control_stack"])
    #print("  config[operand_stack]",config["operand_stack"])
    #print("  config[instrstar]",config["instrstar"])
    #print("  config[idx]",config["idx"])
    if ret: return ret,config["operand_stack"]	#eg "trap" or "done"




# this executes instr* end. This deviates from the spec.
def spec_expr(config):
  if verbose>=1: print("spec_expr(",")")
  #S = config["S"]
  #F = config["F"]
  #operand_stack = config["operand_stack"]
  #control_stack = config["control_stack"]
  #iterate over list of instructions and nested lists of instructions
  #idx = config["idx"]
  #if len(config["instrstar"])==0: return operand_stack
  #print(instrstar)
  config["idx"]=0
  while 1:
    instr = config["instrstar"][config["idx"]][0]  # idx<len(instrs) since instrstar[-1]=="end" which changes instrstar
    #print(instr)
    #immediate = None if len(config["instrstar"][config["idx"]])==1 else config["instrstar"][config["idx"]][1]
    ret = opcode2exec[instr][0](config)
    if ret == "trap": raise Exception("trap")
    if ret == "exhaustion": raise Exception("exhaustion") 
    if ret: return config["operand_stack"]
    #print("locals",F[-1]["locals"])
    if verbose >= 2: print("operand_stack",config["operand_stack"])
    #print("control_stack",len(config["control_stack"]),config["control_stack"])
    #print()
    if verbose >= 4: print("control_stack",config["control_stack"])
  #return "done",config["operand_stack"]





#############
# 4.5 MODULES
#############

# 4.5.1 EXTERNAL TYPING

def spec_external_typing(S,externval):
  if verbose>=1: print("spec_external_typing(",externval,")")
  if "func" == externval[0]:
    a = externval[1]
    if len(S["funcs"])<a: raise Exception("unlinkable")
    funcinst = S["funcs"][a]
    return ["func",funcinst["type"]]
  elif "table" == externval[0]:
    a = externval[1]
    if len(S["tables"])<a: raise Exception("unlinkable")
    tableinst = S["tables"][a]
    return ["table",[{"min":len(tableinst["elem"]),"max":tableinst["max"]},"anyfunc"]]
  elif "mem" == externval[0]:
    a = externval[1]
    if len(S["mems"])<a: raise Exception("unlinkable")
    meminst = S["mems"][a]
    return ["mem",{"min":len(meminst["data"])//65536,"max":meminst["max"]}]  #page size = 64 Ki = 65536
  elif "global" == externval[0]:
    a = externval[1]
    if len(S["globals"])<a: raise Exception("unlinkable")
    globalinst = S["globals"][a]
    return [ "global", [globalinst["mut"],globalinst["value"][0][:3]] ]
  else:
    raise Exception("unlinkable")


# 4.5.2 IMPORT MATCHING

def spec_externtype_matching_limits(limits1,limits2):
  if verbose>=1: print("spec_externtype_matching_limits(",limits1,limits2,")")
  n1 = limits1["min"]
  m1 = limits1["max"]
  n2 = limits2["min"]
  m2 = limits2["max"]
  if n1<n2: raise Exception("unlinkable")
  if m2==None or (m1!=None and m2!=None and m1<=m2): return "<="
  else: raise Exception("unlinkable")

def spec_externtype_matching(externtype1,externtype2):
  if verbose>=1: print("spec_externtype_matching(",externtype1,externtype2,")")
  if "func"==externtype1[0] and "func"==externtype2[0]:
    if externtype1[1] == externtype2[1]:
      return "<="
  elif "table"==externtype1[0] and "table"==externtype2[0]:
    limits1 = externtype1[1][0]
    limits2 = externtype2[1][0]
    spec_externtype_matching_limits(limits1,limits2)
    elemtype1 = externtype1[1][1]
    elemtype2 = externtype2[1][1]
    if elemtype1 == elemtype2:
      return "<="
  elif "mem"==externtype1[0] and "mem"==externtype2[0]:
    limits1 = externtype1[1]
    limits2 = externtype2[1]
    if spec_externtype_matching_limits(limits1,limits2) == "<=":
      return "<="
  elif "global"==externtype1[0] and "global"==externtype2[0]:
    if externtype1[1] == externtype2[1]:
      return "<="
  raise Exception("unlinkable")


# 4.5.3 ALLOCATION

def spec_allocfunc(S,func,moduleinst):
  if verbose>=1: print("spec_allocfunc(",")")
  funcaddr = len(S["funcs"])
  functype = moduleinst["types"][func["type"]]
  funcinst = {"type":functype, "module":moduleinst, "code":func}
  S["funcs"].append(funcinst)
  return S,funcaddr

def spec_allochostfunc(S,functype,hostfunc):
  if verbose>=1: print("spec_allochostfunc(",")")
  funcaddr = len(S["funcs"])
  funcinst = {"type":functype, "hostcode":hostfunc}
  S["funcs"].append(funcinst)
  return S,funcaddr

def spec_alloctable(S,tabletype):
  if verbose>=1: print("spec_alloctable(",")")
  min_ = tabletype[0]["min"]
  max_ = tabletype[0]["max"]
  tableaddr = len(S["tables"])  
  tableinst = {"elem":[None for i in range(min_)], "max":max_}
  S["tables"].append(tableinst)
  return S,tableaddr

def spec_allocmem(S,memtype):
  if verbose>=1: print("spec_allocmem(",")")
  min_ = memtype["min"]
  max_ = memtype["max"]
  memaddr = len(S["mems"])
  meminst = {"data":bytearray(min_*65536), "max":max_}  #page size = 64 Ki = 65536
  S["mems"].append(meminst)
  return S,memaddr

def spec_allocglobal(S,globaltype,val):
  if verbose>=1: print("spec_allocglobal(",")")
  #print("spec_allocglobal(",")")
  #print(globaltype)
  mut = globaltype[0]
  valtype = globaltype[1]
  globaladdr = len(S["globals"])
  globalinst = {"value":[valtype+".const",val], "mut":mut}
  S["globals"].append(globalinst)
  return S,globaladdr
  
def spec_growtable(tableinst,n):
  if verbose>=1: print("spec_growtable(",")")
  len_ = n + len(tableinst["elem"])
  if len_>2**32: return "fail"
  if tablinst["max"]!=None and tableinst["max"] < len_: return "fail" #TODO: what does fail mean? raise Exception("trap")
  tableinst["elem"]+=[None for i in range(n)]
  return tableinst

def spec_growmem(meminst,n):
  if verbose>=1: print("spec_growmem(",")")
  #print("ok",len(meminst["data"]))
  assert len(meminst["data"])%65536 == 0        #ie divisible by page size = 64 Ki = 65536
  len_ = n + len(meminst["data"])//65536
  if len_>2**16: return "fail"
  if (meminst["max"]!=None and meminst["max"] < len_): return "fail"; #TODO: what does fail mean? raise Exception("trap")
  #if len_+len(meminst["data"]) > 2**32: return "fail" # raise Exception("grow mem") #TODO: this is not part of the spec, maybe should be
  #else:
  meminst["data"] += bytearray(n*65536) # each page created with bytearray(65536) which is 0s

  

def spec_allocmodule(S,module,externvalimstar,valstar):  
  if verbose>=1: print("spec_allocmodule(",")")
  moduleinst = {
     "types": module["types"],
     "funcaddrs": None,
     "tableaddrs": None,
     "memaddrs": None,
     "globaladdrs": None,
     "exports": None
    }
  funcaddrstar = [spec_allocfunc(S,func,moduleinst)[1] for func in module["funcs"]]
  tableaddrstar = [spec_alloctable(S,table["type"])[1] for table in module["tables"]]
  memaddrstar = [spec_allocmem(S,mem["type"])[1] for mem in module["mems"]]
  globaladdrstar = [spec_allocglobal(S,global_["type"],valstar[idx])[1] for idx,global_ in enumerate(module["globals"])]
  funcaddrmodstar = spec_funcs(externvalimstar) + funcaddrstar
  tableaddrmodstar = spec_tables(externvalimstar) + tableaddrstar
  memaddrmodstar = spec_mems(externvalimstar) + memaddrstar
  globaladdrmodstar = spec_globals(externvalimstar) + globaladdrstar
  exportinststar = []
  for exporti in module["exports"]:
    if exporti["desc"][0] == "func":
      x = exporti["desc"][1]
      externvali = ["func", funcaddrmodstar[x]]
    elif exporti["desc"][0] == "table":
      x = exporti["desc"][1]
      externvali = ["table", tableaddrmodstar[x]]
    elif exporti["desc"][0] == "mem":
      x = exporti["desc"][1]
      externvali = ["mem", memaddrmodstar[x]]
    elif exporti["desc"][0] == "global":
      x = exporti["desc"][1]
      externvali = ["global", globaladdrmodstar[x]]
    exportinststar += [{"name": exporti["name"], "value": externvali}]
  moduleinst["funcaddrs"] = funcaddrmodstar
  moduleinst["tableaddrs"] = tableaddrmodstar
  moduleinst["memaddrs"] = memaddrmodstar
  moduleinst["globaladdrs"] = globaladdrmodstar
  moduleinst["exports"] = exportinststar
  return S,moduleinst 


def spec_instantiate(S,module,externvaln):
  if verbose>=1: print("spec_instantiate(",")")
  # 1
  # 2
  ret = spec_validate_module(module)
  externtypeimn,externtypeexstar = ret
  # 3
  if len(module["imports"]) != len(externvaln): raise Exception("unlinkable")
  # 4
  for i in range(len(externvaln)):
    externtypei = spec_external_typing(S,externvaln[i])
    spec_externtype_matching(externtypei,externtypeimn[i])
  # 5
  valstar = []
  moduleinstim = {"globaladdrs":[externval[1] for externval in externvaln if "global"==externval[0]]}
  Fim = {"module":moduleinstim, "locals":[], "arity":1, "height":0}
  framestack = []
  framestack += [Fim]
  for globali in module["globals"]:
    config = {"S":S,"F":framestack,"instrstar":globali["init"],"idx":0,"operand_stack":[],"control_stack":[]}
    ret = spec_expr( config )[0]
    valstar += [ ret ]
  framestack.pop()
  # 6
  S,moduleinst = spec_allocmodule(S,module,externvaln,valstar)
  # 7
  F={"module":moduleinst, "locals":[]}
  # 8
  framestack += [F]
  # 9
  tableinst = []
  eo = []
  for elemi in module["elem"]:
    config = {"S":S,"F":framestack,"instrstar":elemi["offset"],"idx":0,"operand_stack":[],"control_stack":[]}
    eovali = spec_expr(config)[0]
    eoi = eovali
    eo+=[eoi]
    tableidxi = elemi["table"]
    tableaddri = moduleinst["tableaddrs"][tableidxi]
    tableinsti = S["tables"][tableaddri]
    tableinst+=[tableinsti]
    #print("eoi",eoi)
    eendi = eoi+len(elemi["init"])
    if eendi > len(tableinsti["elem"]): raise Exception("unlinkable")
  # 10
  meminst = []
  do = []
  for datai in module["data"]:
    config = {"S":S,"F":framestack,"instrstar":datai["offset"],"idx":0,"operand_stack":[],"control_stack":[]}
    dovali = spec_expr(config)[0]
    doi = dovali
    do+=[doi]
    memidxi = datai["data"]
    memaddri = moduleinst["memaddrs"][memidxi]
    meminsti = S["mems"][memaddri]
    meminst += [meminsti]
    dendi = doi+len(datai["init"])
    if dendi > len(meminsti["data"]): raise Exception("unlinkable")
  # 11
  # 12
  framestack.pop()
  # 13
  for i,elemi in enumerate(module["elem"]):
    for j,funcidxij in enumerate(elemi["init"]):
      funcaddrij = moduleinst["funcaddrs"][funcidxij]
      tableinst[i]["elem"][eo[i]+j] = funcaddrij
  # 14
  for i,datai in enumerate(module["data"]):
    for j,bij in enumerate(datai["init"]):
      meminst[i]["data"][do[i]+j] = bij
  # 15
  ret = None
  if module["start"]:
    funcaddr = moduleinst["funcaddrs"][ module["start"]["func"] ]
    ret = spec_invoke(S,funcaddr,[])
  return S,F,ret


    
# 4.5.5 INVOCATION

# valn looks like [["i32.const",3],["i32.const",199], ...]
def spec_invoke(S,funcaddr,valn):
  if verbose>=1: print("spec_invoke(",")")
  # 1
  if len(S["funcs"]) < funcaddr or funcaddr < 0: raise Exception("bad address")
  # 2
  funcinst = S["funcs"][funcaddr]  
  # 5
  t1n,t2m = funcinst["type"]
  # 4
  if len(valn)!=len(t1n): raise Exception("wrong number of arguments")
  # 5
  for ti,vali in zip(t1n,valn):
    if vali[0][:3]!=ti: raise Exception("argument type mismatch")
  # 6
  operand_stack = []
  for ti,vali in zip(t1n,valn):
    arg=vali[1]
    if type(arg)==str:
      if ti[0]=="i": arg = int(arg)
      if ti[0]=="f": arg = float(arg)
    operand_stack += [arg]
  # 7
  valresm=None
  if "code" in funcinst:
    #config = {"S":S,"F":[],"instrstar":funcinst["code"]["body"],"idx":0,"operand_stack":operand_stack,"control_stack":[]}  #TODO: toggle these back when uncomment main loop execution
    #valresm = spec_invoke_function_address(config,funcaddr)  #TODO: toggle these back when uncomment main loop execution 
    config = {"S":S,"F":[],"instrstar":[["invoke",funcaddr],["end",None]],"idx":0,"operand_stack":operand_stack,"control_stack":[]}
    valresm = spec_expr(config) #instrstarend_loop(config)
    #moved this here from bottom
    return valresm
  elif "hostcode" in funcinst:
    S,valresm = funcinst["hostcode"](S,operand_stack)
    #moved this here from bottom
    return valresm
  else: raise Exception("")
  #return valresm  #TODO: toggle these back when uncomment main loop execution






###################
###################
# 5 BINARY FORMAT #
###################
###################

#Chapter 5 defines a binary syntax over the abstract syntax. The implementation is a recursive-descent parser which takes a `.wasm` file and builds an abstract syntax tree out of nested Python lists and dicts. Also implemented are inverses (up to a canonical form) which write an abstract syntax tree back to a `.wasm` file.

# key-value pairs of binary opcodes and their text reperesentation
opcodes_binary2text = {
0x00:'unreachable',
0x01:'nop',
0x02:'block',			# blocktype in* end		# begin block
0x03:'loop',			# blocktype in* end		# begin block
0x04:'if',			# blocktype in1* else? end	# begin block
0x05:'else',			# in2*				# end block & begin block
0x0b:'end',							# end block
0x0c:'br',			# labelidx			# branch
0x0d:'br_if',			# labelidx			# branch
0x0e:'br_table',		# labelidx* labelidx		# branch
0x0f:'return',							# end outermost block
0x10:'call',			# funcidx			# branch
0x11:'call_indirect',		# typeidx 0x00			# branch

0x1a:'drop',
0x1b:'select',

0x20:'get_local',		# localidx
0x21:'set_local',		# localidx
0x22:'tee_local',		# localidx
0x23:'get_global',		# globalidx
0x24:'set_global',		# globalidx

0x28:'i32.load',		# memarg
0x29:'i64.load',		# memarg
0x2a:'f32.load',		# memarg
0x2b:'f64.load',		# memarg
0x2c:'i32.load8_s',		# memarg
0x2d:'i32.load8_u',		# memarg
0x2e:'i32.load16_s',		# memarg
0x2f:'i32.load16_u',		# memarg
0x30:'i64.load8_s',		# memarg
0x31:'i64.load8_u',		# memarg
0x32:'i64.load16_s',		# memarg
0x33:'i64.load16_u',		# memarg
0x34:'i64.load32_s',		# memarg
0x35:'i64.load32_u',		# memarg
0x36:'i32.store',		# memarg
0x37:'i64.store',		# memarg
0x38:'f32.store',		# memarg
0x39:'f64.store',		# memarg
0x3a:'i32.store8',		# memarg
0x3b:'i32.store16',		# memarg
0x3c:'i64.store8',		# memarg
0x3d:'i64.store16',		# memarg
0x3e:'i64.store32',		# memarg
0x3f:'memory.size',
0x40:'memory.grow',

0x41:'i32.const',		# i32
0x42:'i64.const',		# i64
0x43:'f32.const',		# f32
0x44:'f64.const',		# f64

0x45:'i32.eqz',
0x46:'i32.eq',
0x47:'i32.ne',
0x48:'i32.lt_s',
0x49:'i32.lt_u',
0x4a:'i32.gt_s',
0x4b:'i32.gt_u',
0x4c:'i32.le_s',
0x4d:'i32.le_u',
0x4e:'i32.ge_s',
0x4f:'i32.ge_u',

0x50:'i64.eqz',
0x51:'i64.eq',
0x52:'i64.ne',
0x53:'i64.lt_s',
0x54:'i64.lt_u',
0x55:'i64.gt_s',
0x56:'i64.gt_u',
0x57:'i64.le_s',
0x58:'i64.le_u',
0x59:'i64.ge_s',
0x5a:'i64.ge_u',

0x5b:'f32.eq',
0x5c:'f32.ne',
0x5d:'f32.lt',
0x5e:'f32.gt',
0x5f:'f32.le',
0x60:'f32.ge',

0x61:'f64.eq',
0x62:'f64.ne',
0x63:'f64.lt',
0x64:'f64.gt',
0x65:'f64.le',
0x66:'f64.ge',

0x67:'i32.clz',
0x68:'i32.ctz',
0x69:'i32.popcnt',
0x6a:'i32.add',
0x6b:'i32.sub',
0x6c:'i32.mul',
0x6d:'i32.div_s',
0x6e:'i32.div_u',
0x6f:'i32.rem_s',
0x70:'i32.rem_u',
0x71:'i32.and',
0x72:'i32.or',
0x73:'i32.xor',
0x74:'i32.shl',
0x75:'i32.shr_s',
0x76:'i32.shr_u',
0x77:'i32.rotl',
0x78:'i32.rotr',

0x79:'i64.clz',
0x7a:'i64.ctz',
0x7b:'i64.popcnt',
0x7c:'i64.add',
0x7d:'i64.sub',
0x7e:'i64.mul',
0x7f:'i64.div_s',
0x80:'i64.div_u',
0x81:'i64.rem_s',
0x82:'i64.rem_u',
0x83:'i64.and',
0x84:'i64.or',
0x85:'i64.xor',
0x86:'i64.shl',
0x87:'i64.shr_s',
0x88:'i64.shr_u',
0x89:'i64.rotl',
0x8a:'i64.rotr',

0x8b:'f32.abs',
0x8c:'f32.neg',
0x8d:'f32.ceil',
0x8e:'f32.floor',
0x8f:'f32.trunc',
0x90:'f32.nearest',
0x91:'f32.sqrt',
0x92:'f32.add',
0x93:'f32.sub',
0x94:'f32.mul',
0x95:'f32.div',
0x96:'f32.min',
0x97:'f32.max',
0x98:'f32.copysign',

0x99:'f64.abs',
0x9a:'f64.neg',
0x9b:'f64.ceil',
0x9c:'f64.floor',
0x9d:'f64.trunc',
0x9e:'f64.nearest',
0x9f:'f64.sqrt',
0xa0:'f64.add',
0xa1:'f64.sub',
0xa2:'f64.mul',
0xa3:'f64.div',
0xa4:'f64.min',
0xa5:'f64.max',
0xa6:'f64.copysign',

0xa7:'i32.wrap/i64',
0xa8:'i32.trunc_s/f32',
0xa9:'i32.trunc_u/f32',
0xaa:'i32.trunc_s/f64',
0xab:'i32.trunc_u/f64',
0xac:'i64.extend_s/i32',
0xad:'i64.extend_u/i32',
0xae:'i64.trunc_s/f32',
0xaf:'i64.trunc_u/f32',
0xb0:'i64.trunc_s/f64',
0xb1:'i64.trunc_u/f64',
0xb2:'f32.convert_s/i32',
0xb3:'f32.convert_u/i32',
0xb4:'f32.convert_s/i64',
0xb5:'f32.convert_u/i64',
0xb6:'f32.demote/f64',
0xb7:'f64.convert_s/i32',
0xb8:'f64.convert_u/i32',
0xb9:'f64.convert_s/i64',
0xba:'f64.convert_u/i64',
0xbb:'f64.promote/f32',
0xbc:'i32.reinterpret/f32',
0xbd:'i64.reinterpret/f64',
0xbe:'f32.reinterpret/i32',
0xbf:'f64.reinterpret/i64'
}

# key-value pairs of text opcodes and their binary reperesentation
opcodes_text2binary = {}
for opcode in opcodes_binary2text:
  opcodes_text2binary[opcodes_binary2text[opcode]]=opcode


# 5.1.3 VECTORS

def spec_binary_vec(raw,idx,B):
  #print("spec_binary_vec(",idx,")")
  idx,n=spec_binary_uN(raw,idx,32)
  xn = []
  for i in range(n):
    idx,x = B(raw,idx)
    xn+=[x]
  return idx,xn

def spec_binary_vec_inv(mynode,myfunc):
  n_bytes=spec_binary_uN_inv(len(mynode),32) 
  xn_bytes=bytearray()
  for x in mynode:
    xn_bytes+=myfunc(x)
  return n_bytes+xn_bytes 


############
# 5.2 VALUES
############

# 5.2.1 BYTES

def spec_binary_byte(raw,idx):
  if len(raw)<=idx: raise Exception("malformed")
  return idx+1,raw[idx]

def spec_binary_byte_inv(node):
  return bytearray([node])

# 5.2.2 INTEGERS

#unsigned
def spec_binary_uN(raw,idx,N):
  #print("spec_binary_uN(",idx,N,")")
  idx,n=spec_binary_byte(raw,idx)
  if n<2**7 and n<2**N:
    return idx,n
  elif n>=2**7 and N>7:
    idx,m=spec_binary_uN(raw,idx,N-7)
    return idx, (2**7)*m+(n-2**7)
  else:
    raise Exception("malformed")

def spec_binary_uN_inv(k,N):
  #print("spec_binary_uN_inv(",k,N,")")
  if k<2**7 and k<2**N:
    return bytearray([k])
  elif k>=2**7 and N>7:
    return bytearray([k%(2**7)+2**7])+spec_binary_uN_inv(k//(2**7),N-7)
  else:
    raise Exception("malformed")

#signed
def spec_binary_sN(raw,idx,N):
  n=int(raw[idx])
  idx+=1
  if n<2**6 and n<2**(N-1):
    return idx,n
  elif 2**6<=n<2**7 and n>=2**7-2**(N-1):
    return idx,n-2**7
  elif n>=2**7 and N>7:
    idx,m=spec_binary_sN(raw,idx,N-7)
    return idx,2**7*m+(n-2**7)
  else:
    raise Exception("malformed")

def spec_binary_sN_inv(k,N):
  if 0<=k<2**6 and k<2**N:
    return bytearray([k])
  elif 2**6<=k+2**7<2**7: # and k+2**7>=2**7-2**(N-1):
    return bytearray([k+2**7])
  elif (k>=2**6 or k<2**6) and N>7: #(k<0 and k+2**7>=2**6)) and N>7:
    return bytearray([k%(2**7)+2**7])+spec_binary_sN_inv((k//(2**7)),N-7)
  else:
    raise Exception("malformed")

#uninterpretted integers
def spec_binary_iN(raw,idx,N):
  idx,n=spec_binary_sN(raw,idx,N)
  i = spec_signediN_inv(N,n)
  return idx, i

def spec_binary_iN_inv(i,N):
  return spec_binary_sN_inv(spec_signediN(N,i),N)



# 5.2.3 FLOATING-POINT

#fN::= b*:byte^{N/8} => bytes_{fN}^{-1}(b*)
def spec_binary_fN(raw,idx,N):
  bstar = bytearray([])
  for i in range(N//8):
    bstar+= bytearray([raw[idx]])
    idx+=1
  return idx, spec_bytest_inv("f"+str(N),bstar) #bytearray(bstar)

def spec_binary_fN_inv(node,N):
  return spec_bytest("f"+str(N),node)

  

# 5.2.4 NAMES

#name as UTF-8 codepoints
def spec_binary_name(raw,idx):
  #print("spec_binary_name()")
  idx,bstar = spec_binary_vec(raw,idx,spec_binary_byte)
  #print("bstar",bstar)
  nametxt=""
  try:
    nametxt=bytearray(bstar).decode()
  except:
    raise Exception("malformed")
  return idx,nametxt
  #rest is unused, for finding inverse of utf8(name)=b*, keep since want to correct spec doc
  bstaridx=0
  lenbstar = len(bstar)
  name=[]
  while bstaridx<lenbstar:
    if bstaridx>=len(bstar): raise Exception("malformed")
    b1=bstar[bstaridx]
    bstaridx+=1
    if b1<0x80:
      name+=[b1]
      continue
    if bstaridx>=len(bstar): raise Exception("malformed")
    b2=bstar[bstaridx]
    if b2>>6 != 0b01: raise Exception("malformed")
    bstaridx+=1
    c=(2**6)*(b1-0xc0) + (b2-0x80)
    #c_check = 2**6*(b1-192) + (b2-128)
    if 0x80<=c<0x800:
      name+=[c]
      continue
    if bstaridx>=len(bstar): raise Exception("malformed")
    b3=bstar[bstaridx]
    if b2>>5 != 0b011: raise Exception("malformed")
    bstaridx+=1
    c=(2**12)*(b1-0xe0) + (2**6)*(b2-0x80) + (b3-0x80)
    if 0x800<=c<0x10000 and (b2>>6 == 0b01):
      name+=[c]
      continue
    if bstaridx>=len(bstar):raise Exception("malformed")
    b4=bstar[bstaridx]
    if b2>>4 != 0b0111: raise Exception("malformed")
    bstaridx+=1
    c=2**18*(b1-0xf0) + 2**12*(b2-0x80) + 2**6*(b3-0x80) + (b4-0x80)
    if 0x10000<=c<0x110000:
      name+=[c]
    else:
      #print("malformed character")
      raise Exception("malformed")
  #convert each codepoint to utf8 character
  #print("utf8 name",name, len(name), name=="")
  nametxt = ""
  for c in name:
    #print(str(chr(c)))
    #print(c)
    nametxt+=chr(c)
  #print("utf8 nametext",nametxt, len(nametxt), nametxt=="")
  return idx,nametxt

def spec_binary_name_inv(chars):
  name_bytes=bytearray()
  for c in chars:
    c = ord(c)
    if c<0x80:
      name_bytes += bytes([c])
    elif 0x80<=c<0x800:
      name_bytes += bytes([(c>>6)+0xc0,(c&0b111111)+0x80])
    elif 0x800<=c<0x10000:
      name_bytes += bytes([(c>>12)+0xe0,((c>>6)&0b111111)+0x80,(c&0b111111)+0x80])
    elif 0x10000<=c<0x110000:
      name_bytes += bytes([(c>>18)+0xf0,((c>>12)&0b111111)+0x80,((c>>6)&0b111111)+0x80,(c&0b111111)+0x80])
    else:
      return None #error
  return bytearray([len(name_bytes)])+name_bytes


###########
# 5.3 TYPES
###########

# 5.3.1 VALUE TYPES

valtype2bin={"i32":0x7f,"i64":0x7e,"f32":0x7d,"f64":0x7c}
bin2valtype={val:key for key,val in valtype2bin.items()}

def spec_binary_valtype(raw,idx):
  if idx>=len(raw): raise Exception("malformed")
  if raw[idx] in bin2valtype:
    return idx+1,bin2valtype[raw[idx]]
  else:
    raise Exception("malformed")

def spec_binary_valtype_inv(node):
  #print("spec_binary_valtype_inv(",node,")")
  if node in valtype2bin:
    return bytearray([valtype2bin[node]])
  else:
    return bytearray([]) #error

# 5.3.2 RESULT TYPES

def spec_binary_blocktype(raw,idx):
  if raw[idx]==0x40:
    return idx+1,[]
  idx,t=spec_binary_valtype(raw,idx)
  return idx, t

def spec_binary_blocktype_inv(node):
  #print("spec_binary_blocktype_inv(",node,")")
  if node==[]:
    return bytearray([0x40])
  else:
    return spec_binary_valtype_inv(node)


# 5.3.3 FUNCTION TYPES

def spec_binary_functype(raw,idx):
  if raw[idx]!=0x60: raise Exception("malformed")
  idx+=1
  idx,t1star=spec_binary_vec(raw,idx,spec_binary_valtype)
  idx,t2star=spec_binary_vec(raw,idx,spec_binary_valtype)
  return idx,[t1star,t2star]

def spec_binary_functype_inv(node):
  return bytearray([0x60])+spec_binary_vec_inv(node[0],spec_binary_valtype_inv)+spec_binary_vec_inv(node[1],spec_binary_valtype_inv)


# 5.3.4 LIMITS

def spec_binary_limits(raw,idx):
  if raw[idx]==0x00:
    idx,n = spec_binary_uN(raw,idx+1,32)
    return idx,{"min":n,"max":None}
  elif raw[idx]==0x01:
    idx,n = spec_binary_uN(raw,idx+1,32)
    idx,m = spec_binary_uN(raw,idx,32)
    return idx,{"min":n,"max":m}
  else:
    return idx,None #error
    
def spec_binary_limits_inv(node):
  if node["max"]==None:
    return bytearray([0x00])+spec_binary_uN_inv(node["min"],32)
  else:
    return bytearray([0x01])+spec_binary_uN_inv(node["min"],32)+spec_binary_uN_inv(node["max"],32)

  
# 5.3.5 MEMORY TYPES

def spec_binary_memtype(raw,idx):
  return spec_binary_limits(raw,idx)

def spec_binary_memtype_inv(node):
  return spec_binary_limits_inv(node)


# 5.3.6 TABLE TYPES

def spec_binary_tabletype(raw,idx):
  idx,et = spec_binary_elemtype(raw,idx)
  idx,lim = spec_binary_limits(raw,idx)
  return idx,[lim,et]

def spec_binary_elemtype(raw,idx):
  if raw[idx]==0x70:
    return idx+1,"anyfunc"
  else:
    raise Exception("malformed")

def spec_binary_tabletype_inv(node):
  return spec_binary_elemtype_inv(node[1])+spec_binary_limits_inv(node[0])

def spec_binary_elemtype_inv(node):
  return bytearray([0x70])


# 5.3.7 GLOBAL TYPES

def spec_binary_globaltype(raw,idx):
  idx,t = spec_binary_valtype(raw,idx)
  idx,m = spec_binary_mut(raw,idx)
  return idx,[m,t]

def spec_binary_mut(raw,idx):
  if raw[idx]==0x00:
    return idx+1,"const"
  elif raw[idx]==0x01:
    return idx+1,"var"
  else:
    raise Exception("malformed")

def spec_binary_globaltype_inv(node):
  return spec_binary_valtype_inv(node[1])+spec_binary_mut_inv(node[0])

def spec_binary_mut_inv(node):
  if node=="const":
    return bytearray([0x00])
  elif node=="var":
    return bytearray([0x01])
  else:
    return bytearray([])


##################
# 5.4 INSTRUCTIONS
##################

# 5.4.1-5 VARIOUS INSTRUCTIONS

def spec_binary_memarg(raw,idx):
  idx,a=spec_binary_uN(raw,idx,32)
  idx,o=spec_binary_uN(raw,idx,32)
  return idx,{"align":a,"offset":o}

def spec_binary_memarg_inv(node):
  return spec_binary_uN_inv(node["align"],32) + spec_binary_uN_inv(node["offset"],32)

def spec_binary_instr(raw,idx):
  if raw[idx] not in opcodes_binary2text:
    return idx, None #error
  instr_binary = raw[idx]
  instr_text = opcodes_binary2text[instr_binary]
  idx+=1
  if instr_text in {"block","loop","if"}:      #block, loop, if
    idx,rt=spec_binary_blocktype(raw,idx)
    instar=[]
    if instr_text=="if":
      instar2=[]
      while raw[idx] not in {0x05,0x0b}:
        idx,ins=spec_binary_instr(raw,idx)
        instar+=[ins]
      if raw[idx]==0x05: #if with else
        idx+=1
        while raw[idx] != 0x0b:
          idx,ins=spec_binary_instr(raw,idx)
          instar2+=[ins]
        #return idx+1, ["if",rt,instar+[["else"]],instar2+[["end"]]] #+[["end"]]
      return idx+1, ["if",rt,instar+[["else"]],instar2+[["end"]]] #+[["end"]]
      #return idx+1, ["if",rt,instar+[["end"]]] #+[["end"]]
    else: 
      while raw[idx]!=0x0b:
        idx,ins=spec_binary_instr(raw,idx)
        instar+=[ins]
      return idx+1, [instr_text,rt,instar+[["end"]]] #+[["end"]]
  elif instr_text in {"br","br_if"}:           # br, br_if
    idx,l = spec_binary_labelidx(raw,idx)
    return idx, [instr_text,l]
  elif instr_text == "br_table":               # br_table
    idx,lstar=spec_binary_vec(raw,idx,spec_binary_labelidx)
    idx,lN=spec_binary_labelidx(raw,idx)
    return idx, ["br_table",lstar,lN]
  elif instr_text in {"call","call_indirect"}: # call, call_indirect
    if instr_text=="call":
      idx,x=spec_binary_funcidx(raw,idx)
    if instr_text=="call_indirect":
      idx,x=spec_binary_typeidx(raw,idx)
      if raw[idx]!=0x00: raise Exception("malformed")
      idx+=1
    return idx, [instr_text,x]
  elif 0x20<=instr_binary<=0x22:               # get_local, etc
    idx,x=spec_binary_localidx(raw,idx)
    return idx, [instr_text,x]
  elif 0x23<=instr_binary<=0x24:               # get_global, etc
    idx,x=spec_binary_globalidx(raw,idx)
    return idx, [instr_text,x]
  elif 0x28<=instr_binary<=0x3e:               # i32.load, i64.store, etc
    idx,m = spec_binary_memarg(raw,idx)
    return idx, [instr_text,m]
  elif 0x3f<=instr_binary<=0x40:               # current_memory, grow_memory
    if raw[idx]!=0x00: raise Exception("malformed")
    return idx+1, [instr_text,]
  elif 0x41<=instr_binary<=0x42:               # i32.const, etc
    n=0
    if instr_text=="i32.const":
      idx,n = spec_binary_iN(raw,idx,32)
    if instr_text=="i64.const":
      idx,n = spec_binary_iN(raw,idx,64)
    return idx, [instr_text,n]
  elif 0x43<=instr_binary<=0x44:               # f32.const, etc
    z=0
    if instr_text=="f32.const":
      if len(raw)<=idx+4: raise Exception("malformed")
      idx,z = spec_binary_fN(raw,idx,32)
    if instr_text=="f64.const":
      if len(raw)<=idx+8: raise Exception("malformed")
      idx,z = spec_binary_fN(raw,idx,64)
    return idx, [instr_text,z]
  else:
    #otherwise no immediate
    return idx, [instr_text,]


def spec_binary_instr_inv(node):
  instr_bytes = bytearray()
  #print("spec_binary_instr_inv(",node,")")
  if type(node[0])==str:
    instr_bytes+=bytearray([opcodes_text2binary[node[0]]])
  #the rest is for immediates
  if node[0] in {"block","loop","if"}:         #block, loop, if
    instr_bytes+=spec_binary_blocktype_inv(node[1])
    instar_bytes=bytearray()
    for n in node[2][:-1]:
      instar_bytes+=spec_binary_instr_inv(n)
    if len(node)==4: #if with else
      instar_bytes+=bytearray([0x05])
      for n in node[3][:-1]:
        instar_bytes+=spec_binary_instr_inv(n)
    instar_bytes+=bytes([0x0b])
    instr_bytes+=instar_bytes
  elif node[0] in {"br","br_if"}:              #br, br_if
    instr_bytes+=spec_binary_labelidx_inv(node[1])
  elif node[0] == "br_table":                   #br_table
    instr_bytes+=spec_binary_vec_inv(node[1],spec_binary_labelidx_inv)
    instr_bytes+=spec_binary_labelidx_inv(node[2])
  elif node[0] == "call":                       #call
    instr_bytes+=spec_binary_funcidx_inv(node[1])
  elif node[0] == "call_indirect":              #call_indirect
    instr_bytes+=spec_binary_typeidx_inv(node[1])
    instr_bytes+=bytearray([0x00])
  elif 0x20<=opcodes_text2binary[node[0]]<=0x24:  #get_local, set_local, tee_local
    instr_bytes+=spec_binary_localidx_inv(node[1])
  elif 0x20<=opcodes_text2binary[node[0]]<=0x24:  #get_global, set_global
    instr_bytes+=spec_binary_globalidx_inv(node[1])
  elif 0x28<=opcodes_text2binary[node[0]]<=0x3e:  #i32.load, i32.load8_s, i64.store, etc
    instr_bytes+=spec_binary_memarg_inv(node[1])
  elif 0x3f<=opcodes_text2binary[node[0]]<=0x40:  #memory.size, memory.grow
    instr_bytes+=bytearray([0x00])
  elif node[0]=="i32.const":                    #i32.const
    instr_bytes+=spec_binary_iN_inv(node[1],32)
  elif node[0]=="i64.const":                    #i64.const
    instr_bytes+=spec_binary_iN_inv(node[1],64)
  elif node[0]=="f32.const":                    #i64.const
    instr_bytes+=spec_binary_fN_inv(node[1],32)
  elif node[0]=="f64.const":                    #i64.const
    instr_bytes+=spec_binary_fN_inv(node[1],64)
  return instr_bytes



# 5.4.6 EXPRESSIONS

def spec_binary_expr(raw,idx):
  instar = []
  while raw[idx] != 0x0b:
    idx,ins = spec_binary_instr(raw,idx)
    instar+=[ins]
  if raw[idx] != 0x0b: return idx,None #error
  return idx+1, instar +[['end']]

def spec_binary_expr_inv(node):
  instar_bytes=bytearray()
  for n in node:
    instar_bytes+=spec_binary_instr_inv(n)
  #instar_bytes+=bytes([0x0b])
  return instar_bytes






#############
# 5.5 MODULES
#############

# 5.5.1 INDICES

def spec_binary_typeidx(raw,idx):
  idx, x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_typeidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_funcidx(raw,idx):
  idx,x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_funcidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_tableidx(raw,idx):
  idx,x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_tableidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_memidx(raw,idx):
  idx,x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_memidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_globalidx(raw,idx):
  idx,x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_globalidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_localidx(raw,idx):
  idx,x = spec_binary_uN(raw,idx,32)
  return idx,x

def spec_binary_localidx_inv(node):
  return spec_binary_uN_inv(node,32)

def spec_binary_labelidx(raw,idx):
  idx,l = spec_binary_uN(raw,idx,32)
  return idx,l

def spec_binary_labelidx_inv(node):
  return spec_binary_uN_inv(node,32)


# 5.5.2 SECTIONS

def spec_binary_sectionN(raw,idx,N,B,skip):
  if idx>=len(raw):
    return idx,[] #already at end
  if raw[idx]!=N:
    return idx, []  #this sec not included
  idx+=1
  idx,size = spec_binary_uN(raw,idx,32)
  idx_plus_size = idx+size
  if skip:
    return idx+size,[]
  if N==0: # custom section
    idx, ret = B(raw,idx,idx+size)
  elif N==8: # start section
    idx, ret = B(raw,idx)
  else:
    idx,ret = spec_binary_vec(raw,idx,B)
  if idx != idx_plus_size: raise Exception("malformed")
  return idx,ret

def spec_binary_sectionN_inv(cont,Binv,N):
  if cont==None or cont==[]:
    return bytearray([])
  N_bytes=bytearray([N])
  cont_bytes=bytearray()
  if N==8: #startsec
    cont_bytes=Binv(cont)
  else:
    cont_bytes=spec_binary_vec_inv(cont,Binv)
  size_bytes=spec_binary_uN_inv(len(cont_bytes),32) 
  return N_bytes+size_bytes+cont_bytes


# 5.5.3 CUSTOM SECTION

def spec_binary_customsec(raw,idx,skip):
  customsecstar = []
  idx,customsec = spec_binary_sectionN(raw,idx,0,spec_binary_custom,skip) 
  return idx,customsec

def spec_binary_custom(raw,idx,endidx):
  bytestar=bytearray()
  idx,name = spec_binary_name(raw,idx)
  while idx<endidx:
    idx,byte = spec_binary_byte(raw,idx)
    bytestar+=bytearray([byte])
    if idx!=endidx:
      idx+=1
  return idx,[name,bytestar]

def spec_binary_customsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_custom_inv)
  
def spec_binary_custom_inv(node):
  return spec_binary_name_inv(node[0]) + spec_binary_byte_inv(node[1]) #check this


# 5.5.4 TYPE SECTION

def spec_binary_typesec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,1,spec_binary_functype,skip)

def spec_binary_typesec_inv(node):
  #print("spec_binary_typesec_inv(",node,")")
  return spec_binary_sectionN_inv(node,spec_binary_functype_inv,1)


# 5.5.5 IMPORT SECTION

def spec_binary_importsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,2,spec_binary_import,skip)

def spec_binary_import(raw,idx):
  idx,mod = spec_binary_name(raw,idx)
  idx,nm = spec_binary_name(raw,idx)
  idx,d = spec_binary_importdesc(raw,idx)
  return idx,{"module":mod,"name":nm,"desc":d}

def spec_binary_importdesc(raw,idx):
  if raw[idx]==0x00:
    idx,x=spec_binary_typeidx(raw,idx+1)
    return idx,["func",x]
  elif raw[idx]==0x01:
    idx,tt=spec_binary_tabletype(raw,idx+1)
    return idx,["table",tt]
  elif raw[idx]==0x02:
    idx,mt=spec_binary_memtype(raw,idx+1)
    return idx,["mem",mt]
  elif raw[idx]==0x03:
    idx,gt=spec_binary_globaltype(raw,idx+1)
    return idx,["global",gt]
  else:
    return idx,None #error

def spec_binary_importsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_import_inv,2)

def spec_binary_import_inv(node):
  return spec_binary_name_inv(node["module"]) + spec_binary_name_inv(node["name"]) + spec_binary_importdesc_inv(node["desc"])

def spec_binary_importdesc_inv(node):
  key=node[0]
  if key=="func":
    return bytearray([0x00]) + spec_binary_typeidx_inv(node[1])
  elif key=="table":
    return bytearray([0x01]) + spec_binary_tabletype_inv(node[1])
  elif key=="mem":
    return bytearray([0x02]) + spec_binary_memtype_inv(node[1])
  elif key=="global":
    return bytearray([0x03]) + spec_binary_globaltype_inv(node[1])
  else:
    return bytearray()
  

# 5.5.6 FUNCTION SECTION

def spec_binary_funcsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,3,spec_binary_typeidx,skip)

def spec_binary_funcsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_typeidx_inv,3)


# 5.5.7 TABLE SECTION

def spec_binary_tablesec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,4,spec_binary_table,skip)

def spec_binary_table(raw,idx):
  idx,tt=spec_binary_tabletype(raw,idx)
  return idx,{"type":tt}

def spec_binary_tablesec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_table_inv,4)
  
def spec_binary_table_inv(node):
  return spec_binary_tabletype_inv(node["type"])


# 5.5.8 MEMORY SECTION

def spec_binary_memsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,5,spec_binary_mem,skip)

def spec_binary_mem(raw,idx):
  idx,mt = spec_binary_memtype(raw,idx)
  return idx,{"type":mt}

def spec_binary_memsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_mem_inv,5)
  
def spec_binary_mem_inv(node):
  return spec_binary_memtype_inv(node["type"])


# 5.5.9 GLOBAL SECTION

def spec_binary_globalsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,6,spec_binary_global,skip)

def spec_binary_global(raw,idx):
  idx,gt=spec_binary_globaltype(raw,idx)
  idx,e=spec_binary_expr(raw,idx)
  return idx,{"type":gt,"init":e}

def spec_binary_globalsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_global_inv,6)
  
def spec_binary_global_inv(node):
  return spec_binary_globaltype_inv(node["type"]) + spec_binary_expr_inv(node["init"])


# 5.5.10 EXPORT SECTION

def spec_binary_exportsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,7,spec_binary_export,skip)

def spec_binary_export(raw,idx):
  idx,nm = spec_binary_name(raw,idx)
  #print("nm",nm)
  idx,d = spec_binary_exportdesc(raw,idx)
  #print("d",d)
  return idx,{"name":nm,"desc":d}

def spec_binary_exportdesc(raw,idx):
  if raw[idx]==0x00:
    idx,x=spec_binary_funcidx(raw,idx+1)
    return idx,["func",x]
  elif raw[idx]==0x01:
    idx,x=spec_binary_tableidx(raw,idx+1)
    return idx,["table",x]
  elif raw[idx]==0x02:
    idx,x=spec_binary_memidx(raw,idx+1)
    return idx,["mem",x]
  elif raw[idx]==0x03:
    idx,x=spec_binary_globalidx(raw,idx+1)
    return idx,["global",x]
  else:
    return idx,None #error

def spec_binary_exportsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_export_inv,7)

def spec_binary_export_inv(node):
  return spec_binary_name_inv(node["name"]) + spec_binary_exportdesc_inv(node["desc"])

def spec_binary_exportdesc_inv(node):
  key=node[0]
  if key=="func":
    return bytearray([0x00]) + spec_binary_funcidx_inv(node[1])
  elif key=="table":
    return bytearray([0x01]) + spec_binary_tableidx_inv(node[1])
  elif key=="mem":
    return bytearray([0x02]) + spec_binary_memidx_inv(node[1])
  elif key=="global":
    return bytearray([0x03]) + spec_binary_globalidx_inv(node[1])
  else:
    return bytearray()


# 5.5.11 START SECTION

def spec_binary_startsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,8,spec_binary_start,skip)

def spec_binary_start(raw,idx):
  idx,x=spec_binary_funcidx(raw,idx)
  return idx,{"func":x}

def spec_binary_startsec_inv(node):
  if node==[]:
    return bytearray()
  else:
    return spec_binary_sectionN_inv(node,spec_binary_start_inv,8)

def spec_binary_start_inv(node):
  key=list(node.keys())[0]
  if key=="func":
    return spec_binary_funcidx_inv(node[1])
  else:
    return bytearray()


# 5.5.12 ELEMENT SECTION

def spec_binary_elemsec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,9,spec_binary_elem,skip)

def spec_binary_elem(raw,idx):
  idx,x=spec_binary_tableidx(raw,idx)
  idx,e=spec_binary_expr(raw,idx)
  idx,ystar=spec_binary_vec(raw,idx,spec_binary_funcidx)
  return idx,{"table":x,"offset":e,"init":ystar}

def spec_binary_elemsec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_elem_inv,9)
  
def spec_binary_elem_inv(node):
  return spec_binary_tableidx_inv(node["table"]) + spec_binary_expr_inv(node["offset"]) + spec_binary_vec_inv(node["init"],spec_binary_funcidx_inv)


# 5.5.13 CODE SECTION

def spec_binary_codesec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,10,spec_binary_code,skip)

def spec_binary_code(raw,idx):
  idx,size=spec_binary_uN(raw,idx,32)
  idx_end = idx+size
  idx,code=spec_binary_func(raw,idx)
  if idx_end != idx: raise Exception("malformed")
  if len(code) >= 2**32: raise Exception("malformed")
  return idx,code

def spec_binary_func(raw,idx):
  idx,tstarstar=spec_binary_vec(raw,idx,spec_binary_locals)
  idx,e=spec_binary_expr(raw,idx)
  concattstarstar=[t for tstar in tstarstar for t in tstar] 
  if len(concattstarstar) >= 2**32: raise Exception("malformed")
  return idx, [concattstarstar,e]

def spec_binary_locals(raw,idx):
  idx,n=spec_binary_uN(raw,idx,32)
  idx,t=spec_binary_valtype(raw,idx)
  tn=[t]*n
  return idx,tn

def spec_binary_codesec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_code_inv,10)
  
def spec_binary_code_inv(node):
  func_bytes = spec_binary_func_inv(node)
  return spec_binary_uN_inv(len(func_bytes),32) + func_bytes

def spec_binary_func_inv(node):
  #group locals into chunks
  locals_ = []
  prev_valtype = ""
  for valtype in node[0]:
    if valtype==prev_valtype:
      locals_[-1][0]+=1
    else:
      locals_ += [[1,valtype]]
      prev_valtype = valtype
  locals_bytes = spec_binary_vec_inv(locals_,spec_binary_locals_inv)
  expr_bytes = spec_binary_expr_inv(node[1])
  return locals_bytes + expr_bytes 

def spec_binary_locals_inv(node):
  return spec_binary_uN_inv(node[0],32) + spec_binary_valtype_inv(node[1])
  

# 5.5.14 DATA SECTION

def spec_binary_datasec(raw,idx,skip=0):
  return spec_binary_sectionN(raw,idx,11,spec_binary_data,skip)

def spec_binary_data(raw,idx):
  idx,x=spec_binary_memidx(raw,idx)
  idx,e=spec_binary_expr(raw,idx)
  idx,bstar=spec_binary_vec(raw,idx,spec_binary_byte)
  return idx, {"data":x,"offset":e,"init":bstar}

def spec_binary_datasec_inv(node):
  return spec_binary_sectionN_inv(node,spec_binary_data_inv,11)
  
def spec_binary_data_inv(node):
  return spec_binary_memidx_inv(node["data"]) + spec_binary_expr_inv(node["offset"]) + spec_binary_vec_inv(node["init"],spec_binary_byte_inv)


# 5.5.15 MODULES

def spec_binary_module(raw):
  idx=0
  magic=[0x00,0x61,0x73,0x6d]
  if magic!=[x for x in raw[idx:idx+4]]: raise Exception("malformed")
  idx+=4
  version=[0x01,0x00,0x00,0x00]
  if version!=[x for x in raw[idx:idx+4]]: raise Exception("malformed")
  idx+=4

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,functypestar=spec_binary_typesec(raw,idx,0)
  if verbose==-1: print("functypestar",functypestar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,importstar=spec_binary_importsec(raw,idx,0)
  if verbose==-1: print("importstar",importstar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,typeidxn=spec_binary_funcsec(raw,idx,0)
  if verbose==-1: print("typeidxn",typeidxn)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,tablestar=spec_binary_tablesec(raw,idx,0)
  if verbose==-1: print("tablestar",tablestar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,memstar=spec_binary_memsec(raw,idx,0)
  if verbose==-1: print("memstar",memstar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,globalstar=spec_binary_globalsec(raw,idx,0)
  if verbose==-1: print("globalstar",globalstar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,exportstar=spec_binary_exportsec(raw,idx,0)
  if verbose==-1: print("exportstar",exportstar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,startq=spec_binary_startsec(raw,idx,0)
  if verbose==-1: print("startq",startq)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,elemstar=spec_binary_elemsec(raw,idx,0)
  if verbose==-1: print("elemstar",elemstar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,coden=spec_binary_codesec(raw,idx,0)
  if verbose==-1: print("coden",coden)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  idx,datastar=spec_binary_datasec(raw,idx,0)
  if verbose==-1: print("datastar",datastar)

  while idx<len(raw) and raw[idx]==0:
    idx,customsec = spec_binary_customsec(raw,idx,0)

  funcn=[]
  if typeidxn and coden and len(typeidxn)==len(coden):
    for i in range(len(typeidxn)):
      funcn+=[{"type":typeidxn[i], "locals":coden[i][0], "body":coden[i][1]}]
  mod = {"types":functypestar, "funcs":funcn, "tables":tablestar, "mems":memstar, "globals":globalstar, "elem": elemstar, "data":datastar, "start":startq, "imports":importstar, "exports":exportstar}
  return mod

def spec_binary_module_inv_to_file(mod,filename):
  #print_sections(mod)
  f = open(filename, 'wb')
  magic=bytes([0x00,0x61,0x73,0x6d])
  version=bytes([0x01,0x00,0x00,0x00])
  f.write(magic)
  f.write(version)
  f.write(spec_binary_typesec_inv(mod["types"]))
  f.write(spec_binary_importsec_inv(mod["imports"]))
  f.write(spec_binary_funcsec_inv([e["type"] for e in mod["funcs"]]))
  f.write(spec_binary_tablesec_inv(mod["tables"]))
  f.write(spec_binary_memsec_inv(mod["mems"]))
  f.write(spec_binary_globalsec_inv(mod["globals"]))
  f.write(spec_binary_exportsec_inv(mod["exports"]))
  f.write(spec_binary_startsec_inv(mod["start"]))
  f.write(spec_binary_elemsec_inv(mod["elem"]))
  f.write(spec_binary_codesec_inv([(f["locals"],f["body"]) for f in mod["funcs"]]))
  f.write(spec_binary_datasec_inv(mod["data"]))
  f.close()














##############
##############
# 7 APPENDIX #
##############
##############

# Chapter 7 is the Appendix. It defines a standard embedding, and a validation algorithm.

###############
# 7.1 EMBEDDING
###############

# THE FOLLOWING IS THE API, HOPEFULLY NO FUNCTIONS ABOVE IS CALLED DIRECTLY

# 7.1.1 STORE

def init_store():
  return {"funcs":[], "mems":[], "tables":[], "globals":[]}

# 7.1.2 MODULES

def decode_module(bytestar):
  try:
    mod = spec_binary_module(bytestar)
  except:
    return "malformed"
  return mod
  
def parse_module(codepointstar):
  # text parser not implemented yet
  return -1

def validate_module(module):
  try:
    spec_validate_module(module)
  except Exception as e:
    return "error: invalid"
  return None

def instantiate_module(store,module,externvalstar):
  # we deviate from the spec by also returning the return value
  try:
    ret = spec_instantiate(store,module,externvalstar)
  except Exception as e:
    return store,"error",e.args[0]
  store,F,startret = ret
  modinst = F["module"]
  return store, modinst, startret

def module_imports(module):
  try: spec_validate_module(mod)
  except: return "error: invalid"
  externtypestar, extertypeprimestar = ret
  importstar = module["imports"]
  if len(importstar) != len(externtypestar): return "error: wrong import length"
  result = []
  for i in range(len(importstar)):
    importi = importstar[i]
    externtypei = externtypestar[i]
    resutli = [immporti["module"],importi["name"],externtypei] 
    result += resulti
  return result

def module_exports(module):
  try: ret = spec_validate_module(mod)
  except: return "error: invalid"
  externtypestar, extertypeprimestar = ret
  exportstar = module["exports"]
  assert len(exportstar) == len(externtypeprimestar)
  result = []
  for i in range(len(importstar)):
    exporti = exportstar[i]
    externtypeprimei = externtypeprimestar[i]
    resutli = [exporti["name"],externtypeprimei] 
    result += resulti
  return result


# 7.1.3 EXPORTS

def get_export(moduleinst, name):
  # assume valid so all export names are unique
  for exportinsti in moduleinst["exports"]:
    if name == exportinsti["name"]:
      return exportinsti["value"]
  return "error"

# 7.1.4 FUNCTIONS

def alloc_func(store, functype, hostfunc):
  store, funcaddr = spec_allochostfunc(store,functype,hostfunc)
  return store, funcaddr

def type_func(store,funcaddr):
  if len(store["funcs"]) <= funcaddr: return "error"
  functype = store["funcs"][funcaddr]
  return functype

def invoke_func(store,funcaddr,valstar):
  try: 
    ret = spec_invoke(store,funcaddr,valstar)
  except Exception as e:
    return store,e.args[0]
  return store,ret
  
# 7.1.4 TABLES

def alloc_table(store, tabletype):
  store,tableaddr = spec_alloctable(store,tabletype)
  return store,tableaddr

def type_table(store,tableaddr):
  if len(store["tables"]) <= tableaddr: return "error"
  tableinst = store["tables"][tableaddr]
  max_ = tableinst["max"]
  min_ = len(tableinst["elem"]) #TODO: is this min OK?
  tabletype = [{"min":min_, "max":max_}, "anyfunc"]
  return tabletype

def read_table(store,tableaddr,i):
  if len(store["tables"]) < tableaddr: return "error"
  if type(i)!=int or i < 0: return "error"
  ti = store["tables"][tableaddr]
  if i >= len(ti["elem"]): return "error"
  return ti["elem"][i]

def write_table(store,tableaddr,i,funcaddr):
  if len(store["tables"]) <= tableaddr: return "error"
  if type(i)!=int or i < 0: return "error"
  ti = store["tables"][tableaddr]
  if i >= len(ti["elem"]): return "error"
  ti["elem"][i] = funcaddr
  return store

def size_table(store, tableaddr):
  if len(store["tables"]) <= tableaddr: return "error"
  return len(store["tables"][tableaddr]["elem"])

def grow_table(store, tableaddr, n):
  if len(store["tables"]) <= tableaddr: return "error"
  if type(n)!=int or n < 0: return "error"
  try: spec_growtable(store["tabless"][tableaddr],n)
  except: return "error"
  #store["tables"][tableaddr]["elem"] += [{"elem":[], "max":None} for i in range(n)]  # see spec \S 4.2.7 Table Instances for discussion on uninitialized table elements.
  return store

# 7.1.6 MEMORIES

def alloc_mem(store, memtype):
  store, memaddr = spec_allocmem(store,memtype)
  return store, memaddr

def type_mem(store, memaddr):
  if len(store["mems"]) <= memaddr: return "error"
  meminst = store["mems"][memaddr]
  max_ = meminst["max"]
  min_ = len(meminst["data"])//65536  #page size = 64 Ki = 65536 #TODO: is this min OK?

def read_mem(store, memaddr, i):
  if len(store["mems"]) <= memaddr: return "error"
  if type(i)!=int or i < 0: return "error"
  mi = store["mems"][memaddr]
  if i >= len(mi["data"]): return "error"
  return mi["data"][i]

def write_mem(store,memaddr,i,byte):
  if len(store["mems"]) <= memaddr: return "error"
  if type(i)!=int or i < 0: return "error"
  mi = store["mems"][memaddr]
  if i >= len(mi["data"]): return "error"
  mi["data"][i] = byte
  return store

def size_mem(store,memaddr):
  if len(store["mems"]) <= memaddr: return "error"
  return len(store["mems"][memaddr])//65536  #page size = 64 Ki = 65536

def grow_mem(store,memaddr,n):
  if len(store["mems"]) <= memaddr: return "error"
  if type(n)!=int or n < 0: return "error"
  try: spec_growmem(store["mems"][memaddr],n)
  except: return "error"
  return store

# 7.1.7 GLOBALS
  
def alloc_global(store,globaltype,val):
  try:
    store,globaladdr = spec_allocglobal(store,globaltype,val)
  except:
     return store,"error"
  return store,globaladdr

def type_global(store, globaladdr):
  if len(store["globals"]) <= globaladdr: return "error"
  globalinst = store["globals"][globaladdr]
  mut = globalinst["mut"]
  valtype = globalinst["value"][0]
  return [mut, valtype]

def read_global(store, globaladdr):
  if len(store["globals"]) <= globaladdr: return "error"
  gi = store["globals"][globaladdr]
  return gi["value"]
  
# arg must look like ["i32.const",5]
def write_global(store,globaladdr,val):
  if len(store["globals"]) <= globaladdr: return "error"
  #TODO: type check; handle val without type
  gi = store["globals"][globaladdr]
  if gi["mut"] != "var": return "error"
  gi["value"] = val
  return store
  
  
  
  
  

##########################
# 7.3 VALIDATION ALGORITHM
##########################

# 7.3.1 DATA STRUCTURES

# Conventions:
#   the spec makes opds and ctrls global variables, but we pass them around as arguments
#   the control stack is a python list, which allows fast appending but not prepending. So the spec's index 0 corresponds to python list idx -1, and eg spec idx 3 corresponds to our python list idx -1-3 ie -4
#   the spec offers two ways to keep track of labels, using C.labels in ch 3 or a control stack in the appendix. Here we use the appendix method

def spec_push_opd(opds,type_):
  opds.append(type_)

def spec_pop_opd(opds,ctrls):
  # check if underflows current block, and returns one type
  # but if underflows and unreachable, which can happen if unconditional branch, when stack is typed polymorphically, operands are still pushed and popped to check if code after unreachable is valid, polymorphic stack can't underflow
  if len(opds) == ctrls[-1]["height"] and ctrls[-1]["unreachable"]:
    return "Unknown"
  if len(opds) == ctrls[-1]["height"]: raise Exception("invalid") #error
  if len(opds) == 0: raise Exception("invalid") #error, not in spec
  to_return = opds[-1]
  del opds[-1]
  return to_return

def spec_pop_opd_expect(opds,ctrls,expect):
  actual = spec_pop_opd(opds,ctrls)
  if actual == -1:  raise Exception("invalid") #error
  # in case one is unknown, the more specific one is returned
  if actual == "Unknown":
    return expect
  if expect == "Unknown":
    return actual
  if actual != expect: raise Exception("invalid") #error
  return actual

def spec_push_opds(opds,ctrls,types):
  for t in types:
    spec_push_opd(opds,t)
  return 0

def spec_pop_opds_expect(opds,ctrls,types):
  if types:
    for t in reversed(types):
      r = spec_pop_opd_expect(opds,ctrls,t)
    return r
  else:
    return None

def spec_ctrl_frame(label_types, end_types, height, unreachable):
  #args are:
  #   label_types: type of the branch's label, to type-check branches
  #   end_types: result type of the branch, currently Wasm spec allows at most one return value
  #   height: height of opd_stack at start of block, to check that operands do not underflow current block
  #   unreachable: whether remainder of block is unreachable, to handle stack-polymorphic typing after branches
  return {"label_types":label_types, "end_types":end_types, "height":height, "unreachable":unreachable}

def spec_push_ctrl(opds,ctrls,label,out):
  frame = {"label_types":label,"end_types":out,"height":len(opds),"unreachable":False}
  ctrls.append(frame)

def spec_pop_ctrl(opds,ctrls):
  if len(ctrls)<1:  raise Exception("invalid") #error
  frame = ctrls[-1]
  #verify opd stack has right types to exit block, and pops them
  #print("frame[\"end_types\"]",frame["end_types"])
  r = spec_pop_opds_expect(opds,ctrls,frame["end_types"])
  if r==-1:  raise Exception("invalid") #error
  #make shure stack is back to original height
  if len(opds) != frame["height"]:  raise Exception("invalid") #error
  del ctrls[-1]
  return frame["end_types"]

# extra underscore since spec_unreachable() is used in chapter 4
def spec_unreachable_(opds, ctrls):
  # purge from operand stack, allows stack-polymorphic logic in pop_opd() take effect
  del opds[ ctrls[-1]["height"]: ]
  ctrls[-1]["unreachable"] = True



# 7.3.2 VALIDATION OF OPCODE SEQUENCES

# validate a single opcode based on current context C, operand stack opds, and control stack ctrls
def spec_validate_opcode(C,opds,ctrls,opcode,immediates):
  # print("spec_validate_opcode(",C,"   ",opds,"   ",ctrls,"   ",opcode,"   ",immediates,")")
  # C is the context
  # opds is the operand stack
  # ctrls is the control stack
  opcode_binary = opcodes_text2binary[opcode]
  if 0x00<=opcode_binary<=0x11:			# CONTROL INSTRUCTIONS
    if opcode_binary==0x00:			# unreachable 
      spec_unreachable_(opds,ctrls)
    elif opcode_binary==0x01:			# nop
      pass
    elif opcode_binary<=0x04:			# block, loop, if
      rt = immediates
      if rt!=[] and type(rt)!=list: rt=[rt]  #TODO: clean this up, works but ugly
      if opcode_binary==0x02:			# block
        spec_push_ctrl(opds,ctrls,rt,rt)
      elif opcode_binary==0x03:			# loop
        spec_push_ctrl(opds,ctrls,[],rt)
      else:					# if
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_ctrl(opds,ctrls,rt,rt)
    elif opcode_binary==0x05:			# else
      results = spec_pop_ctrl(opds,ctrls)
      if results!=[] and type(results)!=list: results=[results]
      spec_push_ctrl(opds,ctrls,results,results)
    elif opcode_binary==0x0b:			# end
      results = spec_pop_ctrl(opds,ctrls)
      spec_push_opds(opds,ctrls,results)
    elif opcode_binary==0x0c:			# br
      n = immediates
      if n==None: raise Exception("invalid")
      if len(ctrls) <= n:  raise Exception("invalid")
      spec_pop_opds_expect(opds,ctrls,ctrls[-1-n]["label_types"])
      spec_unreachable_(opds,ctrls)
    elif opcode_binary==0x0d:			# br_if
      n = immediates
      if n==None: raise Exception("invalid")
      if len(ctrls) <= n: raise Exception("invalid")
      spec_pop_opd_expect(opds,ctrls,"i32")
      spec_pop_opds_expect(opds,ctrls,ctrls[-1-n]["label_types"]) 
      spec_push_opds(opds,ctrls,ctrls[-1-n]["label_types"])
    elif opcode_binary==0x0e:			# br_table
      nstar = immediates[0]
      m = immediates[1]
      if len(ctrls)<=m: raise Exception("invalid")
      for n in nstar:
        if len(ctrls)<=n or ctrls[-1-n]["label_types"] != ctrls[-1-m]["label_types"]: raise Exception("invalid")
      spec_pop_opd_expect(opds,ctrls,"i32")
      spec_pop_opds_expect(opds,ctrls,ctrls[-1-m]["label_types"])
      spec_unreachable_(opds,ctrls)
    elif opcode_binary==0x0f:			# return
      if "return" not in C: raise Exception("invalid")
      t = C["return"]
      spec_pop_opds_expect(opds,ctrls,t)
      spec_unreachable_(opds,ctrls)
    elif opcode_binary==0x10:			# call
      x = immediates
      if ("funcs" not in C) or len(C["funcs"])<=x: raise Exception("invalid")
      spec_pop_opds_expect(opds,ctrls,C["funcs"][x][0])
      spec_push_opds(opds,ctrls,C["funcs"][x][1])
    elif opcode_binary==0x11:			# call_indirect
      x = immediates
      if ("tables" not in C) or len(C["tables"])==0: raise Exception("invalid")
      if C["tables"][0][1] != "anyfunc": raise Exception("invalid")
      if len(C["types"])<=x: raise Exception("invalid")
      spec_pop_opd_expect(opds,ctrls,"i32")
      spec_pop_opds_expect(opds,ctrls,C["types"][x][0])
      spec_push_opds(opds,ctrls,C["types"][x][1])
  elif 0x1a<=opcode_binary<=0x1b:		# PARAMETRIC INSTRUCTIONS
    if opcode_binary==0x1a:			# drop
      spec_pop_opd(opds,ctrls)
    elif opcode_binary==0x1b:			# select
      spec_pop_opd_expect(opds,ctrls,"i32")
      t1 = spec_pop_opd(opds,ctrls)
      t2 = spec_pop_opd_expect(opds,ctrls,t1)
      spec_push_opd(opds,t2)
  elif 0x20<=opcode_binary<=0x24:		# VARIABLE INSTRUCTIONS
    if opcode_binary==0x20:			# get_local
      x = immediates
      if len(C["locals"])<=x: raise Exception("invalid")
      if C["locals"][x]=="i32": spec_push_opd(opds,"i32")
      elif C["locals"][x]=="i64": spec_push_opd(opds,"i64")
      elif C["locals"][x]=="f32": spec_push_opd(opds,"f32")
      elif C["locals"][x]=="f64": spec_push_opd(opds,"f64")
      else: raise Exception("invalid")
    if opcode_binary==0x21:			# set_local
      x = immediates
      if len(C["locals"])<=x: raise Exception("invalid")
      if C["locals"][x]=="i32": ret = spec_pop_opd_expect(opds,ctrls,"i32")
      elif C["locals"][x]=="i64": ret = spec_pop_opd_expect(opds,ctrls,"i64")
      elif C["locals"][x]=="f32": ret = spec_pop_opd_expect(opds,ctrls,"f32")
      elif C["locals"][x]=="f64": ret = spec_pop_opd_expect(opds,ctrls,"f64")
      else: raise Exception("invalid")
    if opcode_binary==0x22:			# tee_local
      x = immediates
      if len(C["locals"])<=x: raise Exception("invalid")
      if C["locals"][x]=="i32":
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i32")
      elif C["locals"][x]=="i64":
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i64")
      elif C["locals"][x]=="f32":
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"f32")
      elif C["locals"][x]=="f64":
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"f64")
      else: raise Exception("invalid")
    if opcode_binary==0x23:			# get_global
      x = immediates
      if len(C["globals"])<=x: raise Exception("invalid")
      if C["globals"][x][1]=="i32": spec_push_opd(opds,"i32")
      elif C["globals"][x][1]=="i64": spec_push_opd(opds,"i64")
      elif C["globals"][x][1]=="f32": spec_push_opd(opds,"f32")
      elif C["globals"][x][1]=="f64": spec_push_opd(opds,"f64")
      else: raise Exception("invalid")
    if opcode_binary==0x24:			# set_global
      x = immediates
      if len(C["globals"])<=x: raise Exception("invalid")
      if C["globals"][x][0] != "var": raise Exception("invalid")
      if C["globals"][x][1]=="i32": ret = spec_pop_opd_expect(opds,ctrls,"i32")
      elif C["globals"][x][1]=="i64": ret = spec_pop_opd_expect(opds,ctrls,"i64")
      elif C["globals"][x][1]=="f32": ret = spec_pop_opd_expect(opds,ctrls,"f32")
      elif C["globals"][x][1]=="f64": ret = spec_pop_opd_expect(opds,ctrls,"f64")
      else: raise Exception("invalid")
  elif 0x28<=opcode_binary<=0x40:		# MEMORY INSTRUCTIONS
    if "mems" not in C or len(C["mems"])==0: raise Exception("invalid")
    if opcode_binary<=0x35:
      memarg = immediates
      if opcode_binary==0x28:			# i32.load
        N=32; t="i32"
      elif opcode_binary==0x29:			# i64.load
        N=64; t="i64"
      elif opcode_binary==0x2a:			# f32.load
        N=32; t="f32"
      elif opcode_binary==0x2b:			# f64.load
        N=64; t="f64"
      elif opcode_binary <= 0x2d:		# i32.load8_s, i32.load8_u
        N=8; t="i32"
      elif opcode_binary <= 0x2f:		# i32.load16_s, i32.load16_u
        N=16; t="i32"
      elif opcode_binary <= 0x31:		# i64.load8_s, i64.load8_u
        N=8; t="i64"
      elif opcode_binary <= 0x33:		# i64.load16_s, i64.load16_u
        N=16; t="i64"
      elif opcode_binary <= 0x35:		# i64.load32_s, i64.load32_u
        N=32; t="i64"
      if 2**memarg["align"]>N//8: raise Exception("invalid")
      spec_pop_opd_expect(opds,ctrls,"i32")
      spec_push_opd(opds,t)
    elif opcode_binary<=0x3e:
      memarg = immediates
      if opcode_binary==0x36:			# i32.store
        N=32; t="i32"
      elif opcode_binary==0x37:			# i64.store
        N=64; t="i64"
      elif opcode_binary==0x38:			# f32.store
        N=32; t="f32"
      elif opcode_binary==0x39:			# f64.store
        N=64; t="f64"
      elif opcode_binary==0x3a:			# i32.store8
        N=8; t="i32"
      elif opcode_binary==0x3b:			# i32.store16
        N=16; t="i32"
      elif opcode_binary==0x3c:			# i64.store8
        N=8; t="i64"
      elif opcode_binary==0x3d:			# i64.store16
        N=16; t="i64"
      elif opcode_binary==0x3e:			# i64.store32
        N=32; t="i64"
      if 2**memarg["align"]>N//8: raise Exception("invalid")
      spec_pop_opd_expect(opds,ctrls,t)
      spec_pop_opd_expect(opds,ctrls,"i32")
    elif opcode_binary==0x3f:			# memory.size
      spec_push_opd(opds,"i32")
    elif opcode_binary==0x40:			# memory.grow
      spec_pop_opd_expect(opds,ctrls,"i32")
      spec_push_opd(opds,"i32")
  elif 0x41<=opcode_binary<=0xbf:		# NUMERIC INSTRUCTIONS
    if opcode_binary<=0x44:
      if opcode_binary == 0x41:			# i32.const
        spec_push_opd(opds,"i32")
      elif opcode_binary == 0x42:		# i64.const
        spec_push_opd(opds,"i64")
      elif opcode_binary == 0x43:		# f32.const
        spec_push_opd(opds,"f32")
      else:					# f64.const
        spec_push_opd(opds,"f64")
    elif opcode_binary<=0x4f:
      if opcode_binary==0x45:			# i32.eqz
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i32")
      else:					# i32.eq, i32.ne, i32.lt_s, i32.lt_u, i32.gt_s, i32.gt_u, i32.le_s, i32.le_u, i32.ge_s, i32.ge_u
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i32")
    elif opcode_binary<=0x5a:
      if opcode_binary==0x50:			# i64.eqz
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i32")
      else:					# i64.eq, i64.ne, i64.lt_s, i64.lt_u, i64.gt_s, i64.gt_u, i64.le_s, i64.le_u, i64.ge_s, i64.ge_u
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i32")
    elif opcode_binary<=0x60:			# f32.eq, f32.ne, f32.lt, f32.gt, f32.le, f32.ge
      spec_pop_opd_expect(opds,ctrls,"f32")
      spec_pop_opd_expect(opds,ctrls,"f32")
      spec_push_opd(opds,"i32")
    elif opcode_binary<=0x66:			# f64.eq, f64.ne, f64.lt, f64.gt, f64.le, f64.ge
      spec_pop_opd_expect(opds,ctrls,"f64")
      spec_pop_opd_expect(opds,ctrls,"f64")
      spec_push_opd(opds,"i32")
    elif opcode_binary<=0x78:
      if opcode_binary<=0x69:			# i32.clz, i32.ctz, i32.popcnt
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i32")
      else:					# i32.add, i32.sub, i32.mul, i32.div_s, i32.div_u, i32.rem_s, i32.rem_u, i32.and, i32.or, i32.xor, i32.shl, i32.shr_s, i32.shr_u, i32.rotl, i32.rotr
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i32")
    elif opcode_binary<=0x8a:
      if opcode_binary<=0x7b:			# i64.clz, i64.ctz, i64.popcnt
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i64")
      else:					# i64.add, i64.sub, i64.mul, i64.div_s, i64.div_u, i64.rem_s, i64.rem_u, i64.and, i64.or, i64.xor, i64.shl, i64.shr_s, i64.shr_u, i64.rotl, i64.rotr
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i64")
    elif opcode_binary<=0x98:
      if opcode_binary<=0x91:			# f32.abs, f32.neg, f32.ceil, f32.floor, f32.trunc, f32.nearest, f32.sqrt,
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"f32")
      else:					# f32.add, f32.sub, f32.mul, f32.div, f32.min, f32.max, f32.copysign
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"f32")
    elif opcode_binary<=0xa6:
      if opcode_binary<=0x9f:			# f64.abs, f64.neg, f64.ceil, f64.floor, f64.trunc, f64.nearest, f64.sqrt,
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"f64")
      else:					# f64.add, f64.sub, f64.mul, f64.div, f64.min, f64.max, f64.copysign
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"f64")
    elif opcode_binary<=0xbf:
      if opcode_binary==0xa7:			# i32.wrap/i64
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"i32")
      elif opcode_binary<=0xa9:			# i32.trunc_s/f32, i32.trunc_u/f32
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"i32")
      elif opcode_binary<=0xab:			# i32.trunc_s/f64, i32.trunc_u/f64
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"i32")
      elif opcode_binary<=0xad:			# i64.extend_s/i32, i64.extend_u/i32
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"i64")
      elif opcode_binary<=0xaf:			# i64.trunc_s/f32, i64.trunc_u/f32
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"i64")
      elif opcode_binary<=0xb1:			# i64.trunc_s/f64, i64.trunc_u/f64
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"i64")
      elif opcode_binary<=0xb3:			# f32.convert_s/i32, f32.convert_u/i32
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"f32")
      elif opcode_binary<=0xb5:			# f32.convert_s/i64, f32.convert_u/i64
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"f32")
      elif opcode_binary<=0xb6:			# f32.demote/f64
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"f32")
      elif opcode_binary<=0xb8:			# f64.convert_s/i32, f64.convert_u/i32
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"f64")
      elif opcode_binary<=0xba:			# f64.convert_s/i64, f64.convert_u/i64
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"f64")
      elif opcode_binary==0xbb:			# f64.promote/f32
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"f64")
      elif opcode_binary==0xbc:			# i32.reinterpret/f32
        spec_pop_opd_expect(opds,ctrls,"f32")
        spec_push_opd(opds,"i32")
      elif opcode_binary==0xbd:			# i64.reinterpret/f64
        spec_pop_opd_expect(opds,ctrls,"f64")
        spec_push_opd(opds,"i64")
      elif opcode_binary==0xbe:			# f32.reinterpret/i32
        spec_pop_opd_expect(opds,ctrls,"i32")
        spec_push_opd(opds,"f32")
      else:					# f64.reinterpret/i64
        spec_pop_opd_expect(opds,ctrls,"i64")
        spec_push_opd(opds,"f64")
    else: raise Exception("invalid") #error, opcode not in the correct ranges
  return 0 #success, valid so far
 

# args when called the first time:  
def iterate_through_expression_and_validate_each_opcode(expression,Context,opds,ctrls):
  for node in expression:
    if type(node[0])!=str: raise Exception("invalid") #error
    opcode = node[0]
    #get immediate
    immediate=None
    if node[0] in {"br","br_if","block","loop","if","call","call_indirect","get_local", "set_local", "tee_local","get_global", "set_global","i32.const","i64.const","f32.const","f64.const"} or node[0][3:8] in {".load",".stor"}:
      immediate = node[1]
    elif node[0] == "br_table":
      immediate = [node[1],node[2]]
    #print(opcode,immediate)
    #validate
    spec_validate_opcode(Context,opds,ctrls,opcode,immediate)
    #recurse for block, loop, if
    if node[0] in {"block","loop","if"}:
      iterate_through_expression_and_validate_each_opcode(node[2],Context,opds,ctrls)
      if len(node)==4: #if with else
        iterate_through_expression_and_validate_each_opcode(node[3],Context,opds,ctrls)
  return 0

  
  
  





##########################
# TOOLS FOR PRINTING STUFF
##########################

def print_tree(node,indent=0):
  if type(node)==tuple:
    print(" "*indent+str(node))
  elif type(node) in {list}:
    for e in node:
      print_tree(e,indent+1)
  elif type(node)==dict:
    for e in node:
      print(" "*indent+e)
      print_tree(node[e],indent+1)
  else:
    print(" "*indent+str(node))


def print_tree_expr(node,indent=0):
  #print()
  #print("print_tree_expr(",node,")")
  if type(node)==list and len(node)>0:
    if type(node[0])==str:			# an instruction
      if node[0] in {"block","if","loop"}:
        print(" "*indent+str([node[0],node[1]]))
        print_tree_expr(node[2],indent+1)
        #print(" "*indent+"[end]")
        if node[0] == "if" and len(node)>3:
          print_tree_expr(node[3],indent+1)
      else:
        print(" "*indent+str(node))
    else:					#list of instructions
      for e in node:
        print_tree_expr(e,indent+1)
  else:
    print(" "*indent+str(node))


def print_raw_as_hex(raw):
  print("printing whole module:")
  for i in range(len(raw)):
    print(hex(raw[i]),end=" ")
    if (i+1)%10==0:
      print()
  print()


def print_sections(mod):
  print("types:",mod["types"])
  print()
  print("funcs:",mod["funcs"])
  print()
  for f in mod["funcs"]:
    print()
    print(f)
    print_tree_expr(f["body"])
  print("tables",mod["tables"])
  print()
  print("mems",mod["mems"])
  print()
  print("globals",mod["globals"])
  print()
  print("elem",mod["elem"])
  print()
  print("data",mod["data"])
  print()
  print("start",mod["start"])
  print()
  print("imports",mod["imports"])
  print()
  print("exports",mod["exports"])







##########################################################
# HELPERS TO EXECUTE THIS FILE ON COMMAND LINE ARGUMENTS #
##########################################################


def instantiate_wasm_invoke_start(filename):
  file_ = open(filename, 'rb')
  if not file_: return "error, could not open "+filename
  bytestar = memoryview(file_.read())
  if not bytestar: return "error, could not read "+filename
  module = decode_module(bytestar)	#get module as abstract syntax
  #print("module",module)
  if not module: return "error, could not decode "+filename
  store = init_store()		#do this once for each VM instance
  externvalstar = []			#imports, hopefully none
  store,moduleinst,ret = instantiate_module(store,module,externvalstar)
  if moduleinst == "error": return "error, module could not be instantiated"
  return ret
   

def instantiate_wasm_invoke_func(filename,funcname,args):
  file_ = open(filename, 'rb')
  if not file_: return "error, could not open "+filename
  bytestar = memoryview(file_.read())
  if not bytestar: return "error, could not read "+filename
  module = decode_module(bytestar)	#get module as abstract syntax
  #print("module",module)
  if not module: return "error, could not decode "+filename
  store = init_store()		#do this once for each VM instance
  externvalstar = []			#imports, hopefully none
  store,moduleinst,ret = instantiate_module(store,module,externvalstar)
  if moduleinst == "error": return "error, module could not be instantiated"
  #print("moduleinst",moduleinst)
  externval = get_export(moduleinst, funcname)
  if not externval or externval[0]!="func": return "error, "+funcname+" is not a function export of the module"
  #print("externval",externval)
  funcaddr = externval[1]
  valstar = [["i32.const",int(arg)] for arg in args]
  #print("valstar",valstar)
  store,ret = invoke_func(store,funcaddr,valstar)
  if ret=="trap": return "error, invokation resulted in a trap"
  #print("ret",ret)
  if type(ret)==list and len(ret)>0:
    ret = ret[0]
  return ret




if __name__ == "__main__":
  import sys
  if len(sys.argv) < 2 or sys.argv[1][-5:] != ".wasm":
    print("Help:")
    print("python3 pywebassembly.py <filename>.wasm funcname arg1 arg2 etc")
    print("where funcname is an exported function of the module, followed by its arguments")
    print("if funcname and args aren't present, we invoke the start function")
    exit(-1)
  filename = sys.argv[1]
  ret = None
  if len(sys.argv)==2:
    ret = instantiate_wasm_invoke_start(filename)
  elif len(sys.argv)>2:
    funcname = sys.argv[2]
    args = sys.argv[3:]
    ret = instantiate_wasm_invoke_func(filename,funcname,args)
  print(ret)

