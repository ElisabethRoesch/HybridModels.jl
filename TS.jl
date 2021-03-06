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

# derivative for TS
function dudt(u, ps, t)
   # the five states
   sg4, sg1, sg4t4, N1, N2 = u
   # AHL Ara and params
   AHL, Ara, p1, p2, p3, p4, p5, p6, p7 = ps
   # mass action kinetics
   dsg4 = AHL*p1
   dsg1 = Ara*p2 + N1*p3
   dsg4t4 = N2*p4
   dN1 = -sg4*p5 - sg4t4*p6 + sg1*p7
   dN2 = -dN1
   # control total nmbr of particles?
   # if N1+dN1 >= N1+N2 || N2+dN2 >= N1+N2
   #    dN1=0
   #    dn2=0
   # end
   du = [dsg4, dsg1, dsg4t4, dN1, dN2]
   return du
end

# test setting
u0=[2.,2,3,1,10]
ps=[0.,2.,.1,.1,.1,.1,.1,.1,.1]
tspan = (0.0,10.0)
prob =ODEProblem(dudt, u0, tspan, ps)

# solve example
sol = Array(solve(prob))

# visualise sol
plot(sol[1,:], label = "sg4")
plot!(sol[2,:], label = "sg1")
plot!(sol[3,:], label = "sg4t4")
plot!(sol[4,:], label = "N1")
plot!(sol[5,:], label = "N2")
