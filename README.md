**Da Vinci Multi-Arm Robot Simulation**

This repository contains a MATLAB script for the simulation and visualization of the Da Vinci surgical robot with a multi-arm system. The code allows loading the robot's structural and kinematic data, computing the transformations of various arms, and visualizing the planned trajectory in a 3D space.
This code was developed as part of the Medical Robotics course in the Master's degree program in Bioengineering at the University of Padua.
Authors: Beatrice Martin, AnnaPegreffi, LorenzoSterzi, ElenaVedova

Main Features

1. Data Loading
The code loads the configuration data for the Da Vinci robot and the operating table (DaVinci_mod.mat and roboCouch.mat files).
The robot's kinematic parameters (link lengths, offsets, and rotation angles) are stored in the params structure.
2. Forward Kinematics
The script calculates the forward kinematics of four robot arms for specific joint configurations (q0, q1, q2, and q3 variables).
Transformation matrices that describe the arms' positions and orientations are computed using the fwdkinDaVinci_arms function.
3. 3D Robot Visualization
The code generates a 3D plot of the robot's configuration, visualizing the arms and the reference frames of the system. It also displays the Denavit-Hartenberg (DH) frames for each arm.
4. Trajectory Planning
A trajectory is planned between an initial and a final position for each arm, using a polynomial law of motion.
The joint trajectories are computed over a time interval, and the code generates smooth transitions for all four arms.
5. Simulation
The robot's movement is animated over time, showing the arms following their respective trajectories.
A video file (Simulazione DaVinci multibraccio Gruppo 6) is generated to record the simulation.
Usage

Clone or download the repository.
Load the provided DaVinci_mod.mat and roboCouch.mat data files into your MATLAB environment.
Run the script to visualize the Da Vinci robot and simulate the planned trajectories.
Requirements

MATLAB with 3D plotting capabilities.
The DaVinci_mod.mat and roboCouch.mat files should be included in the working directory.
Output

A 3D visualization of the robot's kinematics and its movement over time.
A video recording of the simulation, saved as Simulazione DaVinci multibraccio Gruppo 6.mp4.
This project can be useful for understanding the kinematics and motion planning of robotic systems like the Da Vinci surgical robot.
