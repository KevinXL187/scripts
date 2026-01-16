# Fedora Kde System

Date : 01/15/2026
Version : Fedora 42

https://docs.fedoraproject.org/en-US/quick-docs/

1. Installing System
    https://docs.fedoraproject.org/en-US/kde/getkde/
    
    Update System before everything else

2. Install Nvidia Drivers and Related 
    https://rpmfusion.org/Howto/NVIDIA
    https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

3. Install Fedora-Hyprland desktop enviroment
    https://github.com/JaKooLit/Fedora-Hyprland/
        * remember no dot files, keep it clean

    config qt5 and qt6 settings for kde plasma and hyprland

4. Basic Setups
    a. Auto-Mount drives
        add each line to auto mount drives based on drive UUID 
            /etc/fstab
    
    b. Configure Default Folders [System Settings -> Locations]
            Desktop Folder -> /home/xinghai/Desktop
            Documents Folder -> /mnt/shared/Documents
            Downloads Folder -> /mnt/shared/Downloads
            Videos Folder -> /mnt/shared/Video
            Pictures Folder -> /mnt/shared/Art
            Music Folder -> /mnt/shared/Music

    c. Setup fcitx5
        set as default input and remove ibus
        add chinese, korean, japanese

5. Complete Virtualization Setup
    https://itsfoss.gitlab.io/post/how-to-install-virtualbox-on-fedora-linux-step-by-step/
    
6. Setup Default Applications
    a. Setup Browser Librewolf
        install librewolf
        import previous profile data
        set as default in kde plasma ->
            System Settings -> Default Applications -> web browser
        set as default in hyprland
    
    b. Setup media player 
        install mpv media player
        set as default in kde plasma ->
            System Settings -> Default Appllications -> muisc/vido player
        set as default in hyprland

    c. Set Other defualt applications
        set kitty as terminal emulator
        set dolphin as file manager

    d. Setup Dolphin 
        hide Remove and Recent from Quick Access
        hide Desktop from Places in Quick Access
        Add Code to Dolphin Quick Access Places

7. Complete Local GenAI Setup
    a. Install ollama -> sudo dnf install ollama
        customize ollama model location to ->
            /mnt/linux_data/Local Chatbot/models/ollama_models/

    b. Install docker -> sudo dnf install moby-engine docker-compose
        https://linuxcapable.com/how-to-install-docker-on-fedora-linux/
        customize docker data location to ->
            /home/xinghai/docker

    c. Setting Up Docker Container of Openwebui and Ollama
        run docker compose up on ~/open-webui/docker-compose.yaml
            pulls image of ollama and build openwebui 
                (might not be needed complete copying of docker data to new sys)
        
    d. Add to Startup
        add folder opt/scripts and chotbot_*.sh to dir
        add chatbot_startup.service to 
            /etc/systemd/system/
        add service to startup via systemctl enable *.service

8. Setup PostgreSQL Database
    sudo dnf install postgresql-server postgresql-contrib
        https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
    configing PostgreSQL
        postgresql.service.d/ -> /etc/systemd/system/ [data setting]
        update /var/lib/pgsql/data/pg_hba.conf 

    pgAdmin4[https://www.pgadmin.org/download/pgadmin-4-rpm/]

9. Complete Productivity Setup
    a. Setup LaTeX 
        sudo dnf install texlive-scheme-full
        install texlive-chktex, LateXML, lyx
        texstudio
    
    b. Setup Office Producitivity
        sudo dnf install 

10. Complete Programming Setup
        setup git configs with ssh
        install vscodium

    a. Python 
        pyenv

    b. R
        RStudio

11. Remove overlapping and useless Programs

12. Complete Gaming Setup
