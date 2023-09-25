# Use Rocky Linux as the base image
FROM rockylinux/rockylinux:8

# Install necessary packages for GUI and VNC server
RUN dnf -y update && \
    dnf -y groupinstall "Server with GUI" && \
    dnf -y install tigervnc-server && \
    dnf clean all

# Set root password for VNC server
RUN echo "VNCPASSWD" | vncpasswd -f > /root/.vnc/passwd

# Set permissions for VNC password file
RUN chmod 600 /root/.vnc/passwd

# Expose VNC server port
EXPOSE 5901

# Start VNC server to access Rocky Linux GUI
CMD ["vncserver", ":1", "-geometry", "1280x800", "-fg"]
