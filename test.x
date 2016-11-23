-- 作者：刘从贤 lcxlinux@163.com


-- 类型测试
print(type(1+2))
print(type("hello world"))
print(type(true,false))

-- 混合测试
print(type(true,123,"hello world"))


-- 测试效率
local main={}
local array={"a","b","c","d","e","f"}

main.func = function()
	for i=1,10000 do 
		if i==1 then
		else
		end
	end
end

main.test = function()
	print("start time:",os.time())
	for i=0,10000 do
		main.func()
	end
	print("end time:",os.time())
end

main.test()


-- 未知1
-- bisect.lua
-- bisection method for solving non-linear equations

delta=1e-6	-- tolerance

function bisect(f,a,b,fa,fb)
 local c=(a+b)/2
 io.write(n," c=",c," a=",a," b=",b,"\n")
 if c==a or c==b or math.abs(a-b)<delta then return c,b-a end
 n=n+1
 local fc=f(c)
 if fa*fc<0 then return bisect(f,a,c,fa,fc) else return bisect(f,c,b,fc,fb) end
end

-- find root of f in the inverval [a,b]. needs f(a)*f(b)<0
function solve(f,a,b)
 n=0
 local z,e=bisect(f,a,b,f(a),f(b))
 io.write(string.format("after %d steps, root is %.17g with error %.1e, f=%.1e\n",n,z,e,f(z)))
end

-- our function
function f(x)
 return x*x*x-x-1
end

-- find zero in [1,2]
solve(f,1,2)

-- hello.lua
-- the first program in every language

io.write("Hello world, from ",_VERSION,"!\n")



-- globals.lua
-- show all global variables

local seen={}

function dump(t,i)
	seen[t]=true
	local s={}
	local n=0
	for k in pairs(t) do
		n=n+1 s[n]=k
	end
	table.sort(s)
	for k,v in ipairs(s) do
		print(i,v)
		v=t[v]
		if type(v)=="table" and not seen[v] then
			dump(v,i.."\t")
		end
	end
end

dump(_G,"")


-- sieve.lua
-- the sieve of Eratosthenes programmed with coroutines
-- typical usage: lua -e N=500 sieve.lua | column

-- generate all the numbers from 2 to n
function gen (n)
  return coroutine.wrap(function ()
    for i=2,n do coroutine.yield(i) end
  end)
end

-- filter the numbers generated by `g', removing multiples of `p'
function filter (p, g)
  return coroutine.wrap(function ()
    for n in g do
      if n%p ~= 0 then coroutine.yield(n) end
    end
  end)
end

N=N or 500		-- from command line
x = gen(N)		-- generate primes up to N
while 1 do
  local n = x()		-- pick a number until done
  if n == nil then break end
  print(n)		-- must be a prime number
  x = filter(n, x)	-- now remove its multiples
end




-- account.lua
-- from PiL 1, Chapter 16

Account = {balance = 0}

function Account:new (o, name)
  o = o or {name=name}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Account:deposit (v)
  self.balance = self.balance + v
end

function Account:withdraw (v)
  if v > self.balance then error("insufficient funds on account "..self.name) end
  self.balance = self.balance - v
end

function Account:show (title)
  print(title or "", self.name, self.balance)
end

a = Account:new(nil,"demo")
a:show("after creation")
a:deposit(1000.00)
a:show("after deposit")
a:withdraw(100.00)
a:show("after withdraw")

-- this would raise an error
--[[
b = Account:new(nil,"DEMO")
b:withdraw(100.00)
--]]
