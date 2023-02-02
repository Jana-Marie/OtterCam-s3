# OtterCam-s3

Open source 1080p60Hz USB & IP camera based on Sochip s3 and OS05A10/OS05A20 (general MIPI CSI IP camera interface).

In the current state the camera does boot and the sensor shows up under linux, however no video or image files have been captured yet, as the sensor driver is currently being written by us. All hardware files are tested in the current revision and are, except for some minor changes, final. Still no waranty as this is an open source project. CAD files have been designed with OpenSCAD and should be final too.

<table>
  <tbody>
    <tr>
      <td>
        <img src="/images/c1.JPG"/>
      </td>
      <td>
        <img src="/images/c2.JPG"/>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <img src="/images/o2.JPG"/>
      </td>
    </tr>
    <tr>
      <td>
        <img src="/images/d1.JPG"/>
      </td>
      <td>
        <img src="/images/1.jpg"/>
      </td>
    </tr>
  </tbody>
</table>


### Todo
 - [ ] Test mipi driver
 - [ ] Build userspace code

### Issues
 - [x] MIPI Lanes Sensor are switched
 - [x] No I2C Pullups

### License

Copyright Jana Marie Hemsing 2022.

This source describes Open Hardware and is licensed under the CERN-OHL-S v2.

You may redistribute and modify this source and make products using it under
the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt).

This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,
INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A
PARTICULAR PURPOSE. Please see the CERN-OHL-S v2 for applicable conditions.

Source location: https://github.com/Jana-Marie/OtterCam-s3

As per CERN-OHL-S v2 section 4, should You produce hardware based on this
source, You must where practicable maintain the Source Location visible
on the external case of the Gizmo or other products you make using this
source.
