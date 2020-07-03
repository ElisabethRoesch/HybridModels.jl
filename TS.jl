using DifferentialEquations
using Plots

# mutable struct TS
#    N1_0::Float64
#    N2_0::Float64
#
#    AHL_0::Float64
#    Ara_0::Float64
#
#    sg4_0::Float64
#    sg1_0::Float64
#    sg4t4_0::Float64
# end

# function simulate(TS)
#    print("a")
#
# end
# ts = TS(simulate,1.,1.,1.,1.,1.,1.,1.)
# ts.simulate(range(0,stop=10))

function f(u, ps, t)
   #the five states
   sg4, sg1, sg4t4, N1, N2 = u
   # AHL Ara and params
   AHL, Ara, p1, p2, p3, p4, p5, p6, p7 = ps
   dsg4 = AHL*p1
   dsg1 = Ara*p2 + N1*p3


   dsg4t4 = N2*p4

   dN1 = -sg4*p5 - sg4t4*p6 + sg1*p7
   dN2 = -dN1
   print(N1+N2)
   if N1+dN1 >= N1+N2 || N2+dN2 >= N1+N2
      dN1=0
      dn2=0
   end

   du = [dsg4, dsg1, dsg4t4, dN1, dN2]
   # println(du...)
   return du
end
u0=[2,2,3,0,100]
ps=[0.,2.,.1,.1,.1,.1,.1,.1,.1]
tspan = (0.0,50.0)
prob =ODEProblem(f, u0, tspan, ps)
sol = Array(solve(prob))
plot(sol[1,:], label = "sg4")
plot!(sol[2,:], label = "sg1")
plot!(sol[3,:], label = "sg4t4")
plot!(sol[4,:], label = "N1")
plot!(sol[5,:], label = "N2")
