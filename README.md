
[![LinkedIn][linkedin-shield]][linkedin-url]

<p align="center">
  <h3 align="center">FPGA CAR ALARM</h3>
  <p align="center">
    FPGA Altera DE2i-150 board to simulation car alarm with remote control
  </p>
</p>

## Click to youtube

[![IMAGE ALT TEXT](http://img.youtube.com/vi/CYgWz0DFw2g/0.jpg)](http://www.youtube.com/watch?v=CYgWz0DFw2g)

<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li><a href="#About The Project">About The Project</a></li>
    <li><a href="#Project Requirements">Project Requirements</a></li>
    <li><a href="#Design Diagram">Design Diagram</a></li>
    <li><a href="#Functionalities">Functionalities</a></li>
    <li><a href="#Evalution">Evalution</a></li>
	<li><a href="#Contact">Contact</a></li>
  </ol>
</details>


## About The Project
This security system will provide the owner with a range of notifications regarding their vehicle. The system will know when someone has started the vehicle’s engine without you in the car and provide an alert. The system can also provide alerts for unusual vibrations, such as when someone is trying to break into the vehicle. It will send an alert if the device has been disconnected and if the vehicle is being moved. It can also provide real-time tracking. The system keeps you fully updated about everything thats happening with the vehicle, so you can alert the authorities if it is stolen. To solve this program i create this project to simulation the FSM to solve program above

![pp](/images/de2.jpg)


## Project Requirements

* Altera DE2i-150 board
* USB cable to upload program to the board 
* Power cable for board 
* Quartus II Software 
* Remote 


## Design Diagram

![dd](/images/dd.png)

there are all block for this system,  aflter implement this in verilog i can simulation this FSM

## Functionalities

There are three mains functionalities: 
* Alert mode: 
using remote => Press A to activate, press A again to inactivate 
When car in alert mode => press any key, switch to active sensors => system is put into intrusion and the siren operating with running leds, LCD displays 
* Finding car mode: 
using remote => Press B to activate, press A again to inactivate 
When car in finding car mode, siren operating with leds, LCD displays 
* Car operation (Verify password) mode:
using remote => Press C to activate, press C again to inactivate 
When car in car operation mode => press from 0 to 9 to set available password (4 numbers) => press up button to show password on LCD => press down button to check password 
If password is right (2541) => show “right” signals on LCD and led running 
If not => show “wrong” signals on LCD and ask to set password again

## Evalution

![ev](/images/ev.png)

I using the evalution test FSM in Quartus II to making the transition point to test my FSM in simulatio. we can the result from the youtube link

## Contact

Hieu Nguyen - [Linkedin](https://www.linkedin.com/in/hieunguyen-dev/)

Linkedin: https://www.linkedin.com/in/hieunguyen-dev/
Email: hnhieu979@gmail.com
Phone: 0927931496
Facebook: https://www.facebook.com/hieu.nguyenmixed

Project Link: [https://github.com/HieuNguyenHuu/fpga_caralarm](https://github.com/HieuNguyenHuu/fpga_caralarm)


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/hieunguyen-dev/


