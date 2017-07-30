function [ ] = setSizeOfWorld(xaxis, yaxis, zaxis)

xlim([-xaxis xaxis])
ylim([-yaxis yaxis])
zlim([0 zaxis])
rotate3d on;

end

