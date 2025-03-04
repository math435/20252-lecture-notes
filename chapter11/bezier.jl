using PyPlot

# This function creates a blank figure
function figreset()
    ax = [0, 1, 0, 1]
    clf(); axis(ax)
    title("Click to place guidepoints")
end

# Create the initial figure window
figreset()

# Tell user what to do
println("Click figure to place guidepoints.")

# Keep doing this forever
while true

    # Collect the four guidepoints from user input
    gp = zeros(4, 2)
    for i=1:4
        p = ginput()[1]
        gp[i, :] = [p[1], p[2]]
        figreset()
        if i < 3
            plot(gp[1:i,1], gp[1:i,2], "go-")
        else
            plot(gp[1:2,1], gp[1:2,2], "go-")
            plot(gp[3:i,1], gp[3:i,2], "go-")
        end
    end

    # Define x and y
    x = gp[[1,3],1]
    y = gp[[1,3],2]

    # Define α and β
    α = [gp[2,1] - x[1], x[2] - gp[4,1]]
    β = [gp[2,2] - y[1], y[2] - gp[4,2]]

    # Plot the guidepoints
    figreset()
    plot([x[1], x[1]+α[1]], [y[1], y[1]+β[1]], "g-")
    plot([x[2], x[2]-α[2]], [y[2], y[2]-β[2]], "g-")

    # Plot Bézier curve
    tt = range(0, 1, length=1000)
    px = (2(x[1]-x[2]) .+ 3(α[1]+α[2]))*tt.^3 .+
         (3(x[2]-x[1]) .- 3(α[2]+2α[1]))*tt.^2 .+
         3α[1]*tt .+ x[1]
    py = (2(y[1]-y[2]) .+ 3(β[1]+β[2]))*tt.^3 .+
         (3(y[2]-y[1]) .- 3(β[2]+2β[1]))*tt.^2 .+
         3β[1]*tt .+ y[1]
    plot(px, py)

end

